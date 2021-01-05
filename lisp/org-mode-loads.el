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

(setq org-agenda-files (list "~/.emacs.d/agenda.org"))


(provide 'org-mode-loads)
