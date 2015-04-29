;; No backup files please
(setq make-backup-files nil)
(setq auto-save-default nil)

;; No backup files, thx
(setq make-backup-files nil)

;; Paren matching
(show-paren-mode 1)
(setq show-paren-style 'expression)

;; Goto line number
(global-set-key "\M-g" 'goto-line)

;; Always show column number
(column-number-mode 1)

;; Show linue numbers
(global-linum-mode 1)

;; Get rid of the toolbar
(if window-system
    (tool-bar-mode -1))

(if window-system
    (server-start))

(add-to-list 'load-path "~/.emacs.d/site-lisp")
;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; (load-theme 'solarized-dark t)

(autoload 'gtags-mode "gtags" "" t)
(add-hook 'gtags-mode-hook
	  (lambda()
	    (local-set-key (kbd "M-.") 'gtags-find-tag)
	    (local-set-key (kbd "M-*") 'gtags-pop-stack)
	    (local-set-key (kbd "M-,") 'gtags-find-rtag)))
; ido-mode
(ido-mode)
(ido-everywhere 1)

;; For git commit messages
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . diff-mode))


(setq vc-handled-backends nil)
(setq inhibit-startup-message t)

;; Linux kernel C Mode as from src/linux/Documentation/CodingStyle Chap 9.
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-common-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))

(defun my-c-mode-font-lock-if0 (limit)
  (save-restriction
    (widen)
    (save-excursion
      (goto-char (point-min))
      (let ((depth 0) str start start-depth)
        (while (re-search-forward "^\\s-*#\\s-*\\(if\\|else\\|endif\\)" limit 'move)
          (setq str (match-string 1))
          (if (string= str "if")
              (progn
                (setq depth (1+ depth))
                (when (and (null start) (looking-at "\\s-+0"))
                  (setq start (match-end 0)
                        start-depth depth)))
            (when (and start (= depth start-depth))
              (c-put-font-lock-face start (match-beginning 0) 'font-lock-comment-face)
              (setq start nil))
            (when (string= str "endif")
              (setq depth (1- depth)))))
        (when (and start (> depth 0))
          (c-put-font-lock-face start (point) 'font-lock-comment-face)))))
  nil)

(defun my-c-mode-common-hook ()
  (font-lock-add-keywords
   nil
   '((my-c-mode-font-lock-if0 (0 font-lock-comment-face prepend))) 'add-to-end))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(add-hook 'c-mode-hook
	  (lambda ()
	    (gtags-mode t)))

(add-hook 'c-mode-hook
	  '(lambda ()
	     (setq indent-tabs-mode t)
	     (c-set-style "linux-tabs-only")))

; Delete trailing whitespace on save
;(add-hook 'before-save-hook 'delete-trailing-whitespace)
; Show trailing whitespace
(setq-default show-trailing-whitespace t)

; For diff
(setq diff-switches "-u")
(eval-after-load 'diff-mode
 '(progn
    (set-face-foreground 'diff-added "green4")
;    (set-face-background 'diff-added "black")
;    (set-face-background 'diff-removed "black")
    (set-face-foreground 'diff-removed "red3")))


; Org mode keybindings
(require 'org-install)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-reverse-note-order t)

;; Org notes
(global-set-key (kbd "C-c r") 'remember)
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(setq org-remember-templates
      '((?n "* %U %?\n\n %i\n %a" "~/org/notes.org")))
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))

;; Org agend
(setq org-agenda-files (list "~/org/appointments.org"))

; Line filling
(setq-default fill-column 80)

; Default tab width is 8
(setq default-tab-width 8)

;; Emulate vi '%' command
(global-set-key (kbd "C-%") 'match-paren)
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert %.
vi style of % jumping to matching brace."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))

(load "~/.emacs.d/site-lisp/cocci.el")
(setq auto-mode-alist
      (cons '("\\.cocci$" . cocci-mode) auto-mode-alist))
(autoload 'cocci-mode "cocci"
  "Major mode for editing cocci code." t)


(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(require 'srefactor)
(semantic-mode 1)
(define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
(define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)

(require 'org-caldav)
(setq org-caldav-url "https://www.google.com/calendar/dav")
(setq org-caldav-calendar-id "morbidrsa@gmail.com")
(setq org-caldav-files "~/org/appointments.org")

(require 'epg-config)
(setq mml2015-use 'epg

      mml2015-verbose t
      epg-user-id "4B1107EF"  ;;gpgpgpkeyID
      mml2015-encrypt-to-self t
      mml2015-always-trust nil
      mml2015-cache-passphrase t
      mml2015-passphrase-cache-expiry '36000
      mml2015-sign-with-sender t

      gnus-message-replyencrypt t
      gnus-message-replysign t
      gnus-message-replysignencrypted t
      gnus-treat-x-pgp-sig t

      ;;       mm-sign-option 'guided
      ;;       mm-encrypt-option 'guided
      mm-verify-option 'always
      mm-decrypt-option 'always

      gnus-buttonized-mime-types
      '("multipart/alternative"
	"multipart/encrypted"
	"multipart/signed")

      epg-debug t ;;  then read the *epg-debug*" buffer
      )
(when (not (display-graphic-p))
  (setq epg-gpg-program "/usr/bin/gpg1"))
