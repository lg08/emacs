(use-package elpy                       ;python ide
  :defer t
  :config
  (add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))
  )


(provide 'python-mode-loads)
