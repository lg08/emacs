(use-package auctex-latexmk             ;for latex development
  :defer t
  :init
  (auctex-latexmk-setup)
  :config

  )

(use-package org-bullets                ;shows prettier bullets in org mode
  :defer t
  :config

  )

(use-package auctex                     ;used for latex
  :defer t
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  )

(use-package auctex-latexmk             ;for latex development
  :defer t
  :init
  (auctex-latexmk-setup)
  :config

  )


(set-default 'preview-scale-function 1.2) ;makes latex more readable

(setq org-startup-folded "showall")     ;starts org mode with everything showing


(provide 'org-mode-loads)
