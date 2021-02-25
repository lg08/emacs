
(setq frame-title-format
      '("" invocation-name ": "
        (:eval
         (if buffer-file-name
             (abbreviate-file-name buffer-file-name)
           "%b"))))




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
     ("\\.pdf\\'" . "opera %s")))     ;changes what default app org mode uses to open pdf files
 '(wakatime-python-bin nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-ui-doc-background ((t (:background nil))))
 '(lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic))))))


(setq org-adapt-indentation nil)


(global-set-key (kbd "C-c o")'hippie-expand)


(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
      TeX-source-correlate-start-server t)

(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)



;;     (setq dcsh-command-list '("all_registers"
;;                               "check_design" "check_test" "compile" "current_design"
;;                               "link" "uniquify"
;;                               "report_timing" "report_clocks" "report_constraint"
;;                               "get_unix_variable" "set_unix_variable"
;;                               "set_max_fanout"
;;                               "report_area" "all_clocks" "all_inputs" "all_outputs"))

;;     (defun he-dcsh-command-beg ()
;;       (let ((p))
;;         (save-excursion
;;           (backward-word 1)
;;           (setq p (point)))
;;         p))

;;     (defun try-expand-dcsh-command (old)
;;       (unless old
;;         (he-init-string (he-dcsh-command-beg) (point))
;;         (setq he-expand-list (sort
;;                               (all-completions he-search-string (mapcar 'list dcsh-command-list))
;;                               'string-lessp)))
;;       (while (and he-expand-list
;;               (he-string-member (car he-expand-list) he-tried-table))
;;         (setq he-expand-list (cdr he-expand-list)))
;;       (if (null he-expand-list)
;;           (progn
;;             (when old (he-reset-string))
;;             ())
;;         (he-substitute-string (car he-expand-list))
;;         (setq he-tried-table (cons (car he-expand-list) (cdr he-tried-table)))
;;         (setq he-expand-list (cdr he-expand-list))
;;         t))


;; (global-set-key (kbd "C-c i") (make-hippie-expand-function
;;                              '(try-expand-dcsh-command
;;                                try-expand-dabbrev-visible
;;                                try-expand-dabbrev
;;                                try-expand-dabbrev-all-buffers) t))


;; (use-package pabbrev
;;   :defer t
;;   :config

;;   )

(provide 'my-testing-stuff)
