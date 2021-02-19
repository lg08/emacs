
(setq frame-title-format
      '("" invocation-name ": "
        (:eval
         (if buffer-file-name
             (abbreviate-file-name buffer-file-name)
           "%b"))))


(use-package minimap
  :defer t
  :config

  )

;; keep the point out of the minibuffer
(setq-default minibuffer-prompt-properties '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt))

(use-package vlf
  :defer t
  :config

  )



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mini-frame-show-parameters '((top . 0) (width . 0.7) (left . 0.5) (height . 15)))
 '(org-file-apps
   '((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . "vivaldi %s")))     ;changes what default app org mode uses to open pdf files
 '(wakatime-python-bin nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-ui-doc-background ((t (:background nil))))
 '(lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic))))))


(setq org-adapt-indentation nil)

(auto-fill-mode)

(provide 'my-testing-stuff)
