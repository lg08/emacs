;; these are loaded initially---------------------------------------------------

(use-package general                    ;keybinding system
  :defer t
  :config

  )


(use-package nyan-mode
  :defer 0.1
  :config
  (nyan-mode 1)
  (require 'one-sec-loads)
  )



(provide 'my-packages)
