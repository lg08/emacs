;; taken from here: https://github.com/mattmahn/emacsfiles/blob/master/emacs-config.org

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (prog-mode . lsp-deferred)
  :init
  (setq lsp-prefer-capf t))

;; TODO: make the window disappear/behave normally && hide line numbers
(defun my/hide-frame-line-numbers (frame _window)
  "Hides line nunmbers from a specific frame in a winow."
  (select-frame frame)
  (display-line-numbers-mode -1))

(use-package lsp-ui
  :requires (lsp-mode)
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-ignore-duplicate t)
  ;; (add-hook 'lsp-ui-doc-frame-hook #'my/hide-frame-line-numbers)
  )

(use-package lsp-ivy
  ;; :disabled
  :requires (lsp-mode)
  :commands (lsp-ivy-workspace-symbol lsp-ivy-global-workspace-symbol))

(use-package company-lsp
  :commands company-lsp
  :config
  (push 'company-lsp company-backends)
  (setq company-lsp-async t
        company-lsp-cache-candidates 'auto
        company-lsp-enable-recompletion t))


(setq gc-cons-threshold (* 10 1024 1024)
      read-process-output-max (* 1024 1024))







(provide 'my-testing-stuff)
