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

(emmet-mode 1)
(web-mode-set-engine "django")
(electric-pair-mode -1)
(rainbow-mode 1)
;; (display-line-numbers-mode -1)


(set (make-local-variable 'company-backends) '(company-css company-web-html company-yasnippet company-files))


(provide 'html-mode-loads)
