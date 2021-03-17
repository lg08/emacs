;; (require 'latex-loads)

(use-package org-bullets                ;shows prettier bullets in org mode
  :defer t
  :config

  )

;; agenda shit
;; set key for agenda
(global-set-key (kbd "C-c a") 'org-agenda)

;;file to save todo items
(setq org-agenda-files (quote ("~/Documents/princeton/agenda.org")))

;;set priority range from A to C with default A
(setq org-highest-priority ?A)
(setq org-lowest-priority ?C)
(setq org-default-priority ?A)

;;open agenda in current window
(setq org-agenda-window-setup (quote current-window))

;;capture todo items using C-c c t
(define-key global-map (kbd "C-c c") 'org-capture)
(setq org-capture-templates
      '(("t" "todo" entry (file+headline "~/Documents/princeton/agenda.org" "Tasks")
         "* TODO [#A] %?")))

;; ----------------------------------------------------


(set-default 'preview-scale-function 5.2) ;makes latex more readable

(setq org-startup-folded "showall")     ;starts org mode with everything showing


(provide 'org-mode-loads)
