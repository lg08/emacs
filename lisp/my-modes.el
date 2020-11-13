;; sets up all the settings for different modes


;; all the shit I always want while coding
(add-hook 'prog-mode-hook (lambda ()
                            ;; (dimmer-mode 1)
                            (global-company-mode 1)
                            ;; (rainbow-delimiters-mode 1)
                            ;; (global-color-identifiers-mode 1)
                            (global-undo-tree-mode 1)
                            ;; (smartparens-global-mode 1)
                            ;; (outline-minor-mode)
                            (highlight-thing-mode)
                            ;; (highlight-indent-guides-mode)
                            ;; (lsp-mode 1)
                            ;; (lsp-ui-mode 1)
                            ;; (golden-ratio-mode)
                            ;; (company-quickhelp-mode 1)
                            (volatile-highlights-mode)
                            (wakatime-mode 1)
                            ))

(add-hook 'dired-mode-hook (lambda ()
                             (put 'dired-find-alternate-file 'disabled nil) ;disables the warning
                             ;; (dired-hide-details-mode 1)
                             (setq dired-dwim-target t)
                             (all-the-icons-dired-mode)
                             (require 'dired-x)
                             ))

(add-hook 'web-mode-hook (lambda ()
                           (emmet-mode)
                           (web-mode-set-engine "django")
                           (electric-pair-mode -1)
                           (rainbow-mode 1)
                           (smartparens-mode -1)
                           ))

(add-hook 'magit-mode-hook (lambda ()
                             (global-git-gutter-mode)
                             ;; (add-hook 'magit-popup-hook ' (lambda () (modalka-mode -1)))
                             ))
(add-hook 'python-mode-hook (lambda ()
                              (elpy-enable)
                              (setq elpy-rpc-python-command "python3") ;only if you're using python3
                              (add-to-list (make-local-variable 'company-backends)
                                           'company-anaconda)
                              ))
(add-hook 'org-mode-hook (lambda ()
                           (org-indent-mode)
                           (org-bullets-mode)
                           (wakatime-mode 1)
                           ))
(add-hook 'tuareg-mode-hook (lambda ()
                              (merlin-mode 1)
                              (general-define-key
                              "C-c r" 'tuareg-eval-region
                              )
                              ;; (company-mode -1)
                              ;; (column-marker-1 79)
                              ;; (column-marker-2 80)
                              ;; (merlin-eldoc-setup)
                              (setq fill-column 80)
                              (display-fill-column-indicator-mode)
                              (setq prettify-symbols-alist
                                    '(
                                      ("lambda" . 955) ; λ
                                      ("->" . 8594)    ; →
                                      ("=>" . 8658)    ; ⇒
                                      ("map" . 8614)    ; ↦
                                      ;; ("begin" . "❄")
                                      ;; ("end" . "❄")
                                      ))
                              (prettify-symbols-mode 1)
                              ))
(add-hook 'c-mode-hook (lambda ()
                         (setq fill-column 73)
                         (display-fill-column-indicator-mode)
                         (define-key (current-local-map) (kbd "C-M-h") 'c-mark-function)
                         (ggtags-mode)
                         (helm-gtags-mode)
                         (add-to-list 'company-backends 'company-c-headers)

                         ))

(add-hook 'eshell-mode-hook (lambda ()
                              (company-mode -1)
                              ))

(setq prettify-symbols-alist
      '(
        ("lambda" . 955) ; λ
        ("->" . 8594)    ; →
        ("=>" . 8658)    ; ⇒
        ("map" . 8614)    ; ↦
        ))
                                
                                
(provide 'my-modes)
