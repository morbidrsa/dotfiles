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
;(setq show-paren-style 'expression) ; highlight entire bracket expression

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

(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match (expand-file-name "~/src/linux")
                                       filename))
                (setq indent-tabs-mode t)
                (c-set-style "linux-tabs-only")))))
