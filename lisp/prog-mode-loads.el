


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
  :config
  (setq highlight-indent-guides-responsive 'top)
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
  (setq company-idle-delay .5)
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

;; link here: https://github.com/emacs-evil/evil-surround
(use-package evil-surround
  :defer t
  :ensure t
  :config
  (global-evil-surround-mode 1)
  )

(use-package highlight-parentheses
  :defer t
  :config

  )




(use-package evil-matchit
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
(use-package undo-tree                  ;very helpful undo visualizer
  :defer t
  :config
  (global-undo-tree-mode 1)
  (defadvice undo-tree-make-history-save-file-name ;automatically compresses the undo history file
      (after undo-tree activate)
    (setq ad-return-value (concat ad-return-value ".gz")))
  )
(use-package eyebrowse                  ;window management package
  :config
  (eyebrowse-mode 1)
  (setq eyebrowse-new-workspace t)
  )

(provide 'prog-mode-loads)
