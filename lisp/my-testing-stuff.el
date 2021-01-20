;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; language server protocol code
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (use-package helm-lsp
;;   :ensure t
;;   :after (lsp-mode)
;;   :commands (helm-lsp-workspace-symbol)
;;   :init (define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-workspace-symbol))

(use-package lsp-mode
  :diminish (lsp-mode . "lsp")
  :bind (:map lsp-mode-map
	 ("C-c C-d" . lsp-describe-thing-at-point))
  :hook ((python-mode . lsp-deferred)
	 (js-mode . lsp-deferred)
	 (js2-mode . lsp-deferred)
	 (dockerfile-mode . lsp-deferred)
	 (sh-mode . lsp-deferred)
	 (typescript-mode . lsp-deferred)
	 (go-mode . lsp-deferred))
  :init
  (setq lsp-auto-guess-root t       ; Detect project root
	lsp-log-io nil
	lsp-enable-indentation t
	lsp-enable-imenu t
	lsp-keymap-prefix "C-c l"
	lsp-enable-file-watchers t

	lsp-file-watch-threshold 5000
	lsp-prefer-flymake nil)      ; Use lsp-ui and flycheck

  (defun lsp-on-save-operation ()
    (when (or (boundp 'lsp-mode)
	      (bound-p 'lsp-deferred))
      (lsp-organize-imports)
      (lsp-format-buffer))))

;; (use-package lsp-clients
;;   :ensure nil
;;   :after (lsp-mode)
;;   :init (setq lsp-clients-python-library-directories '("/usr/local/" "/usr/")))

(use-package lsp-ui
  :ensure t
  :after (lsp-mode)
  :commands lsp-ui-doc-hide
  :bind (:map lsp-ui-mode-map
	      ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
	      ([remap xref-find-references] . lsp-ui-peek-find-references)
	      ("C-c u" . lsp-ui-imenu))
  :init (setq lsp-ui-doc-enable t
	      lsp-ui-doc-use-webkit nil
	      lsp-ui-doc-header nil
	      lsp-ui-doc-delay 0.2
	      lsp-ui-doc-include-signature t
	      lsp-ui-doc-alignment 'at-point
	      lsp-ui-doc-use-childframe nil
	      lsp-ui-doc-border (face-foreground 'default)
	      lsp-ui-peek-enable t
	      lsp-ui-peek-show-directory t
	      lsp-ui-sideline-delay 10
	      lsp-ui-sideline-update-mode 'point
	      lsp-ui-sideline-enable t
	      lsp-ui-sideline-show-code-actions t
	      lsp-ui-sideline-show-hover t
	      lsp-ui-sideline-ignore-duplicate t
	      lsp-gopls-use-placeholders nil)
  :config
  (setq lsp-completion-provider :capf)
  (setq lsp-idle-delay 0.500)
  (setq lsp-print-performance t)

  (add-to-list 'lsp-ui-doc-frame-parameters '(right-fringe . 8))

  ;; `C-g'to close doc
  (advice-add #'keyboard-quit :before #'lsp-ui-doc-hide)

  ;; Reset `lsp-ui-doc-background' after loading theme
  (add-hook 'after-load-theme-hook
	    (lambda ()
	      (setq lsp-ui-doc-border (face-foreground 'default))
	      (set-face-background 'lsp-ui-doc-background
				   (face-background 'tooltip))))

  ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
  ;; @see https://github.com/emacs-lsp/lsp-ui/issues/243
  (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
    (setq mode-line-format nil)))



(setq frame-title-format
      '("" invocation-name ": "
        (:eval
         (if buffer-file-name
             (abbreviate-file-name buffer-file-name)
           "%b"))))


(provide 'my-testing-stuff)
