;; these are loaded initially---------------------------------------------------


(use-package eyebrowse                  ;window management package
  :config
  (eyebrowse-mode 1)
  (setq eyebrowse-new-workspace t)
  )

(use-package general                    ;keybinding system
  :defer t
  :config

  )

(use-package ivy
  :init
  (ivy-mode)
  :defer t
  :config
  (setq ivy-use-virtual-buffers t       ;    Add recent files and bookmarks to the ivy-switch-buffer
        ivy-count-format "%d/%d ")      ;    Displays the current and total number in the collection in the prompt

  (add-to-list                          ;should make find-file and stuff sort by date
   'ivy-sort-matches-functions-alist
   '(read-file-name-internal . ivy--sort-files-by-date))

  (setq ivy-extra-directories nil)
  (setq ivy-height 15)
  )

(use-package ivy-rich
  :defer 1
  :config
  (ivy-rich-mode 1)
  )

(use-package counsel
  :defer t
  :config

  )

(use-package swiper
  :init
  (define-key ivy-minibuffer-map "\C-k" 'nil)
  :defer t
  :config

  )


(use-package prescient
  :init
  (setq prescient-save-file (expand-file-name "prescient-save.el" gemacs-misc-dir))
  :ensure t
  :config
  (prescient-persist-mode +1)

  )

(use-package ivy-prescient
  :init
  (ivy-prescient-mode)
  :defer t
  :config

  )


(setq x-gtk-resize-child-frames 'resize-mode)
(use-package mini-frame
  :init
  (mini-frame-mode)
  :defer t
  :config
  (add-to-list 'mini-frame-ignore-commands 'swiper)

  (custom-set-variables
   '(mini-frame-show-parameters
     '((top . 0)
       (width . 0.7)
       (left . 0.5)
       (height . 15))))
  )

;; (use-package ivy-posframe
;;   :init
;;   (ivy-posframe-mode)
;;   :defer t
;;   :config

;;   )


(use-package which-key                  ;shows possible keyboard commands, just uncomment if you want it
  :defer 1
  :config
  (which-key-mode t)
  (which-key-setup-side-window-bottom)
  (setq which-key-idle-delay .2)

  )

;; below, all are deferred for one second ----------------------------------------------------------


(use-package feebleline                 ;basically gets rid of modeline
  :init
  :defer t
  :config
  ;; (feebleline-mode t)

  )

;; (use-package gcmh                       ;garbage management system
;;   :defer 0
;;   :config
;;   (gcmh-mode)
;;   ;; Adopt a sneaky garbage collection strategy of waiting until idle time to
;;   ;; collect; staving off the collector while the user is working.
;;   (setq gcmh-idle-delay 5
;;         gcmh-high-cons-threshold (* 16 1024 1024)  ; 16mb
;;         ;; gcmh-verbose doom-debug-p
;;         )
;;   )

(use-package undo-tree                  ;very helpful undo visualizer
  :defer 1
  :config
  (global-undo-tree-mode 1)
  (defadvice undo-tree-make-history-save-file-name ;automatically compresses the undo history file
      (after undo-tree activate)
    (setq ad-return-value (concat ad-return-value ".gz")))
  )

(use-package key-chord
  :defer 0
  :config
  (defun key-chord-mode (arg)
    "Toggle key chord mode.
With positive ARG enable the mode. With zero or negative arg disable the mode.
A key chord is two keys that are pressed simultaneously, or one key quickly
pressed twice.
\nSee functions `key-chord-define-global', `key-chord-define-local', and
`key-chord-define' and variables `key-chord-two-keys-delay' and
`key-chord-one-key-delay'."

    (interactive "P")
    (setq key-chord-mode (if arg
                             (> (prefix-numeric-value arg) 0)
                           (not key-chord-mode)))
    (cond (key-chord-mode
           (setq input-method-function 'key-chord-input-method)
           )
          (t
           (setq input-method-function nil)
           )))
  (key-chord-mode 1)
  (key-chord-define-global "ji" 'evil-normal-state)
  (key-chord-define-global "jn" 'set-mark-command)
  )

;; below, all are deferred until called ------------------------------------------------------
(use-package projectile                 ;project management
  :init
  (setq projectile-known-projects-file  (expand-file-name "projectile-bookmarks.eld" gemacs-misc-dir))
  (setq projectile-cache-file (expand-file-name "projectile.cache" gemacs-misc-dir))
  :defer t
  :config
  (projectile-mode +1)
  (setq projectile-completion-system 'ivy)
  (setq projectile-globally-ignored-file-suffixes '("pyc"))

  )

(use-package doom-themes                ;pretty themes
  :defer t
  :config
  ;; (doom-themes-org-config)
  (doom-themes-visual-bell-config)
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  )

(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :config
  (doom-modeline-mode)
  )


(use-package git-gutter
  :defer t
  :config
  )


(use-package magit                      ;best github client
  :defer t
  :config
  (add-hook 'magit-mode-hook (lambda () (evil-magit-init)))
  (add-to-list 'magit-no-confirm 'stage-all-changes)
  (remove-hook 'server-switch-hook 'magit-commit-diff)

  (add-hook 'git-commit-mode-hook
            (lambda ()
              (set-fill-column 72)))
  )

(use-package magit-todos                ;really cool, shows todos in magit buffer
  :defer t
  :requires (magit)
  :hook (magit-mode . magit-todos-mode)
  :custom
  (magit-todos-exclude-globs '("**/node_modules/**"))
  :init
  ;; (unless (executable-find "nice") ; don't break Magit on systems that don't have `nice'
  ;; (setq magit-todos-nimce nil))
  )

;; TODO: see if it works


(use-package smart-comment              ;just a better commenting function
  :defer t
  :config
  )

(use-package avy                        ;dope jumping to characters package
  :defer t
  :config
  (setq avy-all-windows 'nil)             ;limits the search to one window
  (setq avy-background t)
  (setq avy-keys (number-sequence ?a ?z))

  )

;; With use-package:
(use-package company-box
  :defer t
  :hook (company-mode . company-box-mode))

(use-package company                    ;autocompletion system
  :defer t
  :init
  (setq company-backends '((company-files company-keywords company-capf company-dabbrev-code company-etags company-dabbrev company-cmake ;; company-clang
                                          )))
  :config
  (setq company-tooltip-limit 20)                      ; bigger popup window
  (setq company-tooltip-align-annotations 't)          ; align annotations to the right tooltip border
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

  ;; provides almost instant autocompletion
  (setq company-idle-delay .05)
  ;;  ;; Search other buffers for compleition candidates
  (setq company-dabbrev-other-buffers t)
  (setq company-dabbrev-code-other-buffers t)

  ;;  ;; Show candidates according to importance, then case, then in-buffer frequency
  (setq company-transformers '(company-sort-by-backend-importance
                               company-sort-prefer-same-case-prefix
                               company-sort-by-occurrence))
  ;;  ;; Even if I write something with the ‘wrong’ case,
  ;;  ;; provide the ‘correct’ casing.
  (setq company-dabbrev-ignore-case nil)
  ;; :custom
  (setq company-minimum-prefix-length 3)
  )

