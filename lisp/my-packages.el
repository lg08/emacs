;; Loads all packages

;; these are loaded initially---------------------------------------------------

;; (use-package modalka                    ;my mode-based system
;;   :config
;;   (modalka-global-mode 1)
;;   (setq-default cursor-type '(bar . 1))
;;   (setq modalka-cursor-type 'box)
;;   ;; :diminish modalka-mode
;;   )

(use-package eyebrowse                  ;window management package
  :config
  (eyebrowse-mode 1)
  (setq eyebrowse-new-workspace t)
  )

(use-package general                    ;keybinding system
  :defer t
  :config

  )

;; (use-package ivy
;;   :init
;;   (ivy-mode)
;;   :defer
;;   :config
;;   (setq ivy-use-virtual-buffers t	;    Add recent files and bookmarks to the ivy-switch-buffer
;;         ivy-count-format "%d/%d ")	;    Displays the current and total number in the collection in the prompt

;;   (add-to-list				;should make find-file and stuff sort by date
;;    'ivy-sort-matches-functions-alist
;;    '(read-file-name-internal . ivy--sort-files-by-date))
;;   )

;; (use-package swiper
;;   :init
;;   (define-key ivy-minibuffer-map "\C-k" 'nil)
;;   :defer t
;;   :config

;;   )


;; (use-package prescient
;;   :init
;;   (setq prescient-save-file (expand-file-name "prescient-save.el" gemacs-misc-dir))
;;   :ensure t
;;   :config
;;   (prescient-persist-mode +1)

;;   )

;; (use-package ivy-prescient
;;   :init
;;   (ivy-prescient-mode)
;;   :defer t
;;   :config

;;   )

;; (use-package counsel
;;   ;; :defer t
;;   :config

;;   )


;; (use-package ivy-rich
;;   :init
;;   (ivy-rich-mode 1)
;;   :defer t
;;   :config

;;   )



;; (setq x-gtk-resize-child-frames 'resize-mode)
;; (use-package mini-frame
;;   :init
;;   (mini-frame-mode)
;;   :defer t
;;   :config
;;   (add-to-list 'mini-frame-ignore-commands 'swiper)
;;   )

;; (use-package ivy-posframe
;;   :init
;;   (ivy-posframe-mode)
;;   :defer t
;;   :config

;;   )


;; (use-package which-key                  ;shows possible keyboard commands, just uncomment if you want it
;;   :config
;;   (which-key-mode t)
;;   (which-key-setup-side-window-bottom)
;;   (setq which-key-idle-delay 1)

;;   )

;; below, all are deferred for one second ----------------------------------------------------------


;; (use-package feebleline			;basically gets rid of modeline
;;   :init
;;   :defer 1
;;   :config
;;   (feebleline-mode t)

;;   )

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
  (setq projectile-completion-system 'ido)
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
  ;; (add-hook 'git-commit-mode-hook (lambda () (modalka-mode -1)))
  (add-to-list 'magit-no-confirm 'stage-all-changes)


  (add-hook 'git-commit-mode-hook
            (lambda ()
              (set-fill-column 72)))
  )

(use-package magit-todos		;really cool, shows todos in magit buffer
  :requires (magit)
  ;; :hook (magit-mode . magit-todos-mode)
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
  :hook (company-mode . company-box-mode))

(use-package company                    ;autocompletion system
  :init
  (setq company-backends '((company-files company-keywords company-capf company-dabbrev-code company-etags company-dabbrev company-cmake ;; company-clang
					  )))
  :defer t
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
  :init
  (company-quickhelp-mode 1)
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

(use-package multi-term			;pretty good terminal thing
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


(provide 'my-packages)
