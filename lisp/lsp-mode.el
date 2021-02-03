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

;; (use-package lsp-mode
;;   :diminish (lsp-mode . "lsp")
;;   :bind (:map lsp-mode-map
;; 	 ("C-c C-d" . lsp-describe-thing-at-point))
;;   :hook ((python-mode . lsp-deferred)
;; 	 (js-mode . lsp-deferred)
;; 	 (js2-mode . lsp-deferred)
;; 	 (dockerfile-mode . lsp-deferred)
;; 	 (sh-mode . lsp-deferred)
;; 	 (typescript-mode . lsp-deferred)
;; 	 (go-mode . lsp-deferred))
;;   :init
;;   (setq lsp-auto-guess-root t       ; Detect project root
;; 	lsp-log-io nil
;; 	lsp-enable-indentation t
;; 	lsp-enable-imenu t
;; 	lsp-keymap-prefix "C-c l"
;; 	lsp-enable-file-watchers t

;; 	lsp-file-watch-threshold 5000
;; 	lsp-prefer-flymake nil)      ; Use lsp-ui and flycheck

;;   (defun lsp-on-save-operation ()
;;     (when (or (boundp 'lsp-mode)
;; 	      (bound-p 'lsp-deferred))
;;       (lsp-organize-imports)
;;       (lsp-format-buffer))))

;; (use-package lsp-clients
;;   :ensure nil
;;   :after (lsp-mode)
;;   :init (setq lsp-clients-python-library-directories '("/usr/local/" "/usr/")))

;; (use-package lsp-ui
;;   :ensure t
;;   :after (lsp-mode)
;;   :commands lsp-ui-doc-hide
;;   :bind (:map lsp-ui-mode-map
;; 	      ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
;; 	      ([remap xref-find-references] . lsp-ui-peek-find-references)
;; 	      ("C-c u" . lsp-ui-imenu))
;;   :init (setq lsp-ui-doc-enable t
;; 	      lsp-ui-doc-use-webkit nil
;; 	      lsp-ui-doc-header nil
;; 	      lsp-ui-doc-delay 0.2
;; 	      lsp-ui-doc-include-signature t
;; 	      lsp-ui-doc-alignment 'at-point
;; 	      lsp-ui-doc-use-childframe nil
;; 	      lsp-ui-doc-border (face-foreground 'default)
;; 	      lsp-ui-peek-enable t
;; 	      lsp-ui-peek-show-directory t
;; 	      lsp-ui-sideline-delay 10
;; 	      lsp-ui-sideline-update-mode 'point
;; 	      lsp-ui-sideline-enable t
;; 	      lsp-ui-sideline-show-code-actions t
;; 	      lsp-ui-sideline-show-hover t
;; 	      lsp-ui-sideline-ignore-duplicate t
;; 	      lsp-gopls-use-placeholders nil)
;;   :config
;;   (setq lsp-completion-provider :capf)
;;   (setq lsp-idle-delay 0.500)
;;   (setq lsp-print-performance t)

;;   (add-to-list 'lsp-ui-doc-frame-parameters '(right-fringe . 8))

;;   ;; `C-g'to close doc
;;   (advice-add #'keyboard-quit :before #'lsp-ui-doc-hide)

;;   ;; Reset `lsp-ui-doc-background' after loading theme
;;   (add-hook 'after-load-theme-hook
;; 	    (lambda ()
;; 	      (setq lsp-ui-doc-border (face-foreground 'default))
;; 	      (set-face-background 'lsp-ui-doc-background
;; 				   (face-background 'tooltip))))

;;   ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
;;   ;; @see https://github.com/emacs-lsp/lsp-ui/issues/243
;;   (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
;;     (setq mode-line-format nil)))


;; from here: https://github.com/MatthewZMD/.emacs.d#orge51b842
(use-package lsp-mode
  :defer t
  :commands lsp
  :custom
  (lsp-auto-guess-root nil)
  (lsp-prefer-flymake nil) ; Use flycheck instead of flymake
  (lsp-file-watch-threshold 2000)
  (read-process-output-max (* 1024 1024))
  (lsp-eldoc-hook nil)
  :bind (:map lsp-mode-map ("C-c C-f" . lsp-format-buffer))
  :hook ((java-mode python-mode go-mode
          js-mode js2-mode typescript-mode web-mode
          c-mode c++-mode objc-mode) . lsp))

(use-package lsp-ui
  :after lsp-mode
  :diminish
  :commands lsp-ui-mode
  :custom-face
  (lsp-ui-doc-background ((t (:background nil))))
  (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
  :bind
  (:map lsp-ui-mode-map
        ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
        ([remap xref-find-references] . lsp-ui-peek-find-references)
        ("C-c u" . lsp-ui-imenu)
        ("M-i" . lsp-ui-doc-focus-frame))
  (:map lsp-mode-map
        ("M-n" . forward-paragraph)
        ("M-p" . backward-paragraph))
  :custom
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-border (face-foreground 'default))
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-code-actions nil)
  :config
  ;; Use lsp-ui-doc-webkit only in GUI
  (if (display-graphic-p)
      (setq lsp-ui-doc-use-webkit t))
  ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
  ;; https://github.com/emacs-lsp/lsp-ui/issues/243
  (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
    (setq mode-line-format nil)))

(provide 'lsp-mode.el)