(use-package company-quickhelp
  :defer t
  :init
  (company-quickhelp-mode 1)
  )

;; potential deep learning thing; could be dope
;; (use-package company-tabnine :ensure t)
;; (add-to-list 'company-backends 'company-tabnine)

(use-package elpy                       ;python ide
  :defer t
  :config
  (add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))
  )

(use-package dired-sidebar              ;helpful dired-based popup sidebar
  :defer t
  :init
    (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode)
                )
              (toggle-truncate-lines)
              ))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t)
  )

(use-package multiple-cursors           ;allows editing for multiple cursors
  :init
  (setq mc/list-file (concat gemacs-misc-dir ".mc-lists.el"))
  :defer t
  ;; :ensure t
  :config
  )

(use-package aggressive-indent          ;forces indent
  :defer t
  :config
  ;; removes modes from the auto indent
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  )

(use-package rainbow-delimiters         ;shows the depth of parenthesis with colors
  :defer t
  :config
  )

(use-package goto-chg                   ;helps jump to the last change in the buffer
  :defer t

  )
(use-package color-identifiers-mode     ;colors differnet variable names
  :defer t
  :config
  )

(use-package highlight-indent-guides    ;shows indentation guides, pretty lightweight
  :init
  :defer t
  :config
  (setq highlight-indent-guides-method 'bitmap)
  (setq highlight-indent-guides-responsive 'stack)
  )

(use-package all-the-icons              ;just has a bunch of icons for stuff
  :defer t
  :config
  )

(use-package all-the-icons-dired        ;shows icons in dired mode
  :defer t
  :config
  )

(use-package restart-emacs              ;restarts emacs
  :defer t
  :config
  )

(use-package emmet-mode                 ;helpful web dev shortcuts
  :defer t
  :config
  )

(use-package web-mode                   ;better web development major mode  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  :config
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t)

  )

(use-package writeroom-mode             ;distraction-free editing
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

(use-package rainbow-mode               ;shows color codes
  :defer t
  :config

  )

(use-package dired-narrow               ;used to search in dired
  :defer t
  :config

  )

(use-package smart-hungry-delete        ;deletes whitespace
  :defer t
  :config

  )

;; (use-package yasnippet                  ;abbreviation package
;;   :defer t
;;   :config
;;   ;; check out here for full list: http://andreacrotti.github.io/yasnippet-snippets/snippets.html
;;   (use-package yasnippet-snippets       ;bunch of common snippets
;;     :defer t
;;     :config

;;     )
;;   )

(use-package tuareg                     ;major mode for oCaml editing
  :defer t
  :config

  )

(use-package merlin                     ;enhanced oCaml environment
  :defer t
  :config

  )

(use-package smerge-mode                ;useful for merging git conflicts
  :init
  (setq smerge-command-prefix "\C-cv")
  :defer t
  :config

  )

(use-package outshine                   ;org-mode in the comments
  :init
  ;; Required for outshine
  (add-hook 'outline-minor-mode-hook 'outshine-mode)
  :defer t
  :config

  )

(use-package highlight-thing            ;highlights all occurences of current symbol
  :defer t
  :config
  (setq highlight-thing-delay-seconds 0.5)
  ;; Don't highlight the thing at point itself. Default is nil.
  (setq highlight-thing-exclude-thing-under-point t)
  (setq highlight-thing-case-sensitive-p t)

  )

(use-package format-all                 ;used to format code
  :defer t
  :config

  )

(use-package web-beautify               ;used to format web code
  :defer t
  :config

  )

(use-package volatile-highlights        ;just helpful for showing what you just did
  :defer t
  :config

  )

(use-package haskell-mode               ;major mode for hashell
  :defer t
  :config

  )

(use-package clojure-mode               ;major mode for closure
  :defer t
  :config

  )

(use-package yaml-mode                  ;major mode for yaml
  :defer t
  :config

  )

(use-package org-bullets                ;shows prettier bullets in org mode
  :defer t
  :config

  )


(use-package org
  ;; :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  ;; (setq org-agenda-files
  ;;       '("~/Projects/Code/emacs-from-scratch/OrgFiles/Tasks.org"
  ;;         "~/Projects/Code/emacs-from-scratch/OrgFiles/Habits.org"
  ;;         "~/Projects/Code/emacs-from-scratch/OrgFiles/Birthdays.org"))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
          (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
        '(("Archive.org" :maxlevel . 1)
          ("Tasks.org" :maxlevel . 1)))
  )

