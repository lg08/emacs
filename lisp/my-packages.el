;; Loads all packages

;; these are loaded initially---------------------------------------------------

(use-package modalka                    ;my mode-based system
  :config
  (modalka-global-mode 1)
  (setq-default cursor-type '(bar . 1))
  (setq modalka-cursor-type 'box)

  ;; changes modeline color when exiting modalka
  (defun change-modalka-exit-modeline ()
    "changes modeline color on modalka exit"
    (interactive)
    (when (eq modalka-mode nil) (  set-face-background 'mode-line "#808080")))
  ;; (add-hook 'modalka-mode-hook 'change-modalka-exit-modeline)

  )

(use-package ivy                        ;filtering system
  :config
  (ivy-mode 1)
  (setq ivy-height 20)

  (use-package amx
    :defer t
    :config

    )

  (use-package prescient
    :config
    
    )
  (use-package ivy-prescient
    :config
    (ivy-prescient-mode 1)
    )
  



  ;; (use-package mini-frame
 ;;  ;; :defer t
 ;;  :init
 ;;  (mini-frame-mode)
 ;;  :config
 
 ;;  (custom-set-variables
 ;; '(mini-frame-show-parameters
 ;;   '((top . 0)
 ;;     (width . 0.7)
 ;;     (left . 0.5)
 ;;     (height . 15))))
  ;;  )
  (use-package ivy-posframe
    :defer t
    :init
    (ivy-posframe-mode)
    :config
    (setq ivy-posframe-parameters
      '((left-fringe . 10)
        (right-fringe . 10)))
    )
  (setq ivy-posframe-display-functions-alist
        '((swiper          . ivy-display-function-fallback)
          (complete-symbol . ivy-posframe-display-at-point)
          (counsel-M-x     . ivy-posframe-display-at-window-bottom-left)
          ;; the default one
          (t               . ivy-posframe-display)))
  )
  
;; (ido-mode 1)
;; (ido-everywhere 1)
;; (define-key ido-completion-map (kbd "C-j")   'ido-prev-match)
;; (define-key ido-completion-map (kbd "C-k")   'ido-next-match)


;; (use-package ido-completing-read+
;;   :init
;;   (ido-ubiquitous-mode 1)
;;   :defer t
;;   :config
;;   (amx-mode 1)

;;   )

;; (use-package ido-vertical-mode
;;   :defer t
;;   :config

;;   )

;; (use-package ido-yes-or-no
;;   :defer t
;;   :init
;;   (ido-yes-or-no-mode 1)
;;   :defer t
;;   :config

;;   )

;; (use-package amx
;;   ;; :defer t
;;   :config

;;   )

(use-package eyebrowse                  ;window management package
  :config
  (eyebrowse-mode 1)
  (setq eyebrowse-new-workspace t)
  )

(use-package general                    ;keybinding system
  :config

  )

;; (use-package which-key                  ;shows possible keyboard commands
;;   :config
;;   (which-key-mode t)
;;   (which-key-setup-side-window-bottom)
;;   (setq which-key-idle-delay 1)

;;   )

;; below, all are deferred for one second ----------------------------------------------------------


(use-package doom-modeline              ;beautiful modeline
  :defer 0
  :config
  (doom-modeline-mode t)
  (setq doom-modeline-height 10)
  )

;; (use-package all-the-icons-ivy
;;   :defer 1
;;   :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup)
  
;;   )


(use-package gcmh                       ;garbage management system
  :defer 0
  :config
  (gcmh-mode)
  ;; Adopt a sneaky garbage collection strategy of waiting until idle time to
  ;; collect; staving off the collector while the user is working.
  (setq gcmh-idle-delay 5
        gcmh-high-cons-threshold (* 16 1024 1024)  ; 16mb
        ;; gcmh-verbose doom-debug-p
        )
  )

;; (use-package nyan-mode                  ;shows scroll bar in modeline
;;   :defer 0
;;   :config
;;   (nyan-mode 1)
;;   )

(use-package undo-tree                  ;very helpful undo visualizer
  :defer 0
  :config
  (global-undo-tree-mode 1)
  ;; (setq undo-tree-auto-save-history 1)
  (defadvice undo-tree-make-history-save-file-name ;automatically compresses the undo history file
      (after undo-tree activate)
    (setq ad-return-value (concat ad-return-value ".gz")))
  )

(use-package key-chord
  :defer 0
  :config
  (key-chord-mode 1)
  (key-chord-define-global "ji" 'my/modalka-normal-mode)
  )

;; below, all are deferred until called ------------------------------------------------------
(use-package swiper                     ;i-search on steroroids
  :defer t
  :config
  )

(use-package counsel                    ;ivy-based functions
  :defer t
  :config

  )

(use-package projectile                 ;prokect management
  :defer t
  :config
  (projectile-mode +1)
  (setq projectile-completion-system 'ivy)
  (setq projectile-globally-ignored-file-suffixes '("pyc"))

  )

(use-package doom-themes                ;pretty themes
  :defer t
  :config
  )

(use-package magit                      ;best github client
  :defer t
  :config
  (add-hook 'magit-mode-hook (lambda () (modalka-mode -1)))
  (add-hook 'git-commit-mode-hook (lambda () (modalka-mode -1)))
  (add-to-list 'magit-no-confirm 'stage-all-changes)
  (use-package git-gutter)
  )


(use-package crux                       ;some very helpful functions
  :defer t
  :config
  )

(use-package smart-comment              ;just a better commenting function
  :defer t
  :config
  )

;; (use-package beacon                     ;flashes the cursor when scrolling, slows down large files
;;   :defer t
;;   :config
;;   )

;; (use-package dimmer                     ;dims other buffers
;;   :defer t
;;   :config
;;   (setq dimmer-adjustment-mode :background)
;;   (setq dimmer-fraction .05)
;;   )

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


(use-package company                    ;autocompletion system
  :defer t
  :config
  ;; (setq company-minimum-prefix-length 0)            ; WARNING, probably you will get perfomance issue if min len is 0!
  (setq company-tooltip-limit 20)                      ; bigger popup window
  (setq company-tooltip-align-annotations 't)          ; align annotations to the right tooltip border
  (setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
  ;; (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

  ;; provides almost instant autocompletion
  (setq company-idle-delay 0)
  ;; (setq ;; Only 2 letters required for completion to activate.
  ;;  company-minimum-prefix-length 1

  ;;  ;; Search other buffers for compleition candidates
  ;;  company-dabbrev-other-buffers t
  ;;  company-dabbrev-code-other-buffers t

  ;;  ;; Show candidates according to importance, then case, then in-buffer frequency
  ;;  company-transformers '(company-sort-by-backend-importance
  ;;                         company-sort-prefer-same-case-prefix
  ;;                         company-sort-by-occurrence)
  ;;  ;; Flushright any annotations for a compleition;
  ;;  ;; e.g., the description of what a snippet template word expands into.
  ;;  company-tooltip-align-annotations t
  ;;  ;; Allow (lengthy) numbers to be eligible for completion.
  ;;  company-complete-number t
  ;;  ;; Even if I write something with the ‘wrong’ case,
  ;;  ;; provide the ‘correct’ casing.
  ;;  company-dabbrev-ignore-case nil)
  ;; :custom
  ;; (company-begin-commands '(self-insert-command))
  (setq company-minimum-prefix-length 4)
  ;; (company-show-numbers t)
  ;; (company-tooltip-align-annotations 't)
  ;; (global-company-mode t)
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

(use-package expand-region              ;helpful for expanding the mark
  :defer t
  :config
  )

(use-package rainbow-delimiters         ;shows the depth of parenthesis with colors
  :defer t
  :config
  )

(use-package goto-chg
  :defer t

  )
(use-package color-identifiers-mode     ;colors differnet variable names
  :defer t
  :config
  )

;; (use-package indent-guide               ;shows indent lines on the left
;;   :defer t
;;   :config
;;   )

(use-package highlight-indent-guides
  :init
  (setq highlight-indent-guides-method 'character)
  :defer t
  :config

  )

(use-package all-the-icons              ;just has a nuch of icons for stuff
  :defer t
  :config
  )

(use-package all-the-icons-dired        ;shows icons in dired mode
  :defer t
  :config
  )

(use-package smooth-scrolling           ;automates smooth scrolling, kinda slow sometimes tho
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

(use-package web-mode
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

(use-package auctex
  :defer t
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  )

(use-package nlinum                     ;supposedly more efficient line mode
  :defer t
  :config

  )

(use-package rainbow-mode
  :defer t
  :config

  )

(use-package dired-narrow
  :defer t
  :config

  )

(use-package dired+
  :defer t
  :config

  )

(use-package smart-hungry-delete
  :defer t
  :config

  )

;; (use-package perspective
;;   :defer 1
;;   :config
;;   (persp-mode 1)

;;   )

(use-package iy-go-to-char
  :defer t
  :config

  )

(use-package yasnippet
  :defer t
  :config
  ;; check out here for full list: http://andreacrotti.github.io/yasnippet-snippets/snippets.html
  (use-package yasnippet-snippets
    :defer t
    :config

    )
  )

(use-package tuareg
  :defer t
  :config

  )

(use-package merlin
  :defer t
  :config

  )

(use-package merlin-eldoc
  :defer t
  :config

  )

(use-package fold-this
  :defer t
  :config

  )

(use-package moe-theme
  :defer t
  :config

  )

(use-package tao-theme
  :defer t
  :config

  )

(use-package smerge-mode
  :defer t
  :config

  )

(use-package outshine
  :init
  ;; Required for outshine
  (add-hook 'outline-minor-mode-hook 'outshine-mode)
  :defer t
  :config

  )

;; (use-package highlight-symbol
;;   :defer t
;;   :config
;;   (setq highlight-symbol-idle-delay 0)
;;   )

(use-package highlight-thing
  :defer t
  :config
  (setq highlight-thing-delay-seconds 0.0)
  ;; Don't highlight the thing at point itself. Default is nil.
  (setq highlight-thing-exclude-thing-under-point t)
  (setq highlight-thing-case-sensitive-p t)

  )


;; (use-package lsp-mode
;;   :defer t
;;   :config

;;   )

;; (use-package lsp-ui
;;   :defer t
;;   :config

;;   )

;; (use-package lsp-ivy
;;   :defer t
;;   :config

;;   )

;; (use-package golden-ratio
;;   :defer t
;;   :config

;;   )

(use-package format-all
  :defer t
  :config

  )

;; (use-package company-quickhelp
;;   :defer t
;;   :config
;;   (setq company-quickhelp-delay 0)
;;   )

(use-package web-beautify
  :defer t
  :config

  )

(use-package iedit
  :defer t
  :config

  )

(use-package volatile-highlights
  :defer t
  :config

  )

(use-package haskell-mode
  :defer t
  :config

  )

(use-package yaml-mode
  :defer t
  :config

  )

(use-package org-bullets
  :defer t
  :config
  
  )

;; (use-package ivy-rich
;;   :after ivy
;;   :custom
;;   (ivy-virtual-abbreviate 'full
;;                           ivy-rich-switch-buffer-align-virtual-buffer t
;;                           ivy-rich-path-style 'abbrev)
;;   :config
;;   (ivy-set-display-transformer 'ivy-switch-buffer
;;                                'ivy-rich-switch-buffer-transformer))

(use-package flycheck
  :defer t
  :config
  
  )

(use-package fix-word
  :defer t
  :config
  
  )

(use-package highlight-indentation
  :defer t
  :config
  
  )

(use-package indent-guide
  :defer t
  :config
  
  )

(use-package wakatime-mode
  :defer t
  :config
  (global-wakatime-mode)  
  )

;; (use-package counsel-spotify
;;   :defer t
;;   :init
;;   (setq counsel-spotify-client-id "03945bf411484a0ba9c32e25144f655d")
;;   (setq counsel-spotify-client-secret "4a994748c37644fcb9674ffb25f280a4")
;;   :config
  
;;   )

;; (use-package spotify
;;   :defer t
;;   :config
;;   (setq spotify-oauth2-client-secret "4a994748c37644fcb9674ffb25f280a4")
;;   (setq spotify-oauth2-client-id "03945bf411484a0ba9c32e25144f655d")
;;   )

;; (setq spotify-oauth2-client-secret "4a994748c37644fcb9674ffb25f280a4")
;; (setq spotify-oauth2-client-id "03945bf411484a0ba9c32e25144f655d")
;; (define-key spotify-mode-map (kbd "C-c .") 'spotify-command-map)


(use-package helm
  :defer t
  :config
  
  )
(use-package helm-swoop
  :defer t
  :config
  
  )

(use-package helm-spotify
  :defer t
  :config
  
  )


(provide 'my-packages)
