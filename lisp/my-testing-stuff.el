;; ;; taken from here: https://github.com/mattmahn/emacsfiles/blob/master/emacs-config.org

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy)

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))




(use-package company-anaconda
  :init
  (eval-after-load "company"
    '(add-to-list 'company-backends 'company-anaconda))
  (add-hook 'python-mode-hook 'anaconda-mode)
  :defer t
  :config

  )



(setq frame-title-format
      '("" invocation-name ": "
        (:eval
         (if buffer-file-name
             (abbreviate-file-name buffer-file-name)
           "%b"))))



;; (setq ido-separator "\n")		;tells ido mode to display vertically

;; (setq flx-ido-mode 1)
;; (setq ido-enable-flex-matching t)

;; (ido-mode 1)
;; (ido-everywhere 1)


;; (use-package ido-completing-read+
;;   :defer t
;;   :config

;;   )

;; (ido-ubiquitous-mode 1)
;; (use-package amx
;;   :init
;;   (amx-mode 1)
;;   :defer t
;;   :config

;;   )

;; (require 'icomplete)
;; (icomplete-mode 1)


;; (defun ido-my-keys ()
;;   (define-key ido-completion-map (kbd "C-k")   'ido-prev-match)
;;   (define-key ido-completion-map (kbd "C-j") 'ido-next-match)
;;   (define-key ido-completion-map (kbd "C-k")   'ido-prev-match)
;;   (define-key ido-completion-map (kbd "C-j") 'ido-next-match)

;;   )


;; (add-hook 'ido-setup-hook 'ido-my-keys)

;; ;; (setq ido-decorations (quote ("\n-> " "" "\n " "\n ..." "[" "]" "
;; ;;   [No match]" " [Matched]" " [Not readable]" " [Too big]" "
;; ;;   [Confirm]")))
;; (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
;; (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)


(setq tramp-default-method "ssh")

;; ;; (customize-set-variable 'tramp-syntax 'simplified)



;; (defvar custom-ido-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "<C-return>") 'ido-select-text)
;;     ;; (define-key map (kbd "<M-return>") 'ido-magic-forward-char)
;;     map))
;; (with-eval-after-load 'ido
;;   (define-key ido-common-completion-map (kbd "<C-return>") 'ido-select-text)
;;   ;; (define-key ido-common-completion-map (kbd "<M-return>") 'ido-magic-forward-char)
;;   )
;; (add-to-ordered-list 'emulation-mode-map-alists
;;                      `((cua-mode . ,custom-ido-map))
;;                      0)


(provide 'my-testing-stuff)
