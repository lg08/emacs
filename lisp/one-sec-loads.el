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



(use-package smart-hungry-delete        ;deletes whitespace
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


(use-package tuareg                     ;major mode for oCaml editing
  :defer t
  :config

  )


(use-package web-mode                   ;better web development major mode  :defer t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  :config
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t)

  )

(use-package smart-comment              ;just a better commenting function
  :defer t
  :config
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

(use-package grandshell-theme
  :defer t
  :config

  )

(use-package poet-theme
  :defer t
  :config

  )

(use-package tron-legacy-theme
  :defer t
  :config

  )
(use-package slack
  :commands (slack-start)
  :init
  (setq slack-buffer-emojify t) ;; if you want to enable emoji, default nil
  (setq slack-prefer-current-team t)
  :config
  (slack-register-team
   :name "emacs-slack"
   :default t
   :token "xoxs-1391388007062-1395035382069-1585799356885-5686a8ff205845243142f9ada94b244e45074f89f22e83c707e63e3ae515da03"
   :subscribed-channels '(test-rename rrrrr)
   :full-and-display-names t)

  (evil-define-key 'normal slack-info-mode-map
    ",u" 'slack-room-update-messages)
  (evil-define-key 'normal slack-mode-map
    ",c" 'slack-buffer-kill
    ",ra" 'slack-message-add-reaction
    ",rr" 'slack-message-remove-reaction
    ",rs" 'slack-message-show-reaction-users
    ",pl" 'slack-room-pins-list
    ",pa" 'slack-message-pins-add
    ",pr" 'slack-message-pins-remove
    ",mm" 'slack-message-write-another-buffer
    ",me" 'slack-message-edit
    ",md" 'slack-message-delete
    ",u" 'slack-room-update-messages
    ",2" 'slack-message-embed-mention
    ",3" 'slack-message-embed-channel
    "\C-n" 'slack-buffer-goto-next-message
    "\C-p" 'slack-buffer-goto-prev-message)
   (evil-define-key 'normal slack-edit-message-mode-map
    ",k" 'slack-message-cancel-edit
    ",s" 'slack-message-send-from-buffer
    ",2" 'slack-message-embed-mention
    ",3" 'slack-message-embed-channel))


;; ---------------------------------------------------------------
(require 'my-functions)
;; (load-theme 'doom-gruvbox)
(provide 'one-sec-loads)