;; Save Org buffers after refiling!
(advice-add 'org-refile :after 'org-save-all-org-buffers)

(use-package poporg
  :init
  (global-set-key (kbd "C-c \"") 'poporg-dwim)
  :defer t
  :config
  )

(use-package flycheck                   ;automatic spell-checking and stuff
  :defer t
  :config

  )

(use-package fix-word                   ;used to capitalize words and stuff
  :defer t
  :config

  )

(use-package indent-guide               ;another useful indent-guide package
  :defer t
  :config
  ;; (setq indent-guide-recursive t)
  (setq indent-guide-delay 0.1)
  )

(use-package company-c-headers          ;supposed to show c headers
  :defer t
  :config
  (add-to-list 'company-c-headers-path-system "/usr/include/c++/4.8/")

  )

(use-package helm-descbinds             ;helps show keybindings
  :defer t
  :config

  )

(use-package zop-to-char                ;cuts to the next occurence of character
  :defer t
  :config

  )

(use-package auctex-latexmk             ;for latex development
  :defer t
  :init
  (auctex-latexmk-setup)
  :config

  )

(use-package panda-theme
  :defer t
  :config

  )

(use-package fireplace
  :defer t
  :config

  )

(use-package transient                  ;used for a bunch of things, just want to keep it's folder out of the home directory
  :defer t
  :config
  :init
  (setq transient-history-file (expand-file-name "history.el" gemacs-misc-dir))
  )

(use-package url                        ;used by other stuff, just need to customize a variable
  :init
  (setq url-configuration-directory (expand-file-name "url" gemacs-misc-dir))
  :defer t
  :config

  )

(use-package multi-term                 ;pretty good terminal thing
  :init
  :defer t
  :config

  )

(use-package google-this
  :defer t
  :config
  )

(use-package go-mode
  :defer t
  :config

  )


(use-package highlight-parentheses
  :defer t
  :config

  )

(use-package wakatime-mode
  :init
  (setq wakatime-api-key "4e8965d1-c63b-4bb1-9673-5c1dc7519277")
  (setq wakatime-cli-path "/usr/local/bin/wakatime")
  (global-wakatime-mode)
  :defer t
  :config

  )

(use-package flx-isearch
  :defer t
  :config

  )

(use-package ctrlf
  :defer t
  :config
  (setq ctrlf-highlight-current-line 1)
  )

(use-package evil
  :init
  (evil-mode 1)
  :defer t
  :config

  )


(use-package evil-magit
  :defer t
  :config

  )

;; link here: https://github.com/emacs-evil/evil-surround
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1)
  )

