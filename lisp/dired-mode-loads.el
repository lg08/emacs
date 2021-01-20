(use-package dired-narrow               ;used to search in dired
  :defer t
  :config

  )
(use-package all-the-icons-dired        ;shows icons in dired mode
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

(provide 'dired-mode-loads)
