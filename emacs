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

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(set-face-foreground 'font-lock-comment-face "deep sky blue")
(set-face-foreground 'font-lock-negation-char-face "brightred")
(set-face-foreground 'font-lock-string-face "red")
(set-face-foreground 'font-lock-doc-face "cyan")

;; Get rid of the toolbar
(if window-system
    (progn
      (require 'powerline)
      (tool-bar-mode -1)
      (scroll-bar-mode -1)
      (load-theme 'spolsky t)
      (server-start))
  (set-face-foreground 'minibuffer-prompt "deep sky blue"))

; ido-mode
(ido-mode)
(ido-everywhere 1)

;; For git commit messages
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . diff-mode))


(setq vc-handled-backends nil)
(setq inhibit-startup-message t)

(add-hook 'prog-mode-hook
	  ; Show trailing whitespace
	  (setq-default show-trailing-whitespace t))

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

(setq c-default-style "linux-tabs-only")

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


; For diff
(setq diff-switches "-u")
(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "medium spring green")
     (set-face-background 'diff-added nil)
     (set-face-foreground 'diff-removed "red")
     (set-face-background 'diff-removed nil)
     (set-face-foreground 'diff-header "yellow")
     (set-face-background 'diff-header nil)
     (set-face-background 'diff-file-header nil)))

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
(setq org-agenda-files (list "~/org/appointments.org"
			     "~/org/gtd.org"
			     "~/org/calendar.org"
			     ))

; Line filling
(setq-default fill-column 79)

; Default tab width is 8
(setq default-tab-width 8)

;; Emulate vi '%' command
;;(global-set-key (kbd "C-%") 'match-paren)
;;(defun match-paren (arg)
;;  "Go to the matching parenthesis if on parenthesis, otherwise insert %.
;;vi style of % jumping to matching brace."
;;  (interactive "p")
;;  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;;	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;;	(t (self-insert-command (or arg 1)))))

(load "~/.emacs.d/site-lisp/cocci.el")
(setq auto-mode-alist
      (cons '("\\.cocci$" . cocci-mode) auto-mode-alist))
(autoload 'cocci-mode "cocci"
  "Major mode for editing cocci code." t)


(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(delete-selection-mode nil)
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "imap.suse.de")
 '(smtpmail-smtp-service 25))

(defun insert-sob()
  "Insert Signed-off-by line"
  (interactive)
  (insert "Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>"))

(defun insert-revb()
  "Insert Reviewed-by line"
  (interactive)
  (insert "Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>"))

(defun insert-ack()
  "Insert Acked-by line"
  (interactive)
  (insert "Acked-by: Johannes Thumshirn <jthumshirn@suse.de>"))

(defun insert-suse-tags()
  "Insert SUSE kernel patch tags"
  (interactive)
  (insert "References:\nGit-Commit:\nPatch-Mainline:"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(control shift up)] 'move-line-up)
(global-set-key [(control shift down)] 'move-line-down)


(setq bbdb-file "~/.emacs.d/bbdb")
(require 'message)
(require 'bbdb)
(require 'bbdb-gnus)
(bbdb-initialize)
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)

(setq require-final-newline t)

(require 'evil)
(evil-mode t)
