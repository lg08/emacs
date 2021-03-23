    ;;; -*- lexical-binding: t -*-

(require 'ivy-helm)                     ;sets up ivy and  helm

(require 'major-modes)                  ;makes all major modes available

;; major modes --------------------------------------------------


(use-package which-key                  ;shows possible keyboard
                                        ;commands, just uncomment if
                                        ;you want it
  :defer 1
  :config
  (which-key-mode t)
  (which-key-setup-side-window-bottom)
  (setq which-key-idle-delay .2)

  )


(use-package key-chord
  :defer 1
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

;; ;; below, all are deferred until called ------------------------------------------------------
(use-package projectile                 ;project management
  :defer t
  :init
  (setq projectile-known-projects-file  (expand-file-name "projectile-bookmarks.eld" gemacs-misc-dir))
  (setq projectile-cache-file (expand-file-name "projectile.cache" gemacs-misc-dir))
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


;; potential deep learning thing; could be dope
;; (use-package company-tabnine :ensure t)
;; (add-to-list 'company-backends 'company-tabnine)

(use-package all-the-icons              ;just has a bunch of icons for stuff
  :defer t
  :config
  )



(use-package restart-emacs              ;restarts emacs
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
  :defer t
  :init
  (setq url-configuration-directory (expand-file-name "url" gemacs-misc-dir))
  :config

  )


(use-package magit                      ;best github client
  :defer t
  :config
  ;; (add-to-list 'magit-no-confirm 'stage-all-changes)
  ;; (remove-hook 'server-switch-hook 'magit-commit-diff)

  ;; (add-hook 'git-commit-mode-hook
  ;;           (lambda ()
  ;;             (set-fill-column 72)))
  )

(use-package shell-pop
  :init
  (setq shell-pop-window-size '30)
  (setq shell-pop-term-shell "/usr/bin/zsh")
  (setq shell-pop-window-position "bottom")
  ;; :defer t
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


(use-package undo-tree                  ;very helpful undo visualizer
  :init
  (global-undo-tree-mode 1)
  :defer t
  :config
  (setq undo-tree-visualizer-timestamps 1)
  (setq undo-tree-visualizer-diff 1)
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


(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
      TeX-source-correlate-start-server t)

(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)


(use-package vi-tilde-fringe
  :init
  (global-vi-tilde-fringe-mode)
  :config

  )

(use-package smart-hungry-delete        ;deletes whitespace
  :defer t
  :config

  )


(use-package fix-word                   ;used to capitalize words and stuff
  :defer t
  :config

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

(provide 'one-sec-loads)
