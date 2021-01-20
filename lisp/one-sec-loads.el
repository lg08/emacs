(require 'evil-loads)



;; for mac people
(use-package exec-path-from-shell
  :init
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

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
  (setq ivy-height 25)
  )

(use-package ivy-rich
  :defer 1
  :config
  (ivy-rich-mode 1)
  ;; (ivy-rich-project-root-cache-mode 1)  ;better performance especially for switch to buffer
  )

(use-package counsel
  :defer t
  :config

  )

(use-package prescient
  :defer 1
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

(use-package which-key                  ;shows possible keyboard commands, just uncomment if you want it
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

;; below, all are deferred until called ------------------------------------------------------
(use-package projectile                 ;project management
  :defer t
  :init
  (setq projectile-known-projects-file  (expand-file-name "projectile-bookmarks.eld" gemacs-misc-dir))
  (setq projectile-cache-file (expand-file-name "projectile.cache" gemacs-misc-dir))
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
  :defer 1
  :init
  (doom-modeline-mode 1)
  :config
  (doom-modeline-mode)
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
  :defer t
  :init
  (setq url-configuration-directory (expand-file-name "url" gemacs-misc-dir))
  :config

  )

(use-package multi-term                 ;pretty good terminal thing
  :defer t
  :init
  :config

  )



(use-package magit                      ;best github client
  :defer t
  :config
  (add-to-list 'magit-no-confirm 'stage-all-changes)
  (remove-hook 'server-switch-hook 'magit-commit-diff)

  (add-hook 'git-commit-mode-hook
            (lambda ()
              (set-fill-column 72)))
  )

(use-package shell-pop
  :init
  (setq shell-pop-window-size '30)
  (setq shell-pop-term-shell "/usr/bin/zsh")
  (setq shell-pop-window-position "bottom")
  :defer t
  )

(use-package poet-theme
  :defer t
  :config

  )



(use-package anzu
  :init
  (global-anzu-mode +1)
  :defer t
  :config

  )

(use-package bm
  :ensure t
  :demand t

  :init
  ;; restore on load (even before you require bm)
  (setq bm-restore-repository-on-load t)


  :config
  ;; Allow cross-buffer 'next'
  ;; (setq bm-cycle-all-buffers t)

  ;; where to store persistant files
  (setq bm-repository-file "~/.emacs.d/bm-repository")

  ;; save bookmarks
  (setq-default bm-buffer-persistence t)

  ;; Loading the repository from file when on start up.
  (add-hook 'after-init-hook 'bm-repository-load)

  ;; Saving bookmarks
  (add-hook 'kill-buffer-hook #'bm-buffer-save)

  ;; Saving the repository to file when on exit.
  ;; kill-buffer-hook is not called when Emacs is killed, so we
  ;; must save all bookmarks first.
  (add-hook 'kill-emacs-hook #'(lambda nil
                                 (bm-buffer-save-all)
                                 (bm-repository-save)))

  ;; The `after-save-hook' is not necessary to use to achieve persistence,
  ;; but it makes the bookmark data in repository more in sync with the file
  ;; state.
  (add-hook 'after-save-hook #'bm-buffer-save)

  ;; Restoring bookmarks
  (add-hook 'find-file-hooks   #'bm-buffer-restore)
  (add-hook 'after-revert-hook #'bm-buffer-restore)

  ;; The `after-revert-hook' is not necessary to use to achieve persistence,
  ;; but it makes the bookmark data in repository more in sync with the file
  ;; state. This hook might cause trouble when using packages
  ;; that automatically reverts the buffer (like vc after a check-in).
  ;; This can easily be avoided if the package provides a hook that is
  ;; called before the buffer is reverted (like `vc-before-checkin-hook').
  ;; Then new bookmarks can be saved before the buffer is reverted.
  ;; Make sure bookmarks is saved before check-in (and revert-buffer)
  (add-hook 'vc-before-checkin-hook #'bm-buffer-save)

  :bind (("<f2>" . bm-next)
         ("S-<f2>" . bm-previous)
         ("C-<f2>" . bm-toggle))
  )

(use-package perspective
  :init
  (persp-mode 1)
  :defer t
  :config
  )


(use-package hl-todo
  ;; :defer t
  :config
  (setq hl-todo-keyword-faces
        '(
          ("TODO"   . "#1E90FF")
          ("FIXME"  . "#FF0000")
          ("DEBUG"  . "#A020F0")
          ("GOTCHA" . "#FF4500")
          ("STUB"   . "#1E90FF")
          ))
  (global-hl-todo-mode 1)
  )
;; ---------------------------------------------------------------
(require 'my-functions)
;; (load-theme 'doom-vibrant)


(set-face-attribute 'hl-line nil :inherit nil :background "black")


(provide 'one-sec-loads)
