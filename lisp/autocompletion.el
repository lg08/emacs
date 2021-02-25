(defun user/company-complete-selection ()
  "Insert the selected candidate or the first if none are selected."
  (interactive)
  (if company-selection
      (company-complete-selection)
    (company-complete-number 1)))

(defconst *clangd*
  (or (executable-find "clangd")  ;; usually
      (executable-find "/usr/local/opt/llvm/bin/clangd"))  ;; macOS
  "Do we have clangd?")


(use-package company
  :diminish company-mode
  :init
  (setq company-backends '((company-files company-keywords company-capf
                                          company-dabbrev-code
                                          company-etags company-dabbrev)))
  (global-company-mode 1)
  :hook ((prog-mode LaTeX-mode latex-mode ess-r-mode) . company-mode)
  :bind
  (:map company-active-map
        ([tab] . user/company-complete-selection)
        ("TAB" . user/company-complete-selection))
  :custom
  (company-minimum-prefix-length 1)
  (company-tooltip-align-annotations t)
  (company-require-match 'never)
  ;; Don't use company in the following modes
  (company-global-modes '(not shell-mode eaf-mode))
  ;; Trigger completion immediately.
  (company-idle-delay 0.2)
  ;; Number the candidates (use M-1, M-2 etc to select completions).
  (company-show-numbers t)
  :config
  ;; (unless clangd-p (delete 'company-clang company-backends))
  (global-company-mode 1)
  ;; (defun smarter-tab-to-complete ()
;;     "Try to `org-cycle', `yas-expand', and `yas-next-field' at current cursor position.

;; If all failed, try to complete the common part with `company-complete-common'"
;;     (interactive)
;;     (if yas-minor-mode
;;         (let ((old-point (point))
;;               (old-tick (buffer-chars-modified-tick))
;;               (func-list '(org-cycle yas-expand yas-next-field)))
;;           (catch 'func-suceed
;;             (dolist (func func-list)
;;               (ignore-errors (call-interactively func))
;;               (unless (and (eq old-point (point))
;;                            (eq old-tick (buffer-chars-modified-tick)))
;;                 (throw 'func-suceed t)))
;;             (company-complete-common)))))
  )

(defun text-mode-hook-setup ()
  ;; make `company-backends' local is critcal
  ;; or else, you will have completion in every major mode, that's very annoying!
  ;; (make-local-variable 'company-backends)

  ;; company-ispell is the plugin to complete words
  (add-to-list 'company-backends 'company-ispell)

  ;; OPTIONAL, if `company-ispell-dictionary' is nil, `ispell-complete-word-dict' is used
  ;;  but I prefer hard code the dictionary path. That's more portable.
  (setq company-ispell-dictionary (file-truename "~/.emacs.d/english-words.txt")))

(add-hook 'text-mode-hook 'text-mode-hook-setup)









;; (use-package company                    ;autocompletion system
;;   :defer t
;;   :init
;;   (setq company-backends '((company-files company-keywords company-capf company-dabbrev-code company-etags company-dabbrev company-cmake ;; company-clang
;;                                           )))
;;   :config
;;   (setq company-tooltip-limit 20)                      ; bigger popup window
;;   (setq company-tooltip-align-annotations 't)          ; align annotations to the right tooltip border
;;   (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

;;   ;; provides almost instant autocompletion
;;   (setq company-idle-delay 0)
;;   ;;  ;; Search other buffers for compleition candidates
;;   (setq company-dabbrev-other-buffers t)
;;   (setq company-dabbrev-code-other-buffers t)

;;    ;; Show candidates according to importance, then case, then in-buffer frequency
;;   (setq company-transformers '(company-sort-by-backend-importance
;;                                company-sort-prefer-same-case-prefix
;;                                company-sort-by-occurrence))
;;   ;;  ;; Even if I write something with the ‘wrong’ case,
;;   ;;  ;; provide the ‘correct’ casing.
;;   (setq company-dabbrev-ignore-case nil)
;;   ;; :custom
;;   (setq company-minimum-prefix-length 0)
;;   )

;; ;; With use-package:
;; (use-package company-box
;;   :defer t
;;   :hook (company-mode . company-box-mode))


;; (use-package company-quickhelp
;;   :defer t
;;   :init
;;   (company-quickhelp-mode 1)
;;   )

;; (use-package company-tabnine
;;   :defer t
;;   :config

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




;; (use-package company-tabnine
;;   :defer 1
;;   :custom
;;   (company-tabnine-max-num-results 9)
;;   :bind
;;   (("M-q" . company-other-backend)
;;    ("C-z t" . company-tabnine))
;;   :hook
;;   (lsp-after-open . (lambda ()
;;                       (setq company-tabnine-max-num-results 3)
;;                       (add-to-list 'company-transformers 'company//sort-by-tabnine t)
;;                       (add-to-list 'company-backends '(company-capf :with company-tabnine :separate))))
;;   (kill-emacs . company-tabnine-kill-process)
;;   :config
;;   ;; Enable TabNine on default
;;   (add-to-list 'company-backends #'company-tabnine)

;;   ;; Integrate company-tabnine with lsp-mode
;;   (defun company//sort-by-tabnine (candidates)
;;     (if (or (functionp company-backend)
;;             (not (and (listp company-backend) (memq 'company-tabnine company-backends))))
;;         candidates
;;       (let ((candidates-table (make-hash-table :test #'equal))
;;             candidates-lsp
;;             candidates-tabnine)
;;         (dolist (candidate candidates)
;;           (if (eq (get-text-property 0 'company-backend candidate)
;;                   'company-tabnine)
;;               (unless (gethash candidate candidates-table)
;;                 (push candidate candidates-tabnine))
;;             (push candidate candidates-lsp)
;;             (puthash candidate t candidates-table)))
;;         (setq candidates-lsp (nreverse candidates-lsp))
;;         (setq candidates-tabnine (nreverse candidates-tabnine))
;;         (nconc (seq-take candidates-tabnine 3)
;;                (seq-take candidates-lsp 6))))))


;; (use-package company-box
;;   :diminish
;;   :if (display-graphic-p)
;;   :defines company-box-icons-all-the-icons
;;   :hook (company-mode . company-box-mode)
;;   :custom
;;   (company-box-backends-colors nil)
;;   :config
;;   (with-no-warnings
;;     ;; Prettify icons
;;     (defun my-company-box-icons--elisp (candidate)
;;       (when (derived-mode-p 'emacs-lisp-mode)
;;         (let ((sym (intern candidate)))
;;           (cond ((fboundp sym) 'Function)
;;                 ((featurep sym) 'Module)
;;                 ((facep sym) 'Color)
;;                 ((boundp sym) 'Variable)
;;                 ((symbolp sym) 'Text)
;;                 (t . nil)))))
;;     (advice-add #'company-box-icons--elisp :override #'my-company-box-icons--elisp))

;;   (when (and (display-graphic-p)
;;              (require 'all-the-icons nil t))
;;     (declare-function all-the-icons-faicon 'all-the-icons)
;;     (declare-function all-the-icons-material 'all-the-icons)
;;     (declare-function all-the-icons-octicon 'all-the-icons)
;;     (setq company-box-icons-all-the-icons
;;           `((Unknown . ,(all-the-icons-material "find_in_page" :height 0.8 :v-adjust -0.15))
;;             (Text . ,(all-the-icons-faicon "text-width" :height 0.8 :v-adjust -0.02))
;;             (Method . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.02 :face 'all-the-icons-purple))
;;             (Function . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.02 :face 'all-the-icons-purple))
;;             (Constructor . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.02 :face 'all-the-icons-purple))
;;             (Field . ,(all-the-icons-octicon "tag" :height 0.85 :v-adjust 0 :face 'all-the-icons-lblue))
;;             (Variable . ,(all-the-icons-octicon "tag" :height 0.85 :v-adjust 0 :face 'all-the-icons-lblue))
;;             (Class . ,(all-the-icons-material "settings_input_component" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-orange))
;;             (Interface . ,(all-the-icons-material "share" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-lblue))
;;             (Module . ,(all-the-icons-material "view_module" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-lblue))
;;             (Property . ,(all-the-icons-faicon "wrench" :height 0.8 :v-adjust -0.02))
;;             (Unit . ,(all-the-icons-material "settings_system_daydream" :height 0.8 :v-adjust -0.15))
;;             (Value . ,(all-the-icons-material "format_align_right" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-lblue))
;;             (Enum . ,(all-the-icons-material "storage" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-orange))
;;             (Keyword . ,(all-the-icons-material "filter_center_focus" :height 0.8 :v-adjust -0.15))
;;             (Snippet . ,(all-the-icons-material "format_align_center" :height 0.8 :v-adjust -0.15))
;;             (Color . ,(all-the-icons-material "palette" :height 0.8 :v-adjust -0.15))
;;             (File . ,(all-the-icons-faicon "file-o" :height 0.8 :v-adjust -0.02))
;;             (Reference . ,(all-the-icons-material "collections_bookmark" :height 0.8 :v-adjust -0.15))
;;             (Folder . ,(all-the-icons-faicon "folder-open" :height 0.8 :v-adjust -0.02))
;;             (EnumMember . ,(all-the-icons-material "format_align_right" :height 0.8 :v-adjust -0.15))
;;             (Constant . ,(all-the-icons-faicon "square-o" :height 0.8 :v-adjust -0.1))
;;             (Struct . ,(all-the-icons-material "settings_input_component" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-orange))
;;             (Event . ,(all-the-icons-octicon "zap" :height 0.8 :v-adjust 0 :face 'all-the-icons-orange))
;;             (Operator . ,(all-the-icons-material "control_point" :height 0.8 :v-adjust -0.15))
;;             (TypeParameter . ,(all-the-icons-faicon "arrows" :height 0.8 :v-adjust -0.02))
;;             (Template . ,(all-the-icons-material "format_align_left" :height 0.8 :v-adjust -0.15)))
;;           company-box-icons-alist 'company-box-icons-all-the-icons)))


    ;; (use-package company-quickhelp
    ;;   :config
    ;;   (progn
    ;;     (company-quickhelp-mode 1)))

;; ;; (use-package flycheck-ycmd
;; ;;   :config
;; ;;   (progn
;; ;;     (flycheck-ycmd-setup)
;; ;;     (global-flycheck-mode)))


(general-define-key
 :keymaps 'company-active-map
 "C-j" 'company-select-next
 ;; "C-l" 'company-complete-selection
 "C-k" 'company-select-previous
 ;; "<RET>" 'company-complete-selection
 )

;; (global-set-key (kbd "C-<return>") 'company-complete)


;; (use-package company                    ;autocompletion system
;;   :defer t
;;   :init
;;   (setq company-backends '((company-files company-keywords company-capf company-dabbrev-code company-etags company-dabbrev company-cmake ;; company-clang
;;                                           )))
;;   :config
;;   (setq company-tooltip-limit 20)                      ; bigger popup window
;;   (setq company-tooltip-align-annotations 't)          ; align annotations to the right tooltip border
;;   (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

;;   ;; provides almost instant autocompletion
;;   (setq company-idle-delay 0)
;;   ;;  ;; Search other buffers for compleition candidates
;;   (setq company-dabbrev-other-buffers t)
;;   (setq company-dabbrev-code-other-buffers t)

;;    ;; Show candidates according to importance, then case, then in-buffer frequency
;;   (setq company-transformers '(company-sort-by-backend-importance
;;                                company-sort-prefer-same-case-prefix
;;                                company-sort-by-occurrence))
;;   ;;  ;; Even if I write something with the ‘wrong’ case,
;;   ;;  ;; provide the ‘correct’ casing.
;;   (setq company-dabbrev-ignore-case nil)
;;   ;; :custom
;;   (setq company-minimum-prefix-length 0)
;;   )

;; ;; With use-package:
;; (use-package company-box
;;   :defer t
;;   :hook (company-mode . company-box-mode))


;; (use-package company-quickhelp
;;   :defer t
;;   :init
;;   (company-quickhelp-mode 1)
;;   )

;; (use-package company-tabnine
;;   :defer t
;;   :config

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




(provide 'autocompletion)
