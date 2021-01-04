




(use-package magit-todos                ;really cool, shows todos in magit buffer
  :defer t
  :requires (magit)
  :hook (magit-mode . magit-todos-mode)
  :custom
  (magit-todos-exclude-globs '("**/node_modules/**"))
  :init
  ;; (unless (executable-find "nice") ; don't break Magit on systems that don't have `nice'
  ;; (setq magit-todos-nimce nil))
  )



(use-package git-gutter
  :defer t
  :config
  )



(use-package evil-magit
  :defer t
  :config

  )


(provide 'magit-mode-loads)
