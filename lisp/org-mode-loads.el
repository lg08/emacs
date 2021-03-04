(require 'latex-loads)

(use-package org-bullets                ;shows prettier bullets in org mode
  :defer t
  :config

  )



(set-default 'preview-scale-function 1.2) ;makes latex more readable

(setq org-startup-folded "showall")     ;starts org mode with everything showing


(provide 'org-mode-loads)
