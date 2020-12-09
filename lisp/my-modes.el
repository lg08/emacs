;; sets up all the settings for different modes


;; all the shit I always want while coding
(add-hook 'prog-mode-hook (lambda ()
                            (global-company-mode 1)
                            (rainbow-delimiters-mode 1)
                            ;; (global-color-identifiers-mode 1)
                            (global-undo-tree-mode 1)
                            (highlight-thing-mode)
                            (volatile-highlights-mode)
                            (aggressive-indent-mode 1)
			    (global-git-gutter-mode)
			    ;; (global-flycheck-mode 1)
			    (highlight-indent-guides-mode)
			    ))

(add-hook 'dired-mode-hook (lambda ()
                             (put 'dired-find-alternate-file 'disabled nil) ;disables the warning
                             (dired-hide-details-mode 1)
                             (setq dired-dwim-target t)
                             (all-the-icons-dired-mode)
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
                           (general-define-key
                            :keymaps 'modalka-mode-map
                            "SPC a o" 'begin/end_org
                            )
			   ))
(add-hook 'tuareg-mode-hook (lambda ()
                              (merlin-mode 1)
                              (general-define-key
                               "C-c r" 'tuareg-eval-region
                               )
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
                         (add-to-list 'company-backends 'company-c-headers)

                         ))

(add-hook 'eshell-mode-hook (lambda ()
                              (company-mode -1)
                              ))


(defun clojure-leave-clojure-mode-function ()
  (when (eq major-mode 'clojure-mode)
    (message "Leaving clojure-mode.")))

(defun org-leave-mode-function ()
  (when (eq major-mode 'org-mode)
    (message "Leaving org-mode.")
    (general-define-key
     :keymaps 'modalka-mode-map
     "SPC a o" 'nil
     )
    ))

(defun dired-leave-mode-function ()
  (when (eq major-mode 'dired-mode)
    (message "Leaving dired-mode.")
    ;; (general-define-key
    ;;  :keymaps 'modalka-mode-map
    ;;  "u" 'nil
    ;;  "u" 'undo-tree-undo
    ;;  )
    (define-key 'modalka-mode-map "u" 'undo-tree-undo)
    ))

(add-hook 'change-major-mode-hook (lambda ()
                                    ;; (clojure-leave-clojure-mode-function)

                                    (org-leave-mode-function)
                                    (dired-leave-mode-function)
                                    ))


(provide 'my-modes)
