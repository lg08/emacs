(use-package web-beautify               ;used to format web code
  :defer t
  :config

  )

(use-package emmet-mode                 ;helpful web dev shortcuts
  :defer t
  :config
  )

;; (setq web-mode-markup-indent-offset 2)
;; (setq web-mode-code-indent-offset 2)
;; (setq web-mode-css-indent-offset 2)
;; (setq tab-width 2)

;; (display-line-numbers-mode -1)


;; (use-package instant-rename-tag
;;   :load-path (lambda () (expand-file-name "man_packages" gemacs-dir))
;;   :bind ("C-z <" . instant-rename-tag))

;; (add-to-list 'load-path (expand-file-name "man_packages/instant-rename-tag" gemacs-dir)) ; add instant-rename-tag to your load-path
;; (require 'instant-rename-tag)

(provide 'html-mode-loads)
