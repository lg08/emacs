(use-package dired-narrow               ;used to search in dired
  :defer t
  :config

  )
(use-package all-the-icons-dired        ;shows icons in dired mode
  :defer t
  :config
  )

(use-package dired-quick-sort
  :defer t
  :config

  )


;; Auto-refresh dired on file change
(add-hook 'dired-mode-hook 'auto-revert-mode)



(provide 'dired-mode-loads)