;; Or if you use use-package
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; A more complex, more lazy-loaded config
(use-package solaire-mode
  ;; Ensure solaire-mode is running in all solaire-mode buffers
  :hook (change-major-mode . turn-on-solaire-mode)
  ;; ...if you use auto-revert-mode, this prevents solaire-mode from turning
  ;; itself off every time Emacs reverts the file
  :hook (after-revert . turn-on-solaire-mode)
  ;; To enable solaire-mode unconditionally for certain modes:
  :hook (ediff-prepare-buffer . solaire-mode)
  ;; Highlight the minibuffer when it is activated:
  :hook (minibuffer-setup . solaire-mode-in-minibuffer)
  :config
  ;; The bright and dark background colors are automatically swapped the first
  ;; time solaire-mode is activated. Namely, the backgrounds of the `default` and
  ;; `solaire-default-face` faces are swapped. This is done because the colors
  ;; are usually the wrong way around. If you don't want this, you can disable it:
  (setq solaire-mode-auto-swap-bg nil)

  (solaire-global-mode +1))

(use-package move-text
  :defer t
  :config
  (move-text-default-bindings)
  )

(use-package gcmh
  :init
  (gcmh-mode 1)
  :defer t
  :config

  )

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-directory-name-transformer    #'identity
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-extension-regex          treemacs-last-period-regex-value
          treemacs-file-follow-delay             0.2
          treemacs-file-name-transformer         #'identity
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-move-forward-on-expand        nil
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-read-string-input             'from-child-frame
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-asc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-user-mode-line-format         nil
          treemacs-user-header-line-format       nil
          treemacs-width                         35
          treemacs-workspace-switch-cleanup      nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(use-package treemacs-persp ;;treemacs-persective if you use perspective.el vs. persp-mode
  :after treemacs persp-mode ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package nyan-mode
  :defer t
  :config

  )

(provide 'my-packages)
