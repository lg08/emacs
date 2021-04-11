(use-package elpy                       ;python ide
  :defer t
  :config
  (add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))
  )

(setq elpy-rpc-python-command "python3") ;only if you're using python3
(add-to-list (make-local-variable 'company-backends)
             'company-anaconda)
(aggressive-indent-mode -1)

(setq python-shell-interpreter "python3")

(elpy-enable)

(use-package blacken
  :defer t
  :config

  )


(use-package pyvenv
  :defer t
  :config

  )

(use-package blacken
  :defer t
  :config

  )

(setq py-python-command "python3")
(setq python-shell-interpreter "python3")

(use-package company-jedi
  :defer t
  :config

  )

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)


(provide 'python-mode-loads)
