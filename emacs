;; No backup files please
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Python mode
(autoload 'python-mode "python-mode.el" "Python mode." t)
(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))

;; Muttrc mode
(autoload 'muttrc-mode "muttrc-mode.el"
  "Major mode to edit muttrc files" t)
(setq auto-mode-alist (append '(("muttrl\\'" . muttrc-mode))
			      auto-mode-alist))

;; PKGBUILD mode
(autoload 'pkgbuild-mode "pkgbuild-mode.el" "PKGBUILD mode." t)
(setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode)) auto-mode-alist))

;; No backup files, thx
(setq make-backup-files nil)

;; Paren matching
(show-paren-mode 1)
(setq show-paren-style 'expression)

;; Goto line number
(global-set-key "\M-g" 'goto-line)

;; Always show column number
(column-number-mode 1)

;;
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . diff-mode))

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

;;(add-hook 'c-mode-hook
;;          (lambda ()
;;            (let ((filename (buffer-file-name)))
;;              ;; Enable kernel mode for the appropriate files
;;              (when (and filename
;;                         (string-match (expand-file-name "~/src/linux")
;;                                       filename))
;;                (setq indent-tabs-mode t)
;;                (c-set-style "linux-tabs-only")))))
(add-hook 'c-mode-hook
	  '(lambda ()
	     (setq indent-tabs-mode t)
	     (c-set-style "linux-tabs-only")))

; Delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; For diff
(setq diff-switches "-u")
(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
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
      '((?n "* %U %?\n\n %i\n %a" "~/notes.org")))
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))

; For mutt
(setq auto-mode-alist (append '(("/tmp/mutt.*" . mail-mode)) auto-mode-alist))


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
