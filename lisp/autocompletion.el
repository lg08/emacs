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
  (setq company-idle-delay 0)
  ;;  ;; Search other buffers for compleition candidates
  (setq company-dabbrev-other-buffers t)
  (setq company-dabbrev-code-other-buffers t)

   ;; Show candidates according to importance, then case, then in-buffer frequency
  (setq company-transformers '(company-sort-by-backend-importance
                               company-sort-prefer-same-case-prefix
                               company-sort-by-occurrence))
  ;;  ;; Even if I write something with the ‘wrong’ case,
  ;;  ;; provide the ‘correct’ casing.
  (setq company-dabbrev-ignore-case nil)
  ;; :custom
  (setq company-minimum-prefix-length 0)
  )

;; With use-package:
(use-package company-box
  :defer t
  :hook (company-mode . company-box-mode))


;; (use-package company-quickhelp
;;   :defer t
;;   :init
;;   (company-quickhelp-mode 1)
;;   )


;; (set-variable 'ycmd-server-command '("python3" "/usr/bin/ycmd"))
;; (use-package ycmd
;;   :config
;;   (progn
;;     (global-ycmd-mode)
;;     (set-variable 'ycmd-server-command
;;                   ;; '("python" "/home/jeaye/.emacs.d/packages/ycmd/ycmd/")
;;                   '("python3" "/usr/bin/ycmd")
;;                   )
;;     (set-variable 'ycmd-extra-conf-whitelist '("~/projects/*"))
;;     (setq ycmd-extra-conf-handler 'load)))

;; (use-package company-ycmd
;;   :config
;;   (progn
;;     (setq company-backends (delete 'company-clang company-backends))
;;     (setq company-idle-delay 0)
;;     (global-company-mode)
;;     (company-ycmd-setup)

;;     (define-key company-active-map (kbd "TAB") 'company-select-next)
;;     (define-key company-active-map [tab] 'company-select-next)
;;     (setq company-selection-wrap-around t)

;;     ; Company + fci is fucked
;;     ; https://github.com/company-mode/company-mode/issues/180
;;     (defvar-local company-fci-mode-on-p nil)
;;     (defun company-turn-off-fci (&rest ignore)
;;       (when (boundp 'fci-mode)
;;         (setq company-fci-mode-on-p fci-mode)
;;         (when fci-mode (fci-mode -1))))
;;     (defun company-maybe-turn-on-fci (&rest ignore)
;;       (when company-fci-mode-on-p (fci-mode 1)))
;;     (add-hook 'company-completion-started-hook 'company-turn-off-fci)
;;     ;; (add-to-hooks '(company-completion-finished-hook
;;     ;;                 company-completion-cancelled-hook)
;;     ;;               'company-maybe-turn-on-fci)
;; ))
;;     (use-package company-quickhelp
;;       :config
;;       (progn
;;         (company-quickhelp-mode 1)))))

;; ;; (use-package flycheck-ycmd
;; ;;   :config
;; ;;   (progn
;; ;;     (flycheck-ycmd-setup)
;; ;;     (global-flycheck-mode)))


(general-define-key
 :keymaps 'company-active-map
 "C-j" 'company-select-next
 "C-l" 'company-complete-selection
 "C-k" 'company-select-previous
 "<RET>" 'company-complete-selection
 )

;; (global-set-key (kbd "C-<return>") 'company-complete)


(provide 'autocompletion)
