;; sets up all the settings for different modes

;; all the shit I always want while coding
(add-hook 'prog-mode-hook (lambda ()
                            (require 'prog-mode-loads)
                            (global-company-mode 1)
                            (rainbow-delimiters-mode 1)
                            (global-undo-tree-mode 1)
                            (highlight-thing-mode)
                            (volatile-highlights-mode)
                            (global-highlight-parentheses-mode)
                            (wakatime-mode)
                            (indent-guide-mode 1)
                            (electric-pair-mode 1)
                            (global-evil-matchit-mode 1)
                            (yas-global-mode 1)
                            (global-evil-surround-mode 1)
                            (toggle-truncate-lines)
                            (highlight-numbers-mode 1)
                            ))

(add-hook 'dired-mode-hook (lambda ()
                             (require 'dired-mode-loads)
                             (put 'dired-find-alternate-file 'disabled nil) ;disables the warning
                             (dired-hide-details-mode 1)
                             (setq dired-dwim-target t)
                             (all-the-icons-dired-mode)
                             ))

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-hook 'web-mode-hook (lambda ()
                           (require 'html-mode-loads)
                           (emmet-mode 1)
                           (web-mode-set-engine "django")
                           (electric-pair-mode -1)
                           (rainbow-mode 1)
                           (set (make-local-variable 'company-backends) '(company-css company-web-html company-yasnippet company-files))
                           ))

(add-hook 'magit-mode-hook (lambda ()
                             (require 'magit-mode-loads)
                             (magit-todos-mode)
                             ))
(add-hook 'python-mode-hook (lambda ()
                              (require 'python-mode-loads)
                              ))
(add-hook 'org-mode-hook (lambda ()
                           (require 'org-mode-loads)
                           (org-indent-mode)
                           (org-bullets-mode)
                           (wakatime-mode)
                           (setq org-agenda-files (list "~/.emacs.d/agenda.org"))

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
                              ))
(add-hook 'c-mode-hook (lambda ()
                         (require 'c-mode-loads)
                         (setq fill-column 73)
                         (display-fill-column-indicator-mode)
                         (define-key (current-local-map) (kbd "C-M-h") 'c-mark-function)
                         ;; (add-to-list 'company-backends 'company-c-headers)

                         ))

(add-hook 'eshell-mode-hook (lambda ()
                              (company-mode -1)
                              ))

(add-hook 'dired-sidebar-mode (lambda () (toggle-truncate-lines)))

(defun sidebarbaby ()
  (interactive)
  (toggle-truncate-lines)
  )



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
