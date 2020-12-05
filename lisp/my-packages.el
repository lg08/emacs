;; Loads all packages

;; these are loaded initially---------------------------------------------------

(use-package modalka                    ;my mode-based system
  :config
  (modalka-global-mode 1)
  (setq-default cursor-type '(bar . 1))
  (setq modalka-cursor-type 'box)
  )

(use-package eyebrowse                  ;window management package
  :config
  (eyebrowse-mode 1)
  (setq eyebrowse-new-workspace t)
  )

(use-package general                    ;keybinding system
  :defer t
  :config

  )

(use-package helm
  :init
  (helm-mode)
  (setq recentf-save-file (expand-file-name "recentf" gemacs-misc-dir))
  (setq helm-split-window-default-side 'right)
  (setq helm-samewindow t)
  ;; (setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
  ;; (setq helm-locate-fuzzy-match t)

  ;; this guy makes helm use a mini frame
  ;; (setq helm-display-function 'helm-display-buffer-in-own-frame
  ;; helm-display-buffer-reuse-frame t
  ;; helm-use-undecorated-frame-option t)
  :config

  )

(use-package helm-swoop                 ;really good searching buffer things
  :defer t
  :config
  (setq helm-swoop-pre-input-function
        (lambda () nil))
  ;; Save buffer when helm-multi-swoop-edit complete
  (setq helm-multi-swoop-edit-save t)

  ;; If this value is t, split window inside the current window
  (setq helm-swoop-split-with-multiple-windows nil)

  ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
  (setq helm-swoop-split-direction 'split-window-vertically)

  ;; If nil, you can slightly boost invoke speed in exchange for text color
  (setq helm-swoop-speed-or-color nil)

  ;; If you prefer fuzzy matching
  ;; (setq helm-swoop-use-fuzzy-match t)

  )

;; (use-package which-key                  ;shows possible keyboard commands, just uncomment if you want it
;;   :config
;;   (which-key-mode t)
;;   (which-key-setup-side-window-bottom)
;;   (setq which-key-idle-delay 1)

;;   )

;; below, all are deferred for one second ----------------------------------------------------------


(use-package feebleline			;basically gets rid of modeline
  :init
  :defer 1
  :config
  (feebleline-mode t)

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
  :defer 0
  :config
  (global-undo-tree-mode 1)
  (defadvice undo-tree-make-history-save-file-name ;automatically compresses the undo history file
      (after undo-tree activate)
    (setq ad-return-value (concat ad-return-value ".gz")))
  )

(use-package key-chord                  ;very useful package, used to turn on modalka mode
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
  (key-chord-define-global "ji" 'my/modalka-normal-mode)
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
  (setq projectile-completion-system 'helm)
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

(use-package git-gutter
  :defer t
  :config
  )


(use-package magit                      ;best github client
  :defer t
  :config
  (add-hook 'magit-mode-hook (lambda () (modalka-mode -1)))
  (add-hook 'git-commit-mode-hook (lambda () (modalka-mode -1)))
  (add-to-list 'magit-no-confirm 'stage-all-changes)
  )


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

(use-package switch-window              ;faster window switching
  :defer t
  :config
  )

;; With use-package:
(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package company                    ;autocompletion system
  :init
  (setq company-backends '((company-files company-keywords company-capf company-dabbrev-code company-etags company-dabbrev company-cmake company-clang)))
  :defer t
  :config
  (setq company-tooltip-limit 20)                      ; bigger popup window
  (setq company-tooltip-align-annotations 't)          ; align annotations to the right tooltip border
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

  ;; provides almost instant autocompletion
  (setq company-idle-delay 0)
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

;; potential deep learning thing; could be dope
;; (use-package company-tabnine :ensure t)
;; (add-to-list 'company-backends 'company-tabnine)

(use-package elpy                       ;python ide
  :defer t
  :config
  )

(use-package dired-sidebar              ;helpful dired-based popup sidebar
  :defer t
  :config
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
  (setq highlight-indent-guides-method 'character)
  :defer t
  :config

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

(use-package web-mode                   ;better web development major mode
  :defer t
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

(use-package iy-go-to-char              ;like a little quicker avy for short distances
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
  (setq highlight-thing-delay-seconds 0.0)
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

(use-package transient			;used for a bunch of things, just want to keep it's folder out of the home directory
  :defer t
  :config
  :init
  (setq transient-history-file (expand-file-name "history.el" gemacs-misc-dir))
  )

(use-package url			;used by other stuff, just need to customize a variable
  :init
  (setq url-configuration-directory (expand-file-name "url" gemacs-misc-dir))
  :defer t
  :config

  )


(provide 'my-packages)
