(use-package elpy                       ;python ide
  :defer t
  :config
  (add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))
  )

(setq elpy-rpc-python-command "python3") ;only if you're using python3
(add-to-list (make-local-variable 'company-backends)
             'company-anaconda)
(aggressive-indent-mode -1)

(elpy-enable)

(use-package blacken
  :defer t
  :config

  )



(provide 'python-mode-loads)
