;; (require 'latex-loads)

(use-package org-bullets                ;shows prettier bullets in org mode
  :defer t
  :config

  )


(setq org-src-preserve-indentation t)
(setq org-src-window-setup 'other-window)

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


(setq org-agenda-custom-commands
      '(("c" "Simple agenda view"
         ((agenda "")
          (alltodo "")))))


;; ----------------------------------------------
;; ****** Org-agenda Vim Keybindings                              :orgmode:evil:
;; #+BEGIN_SRC emacs-lisp
(eval-after-load 'org-agenda
 '(progn
    (evil-set-initial-state 'org-agenda-mode 'normal)
    (evil-define-key 'normal org-agenda-mode-map
      (kbd "<RET>") 'org-agenda-switch-to
      (kbd "\t") 'org-agenda-goto

      "q" 'org-agenda-quit
      "r" 'org-agenda-redo
      "S" 'org-save-all-org-buffers
      "gj" 'org-agenda-goto-date
      "gJ" 'org-agenda-clock-goto
      "gm" 'org-agenda-bulk-mark
      "go" 'org-agenda-open-link
      "s" 'org-agenda-schedule
      "+" 'org-agenda-priority-up
      "," 'org-agenda-priority
      "-" 'org-agenda-priority-down
      "y" 'org-agenda-todo-yesterday
      "n" 'org-agenda-add-note
      "t" 'org-agenda-todo
      ":" 'org-agenda-set-tags
      ";" 'org-timer-set-timer
      "I" 'helm-org-task-file-headings
      "i" 'org-agenda-clock-in-avy
      "O" 'org-agenda-clock-out-avy
      "u" 'org-agenda-bulk-unmark
      "x" 'org-agenda-exit
      "j"  'org-agenda-next-line
      "k"  'org-agenda-previous-line
      "vt" 'org-agenda-toggle-time-grid
      "va" 'org-agenda-archives-mode
      "vw" 'org-agenda-week-view
      "vl" 'org-agenda-log-mode
      "vd" 'org-agenda-day-view
      "vc" 'org-agenda-show-clocking-issues
      "g/" 'org-agenda-filter-by-tag
      "o" 'delete-other-windows
      "gh" 'org-agenda-holiday
      "gv" 'org-agenda-view-mode-dispatch
      "f" 'org-agenda-later
      "b" 'org-agenda-earlier
      "c" 'helm-org-capture-templates
      "e" 'org-agenda-set-effort
      "n" nil  ; evil-search-next
      "{" 'org-agenda-manipulate-query-add-re
      "}" 'org-agenda-manipulate-query-subtract-re
      "A" 'org-agenda-toggle-archive-tag
      "." 'org-agenda-goto-today
      "0" 'evil-digit-argument-or-evil-beginning-of-line
      "<" 'org-agenda-filter-by-category
      ">" 'org-agenda-date-prompt
      "F" 'org-agenda-follow-mode
      "D" 'org-agenda-deadline
      "H" 'org-agenda-holidays
      "J" 'org-agenda-next-date-line
      "K" 'org-agenda-previous-date-line
      "L" 'org-agenda-recenter
      "P" 'org-agenda-show-priority
      "R" 'org-agenda-clockreport-mode
      "Z" 'org-agenda-sunrise-sunset
      "T" 'org-agenda-show-tags
      "X" 'org-agenda-clock-cancel
      "[" 'org-agenda-manipulate-query-add
      "g\\" 'org-agenda-filter-by-tag-refine
      "]" 'org-agenda-manipulate-query-subtract)))
;; #+END_SRC


(provide 'org-mode-loads)
