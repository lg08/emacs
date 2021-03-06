;; sets up all the settings for different modes

(add-hook 'text-mode-hook (lambda ()
                            (require 'autocompletion)
                            ))

;; all the shit I always want while coding
(add-hook 'prog-mode-hook (lambda ()
                            (require 'prog-mode-loads)
                            (rainbow-delimiters-mode 1)
                            ;; (global-undo-tree-mode 1)
                            (highlight-thing-mode)
                            (volatile-highlights-mode)
                            (global-highlight-parentheses-mode)
                            ;; (wakatime-mode)
                            ;; (indent-guide-mode 1)
                            ;; (highlight-indent-guides-mode 1)
                            (electric-pair-mode 1)
                            (global-evil-matchit-mode 1)
                            (yas-global-mode 1)
                            (global-evil-surround-mode 1)
                            (highlight-numbers-mode 1)
                            (adaptive-wrap-prefix-mode 1)
                            (display-fill-column-indicator-mode 1)
                            (auto-fill-mode 1)
                            (message "prog-mode loaded successfully")
                            ))


(add-hook 'pdf-view-mode-hook (lambda ()
                                (pdf-continuous-scroll-mode 1)
                                (display-line-numbers-mode -1)
                                (message "pdf-mode loaded successfully")
                                ))

(add-hook 'dired-mode-hook (lambda ()
                             (require 'dired-mode-loads)
                             (put 'dired-find-alternate-file 'disabled nil) ;disables the warning
                             (dired-hide-details-mode 1)
                             (setq dired-dwim-target t)
                             (all-the-icons-dired-mode)
                             (message "dired-mode loaded successfully")
                             ))

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-hook 'web-mode-hook (lambda ()
                           (require 'html-mode-loads)
                           (emmet-mode 1)
                           (web-mode-set-engine "django")
                           ;; (electric-pair-mode -1)
                           (rainbow-mode 1)
                           (set (make-local-variable 'company-backends) '(company-css company-web-html company-yasnippet company-files))
                           (highlight-indent-guides-mode -1)
                           (message "web-mode loaded successfully")
                           ))

(add-hook 'magit-mode-hook (lambda ()
                             (require 'magit-mode-loads)
                             (magit-todos-mode)
                             (message "magit-mode loaded successfuly")
                             ))
(add-hook 'python-mode-hook (lambda ()
                              (require 'python-mode-loads)
                              (message "python-mode loaded successfully")
                              ))
(add-hook 'org-mode-hook (lambda ()
                           (require 'org-mode-loads)
                           (require 'autocompletion)
                           ;; (org-indent-mode)
                           ;; (org-bullets-mode)
                           ;; (wakatime-mode)
                           ;; (setq org-agenda-files (list "~/.emacs.d/agenda.org"))

                           (message 'org-mode loaded successfully)
                           ))
(add-hook 'tuareg-mode-hook (lambda ()
                              (require 'ocaml-mode-loads)
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
                              (message "tuareg mode loaded successfully")
                              ))
(add-hook 'c-mode-hook (lambda ()
                         (require 'c-mode-loads)
                         (setq fill-column 73)
                         (display-fill-column-indicator-mode)
                         (define-key (current-local-map) (kbd "C-M-h") 'c-mark-function)
                         ;; (add-to-list 'company-backends 'company-c-headers)
                         (message "c-mode loaded successfully")
                         ))

(add-hook 'eshell-mode-hook (lambda ()
                              (company-mode -1)
                              (message "eshell-mode loaded successfully")
                              ))

;; (add-hook 'dired-sidebar-mode (lambda () (toggle-truncate-lines)))


(defun clojure-leave-clojure-mode-function ()
  (when (eq major-mode 'clojure-mode)
    (message "Leaving clojure-mode.")))

(defun org-leave-mode-function ()
  (when (eq major-mode 'org-mode)
    (message "Leaving org-mode.")

    ))

(defun dired-leave-mode-function ()
  (when (eq major-mode 'dired-mode)
    (message "Leaving dired-mode.")
    ;; (general-define-key
    ;;  :keymaps 'modalka-mode-map
    ;;  "u" 'nil
    ;;  "u" 'undo-tree-undo
    ;;  )
    ;; (define-key 'modalka-mode-map "u" 'undo-tree-undo)
    ))

(add-hook 'change-major-mode-hook (lambda ()
                                    (org-leave-mode-function)
                                    (dired-leave-mode-function)
                                    ))


(provide 'my-modes)
