;;; jsled, 2001.12.10 -- *grrr* This pisses me off...
(defun save-buffers-kill-emacs-with-confirm ()
 "jsled's special save-buffers-kill-emacs, but with confirm"
 (interactive)
 (if (null current-prefix-arg)
     (if (y-or-n-p "Aww, you're leaving so soon????")
         (save-buffers-kill-emacs))
     (save-buffers-kill-emacs)))
(global-set-key "\C-x\C-c" 'save-buffers-kill-emacs-with-confirm)



(setq frame-title-format
      '("" invocation-name ": "
        (:eval
         (if buffer-file-name
             (abbreviate-file-name buffer-file-name)
           "%b"))))




;; keep the point out of the minibuffer
(setq-default minibuffer-prompt-properties '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt))

(use-package vlf
  :defer t
  :config

  )

(use-package htmlize
  :defer t
  :config

  )

(use-package pyvenv
  :defer t
  :config

  )

(setq py-python-command "python3")
(setq python-shell-interpreter "python3")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mini-frame-show-parameters '((top . 0) (width . 0.7) (left . 0.5) (height . 15)))
 '(org-file-apps
   '((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ;; ("\\.pdf\\'" . "opera %s")
     ))     ;changes what default app org mode uses to open pdf files
 '(wakatime-python-bin nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-ui-doc-background ((t (:background nil))))
 '(lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic))))))


(setq org-adapt-indentation nil)


(global-set-key (kbd "C-c o")'hippie-expand)



;; (use-package pdf-continuous-scroll-mode
;;   :type git :host github :repo "dalanicolai/pdf-continuous-scroll-mode.el"
;;   :init
;;   (add-hook 'pdf-view-mode-hook 'pdf-continuous-scroll-mode)

;;   )

;; (straight-use-package
;;  '(pdf-continuous-scroll-mode :type git :host github :repo "dalanicolai/pdf-continuous-scroll-mode.el")
;;  :init
;;  (add-hook 'pdf-view-mode-hook 'pdf-continuous-scroll-mode)

;;  )


;;     (setq dcsh-command-list '("all_registers"
;;                               "check_design" "check_test" "compile" "current_design"
;;                               "link" "uniquify"
;;                               "report_timing" "report_clocks" "report_constraint"
;;                               "get_unix_variable" "set_unix_variable"
;;                               "set_max_fanout"
;;                               "report_area" "all_clocks" "all_inputs" "all_outputs"))

;;     (defun he-dcsh-command-beg ()
;;       (let ((p))
;;         (save-excursion
;;           (backward-word 1)
;;           (setq p (point)))
;;         p))

;;     (defun try-expand-dcsh-command (old)
;;       (unless old
;;         (he-init-string (he-dcsh-command-beg) (point))
;;         (setq he-expand-list (sort
;;                               (all-completions he-search-string (mapcar 'list dcsh-command-list))
;;                               'string-lessp)))
;;       (while (and he-expand-list
;;               (he-string-member (car he-expand-list) he-tried-table))
;;         (setq he-expand-list (cdr he-expand-list)))
;;       (if (null he-expand-list)
;;           (progn
;;             (when old (he-reset-string))
;;             ())
;;         (he-substitute-string (car he-expand-list))
;;         (setq he-tried-table (cons (car he-expand-list) (cdr he-tried-table)))
;;         (setq he-expand-list (cdr he-expand-list))
;;         t))


;; (global-set-key (kbd "C-c i") (make-hippie-expand-function
;;                              '(try-expand-dcsh-command
;;                                try-expand-dabbrev-visible
;;                                try-expand-dabbrev
;;                                try-expand-dabbrev-all-buffers) t))


;; (use-package pabbrev
;;   :defer t
;;   :config

;;   )

(use-package company-jedi
  :defer t
  :config

  )

(use-package autothemer :ensure t)

(straight-use-package
 '(rose-pine-emacs
   :host github
   :repo "Caelie/rose-pine-emacs"
   :branch "master"))
;; (load-theme 'rose-pine-{color-moon-dawn} t)

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

;; (global-hl-line-mode -1)

;; (setq x-underline-at-descent-line t)

;; No ugly button for checkboxes
(setq widget-image-enable nil)

;; Hide org markup for README
(setq org-hide-emphasis-markers t)


(add-to-list 'load-path "~/.emacs.d/nano-emacs")

;; (require 'nano)
;; (require 'nano-theme-dark)
(require 'nano-modeline)
(require 'nano-faces)
;; Compact layout (need to be loaded after nano-modeline)
;; (when (member "-compact" command-line-args)
;;   (require 'nano-compact))
;; (require 'nano-compact)


;; ;; Compact layout (need to be loaded after nano-modeline)
;; (when (member "-compact" command-line-args)
;;   (require 'nano-compact))

;; Splash (optional)
(unless (member "-no-splash" command-line-args)
  (require 'nano-splash))

;; latex loads-------------------------------------------------------------


(use-package auctex-latexmk
  :ensure t
  :config
  (auctex-latexmk-setup)
  (setq auctex-latexmk-inherit-TeX-PDF-mode t))

(use-package reftex
  :ensure t
  :defer t
  :config
  (setq reftex-cite-prompt-optional-args t)) ;; Prompt for empty optional arguments in cite

(use-package auto-dictionary
  :ensure t
  :init(add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1))))

(use-package company-auctex
  :ensure t
  :init (company-auctex-init))

;; (use-package tex
;;   :ensure auctex
;;   :mode ("\\.tex\\'" . latex-mode)
;;   :config (progn
;; 	    (setq TeX-source-correlate-mode t)
;; 	    (setq TeX-source-correlate-method 'synctex)
;; 	    (setq TeX-auto-save t)
;; 	    (setq TeX-parse-self t)
;; 	    (setq-default TeX-master "paper.tex")
;; 	    (setq reftex-plug-into-AUCTeX t)
;; 	    (pdf-tools-install)
;; 	    (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
;; 		  TeX-source-correlate-start-server t)
;; 	    ;; Update PDF buffers after successful LaTeX runs
;; 	    (add-hook 'TeX-after-compilation-finished-functions
;; 		      #'TeX-revert-document-buffer)
;; 	    (add-hook 'LaTeX-mode-hook
;; 		      (lambda ()
;; 			(reftex-mode t)
;; 			(flyspell-mode t)))
;; 	    ))



(provide 'my-testing-stuff)
