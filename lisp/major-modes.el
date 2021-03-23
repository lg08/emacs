
(use-package web-mode                   ;better web development major mode  :defer t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  :config
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t)

  )

(use-package tuareg                     ;major mode for oCaml editing
  :defer t
  :config

  )

(use-package ess                        ;used for R
  :defer t
  :config

  )


(provide 'major-modes)
