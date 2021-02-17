(require 'autocompletion)
(require 'lsp-mode.el)


(use-package smart-hungry-delete        ;deletes whitespace
  :defer t
  :config

  )

(use-package smart-comment              ;just a better commenting function
  :defer t
  :config
  )


(use-package gcmh                       ;garbage management system
  :defer 1
  :config
  (gcmh-mode)
  ;; Adopt a sneaky garbage collection strategy of waiting until idle time to
  ;; collect; staving off the collector while the user is working.
  (setq gcmh-idle-delay 5
        gcmh-high-cons-threshold (* 16 1024 1024)  ; 16mb
        ;; gcmh-verbose doom-debug-p
        )
  )


(use-package imenu-anywhere
  :defer t
  :config

  )

;; A more complex, more lazy-loaded config
(use-package solaire-mode
  :defer t
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

(use-package swiper
  :init
  (define-key ivy-minibuffer-map "\C-k" 'nil)
  :defer t
  :config
  )


(use-package move-text
  :defer t
  :config
  (move-text-default-bindings)
  )

;; ------------different highlighters
(use-package indent-guide               ;another useful indent-guide package
  :defer t
  :config
  (setq indent-guide-recursive t)
  (setq indent-guide-delay 0.1)
  ;; (set-face-background 'indent-guide-face "#282a36")
  (set-face-background 'indent-guide-face "#1E2029")
  (set-face-foreground 'indent-guide-face "dimgray")
  )

(use-package highlight-indentation
  :defer t
  :config
  (setq highlight-indentation-blank-lines t)
  )

(use-package highlight-indent-guides
  :defer t
  :init
  :config
  ;; (setq highlight-indent-guides-responsive 'top)
  (setq highlight-indent-guides-delay 0.8)
  (setq highlight-indent-guides-method 'character)
  )

(use-package visual-indentation-mode
  :defer t
  :config

  )

(use-package wakatime-mode
  :defer 1
  :init
  (setq wakatime-api-key "4e8965d1-c63b-4bb1-9673-5c1dc7519277")
  (setq wakatime-cli-path "/usr/local/bin/wakatime")
  :config
  (global-wakatime-mode)
  )
(use-package go-mode
  :defer t
  :config

  )
(use-package google-this
  :defer t
  :config
  )

(use-package flycheck                   ;automatic spell-checking and stuff
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






(use-package fix-word                   ;used to capitalize words and stuff
  :defer t
  :config

  )


(use-package format-all                 ;used to format code
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
(use-package yasnippet                  ;abbreviation package
  :defer t
  :config
  ;; check out here for full list: http://andreacrotti.github.io/yasnippet-snippets/snippets.html
  (use-package yasnippet-snippets       ;bunch of common snippets
    :defer t
    :config

    )
  )

(use-package rainbow-delimiters         ;shows the depth of parenthesis with colors
  :defer t
  :config
  )




(use-package multiple-cursors           ;allows editing for multiple cursors
  :defer t
  :init
  (setq mc/list-file (concat gemacs-misc-dir ".mc-lists.el"))
  ;; :ensure t
  :config
  )

(use-package aggressive-indent          ;forces indent
  :defer t
  :config
  ;; removes modes from the auto indent
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  )



(use-package avy                        ;dope jumping to characters package
  :defer t
  :config
  (setq avy-all-windows 'nil)             ;limits the search to one window
  (setq avy-background t)
  (setq avy-keys (number-sequence ?a ?z))

  )



(use-package highlight-parentheses
  :defer t
  :config

  )

(use-package volatile-highlights        ;just helpful for showing what you just did
  :defer t
  :config

  )
(use-package outshine                   ;org-mode in the comments
  :defer t
  :init
  ;; Required for outshine
  (add-hook 'outline-minor-mode-hook 'outshine-mode)
  :config

  )
(use-package smerge-mode                ;useful for merging git conflicts
  :defer t
  :init
  (setq smerge-command-prefix "\C-cv")
  :config

  )
(use-package rainbow-mode               ;shows color codes
  :defer t
  :config

  )
(use-package writeroom-mode             ;distraction-free editing
  :defer t
  :config

  )

(use-package rg)
  ;; :ensure-system-package rg) ;; ⇒ There's a buffer *system-packages*
                             ;;   installing this tool at the OS level!
;; check this out here: https://github.com/alhassy/emacs.d

;; lets you browse system packages with helm
(use-package helm-system-packages
  :defer t
  :config

  )

;; (use-package pdf-tools
;;   :defer t
;;   ;; :init   (system-packages-ensure "pdf-tools")
;;   :custom (pdf-tools-handle-upgrades nil)
;;           (pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo")
;;   :config (pdf-tools-install))

;; Now PDFs opened in Emacs are in pdfview-mode.



(setq message-send-mail-function 'smtpmail-send-it)

;; Make mail look pretty
(use-package all-the-icons-gnus
  :defer t
  :config (all-the-icons-gnus-setup))
(setq gnus-sum-thread-tree-vertical        "│"
      gnus-sum-thread-tree-leaf-with-other "├─► "
      gnus-sum-thread-tree-single-leaf     "╰─► "
      gnus-summary-line-format
      (concat
       "%0{%U%R%z%}"
       "%3{│%}" "%1{%d%}" "%3{│%}"
       "  "
       "%4{%-20,20f%}"
       "  "
       "%3{│%}"
       " "
       "%1{%B%}"
       "%s\n"))

(use-package highlight-numbers
  :defer t
  :config
  ;; (highlight-numbers-mode 1)
  )

(use-package dumb-jump
  :defer t
  :config

  )


(provide 'prog-mode-loads)
