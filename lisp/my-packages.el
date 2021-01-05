;; these are loaded initially---------------------------------------------------

;;; Code:

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



;; ;; Auto installing OS system packages
;; (use-package use-package-ensure-system-package
;;   :defer 5
;;   :config (system-packages-update))

;; Ensure our operating system is always up to date.
;; This is run whenever we open Emacs & so wont take long if we're up to date.
;; It happens in the background ^_^
;;
;; After 5 seconds of being idle, after starting up.

(provide 'my-packages)
