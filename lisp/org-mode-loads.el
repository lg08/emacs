<<<<<<< HEAD
(use-package auctex-latexmk             ;for latex development
  :defer t
  :init
  (auctex-latexmk-setup)
  :config

  )
=======
>>>>>>> 34bea45c916d916939c0034d1ac3cd4110b563aa

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

(org-indent-mode)
(org-bullets-mode)
(wakatime-mode)

(setq org-agenda-files (list "~/.emacs.d/agenda.org"))


(provide 'org-mode-loads)
