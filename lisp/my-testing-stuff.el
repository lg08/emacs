;; ;; taken from here: https://github.com/mattmahn/emacsfiles/blob/master/emacs-config.org

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (prog-mode . lsp-deferred)
  :init
  (setq lsp-prefer-capf t))

;; TODO: make the window disappear/behave normally && hide line numbers
(defun my/hide-frame-line-numbers (frame _window)
  "Hides line nunmbers from a specific frame in a winow."
  (select-frame frame)
  (display-line-numbers-mode -1))

(use-package lsp-ui
  :requires (lsp-mode)
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-ignore-duplicate t)
  ;; (add-hook 'lsp-ui-doc-frame-hook #'my/hide-frame-line-numbers)
  )

(use-package lsp-ivy
  ;; :disabled
  :requires (lsp-mode)
  :commands (lsp-ivy-workspace-symbol lsp-ivy-global-workspace-symbol))

(use-package company-lsp
  :commands company-lsp
  :config
  (push 'company-lsp company-backends)
  (setq company-lsp-async t
        company-lsp-cache-candidates 'auto
        company-lsp-enable-recompletion t))


(setq gc-cons-threshold (* 10 1024 1024)
      read-process-output-max (* 1024 1024))




(setq frame-title-format
      '("" invocation-name ": "
        (:eval
         (if buffer-file-name
             (abbreviate-file-name buffer-file-name)
           "%b"))))



;; (setq ido-separator "\n")		;tells ido mode to display vertically

(setq flx-ido-mode 1)
(setq ido-enable-flex-matching t)

(ido-mode 1)
(ido-everywhere 1)


(use-package ido-completing-read+
  :defer t
  :config

  )

(ido-ubiquitous-mode 1)
(use-package amx
  :init
  (amx-mode 1)
  :defer t
  :config

  )

(require 'icomplete)
(icomplete-mode 1)


(defun ido-my-keys ()
  (define-key ido-completion-map (kbd "C-k")   'ido-prev-match)
  (define-key ido-completion-map (kbd "C-j") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-k")   'ido-prev-match)
  (define-key ido-completion-map (kbd "C-j") 'ido-next-match)

  )


(add-hook 'ido-setup-hook 'ido-my-keys)

(setq ido-decorations (quote ("\n-> " "" "\n " "\n ..." "[" "]" "
  [No match]" " [Matched]" " [Not readable]" " [Too big]" "
  [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)


(setq tramp-default-method "ssh")

;; (customize-set-variable 'tramp-syntax 'simplified)



(defvar custom-ido-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<C-return>") 'ido-select-text)
    ;; (define-key map (kbd "<M-return>") 'ido-magic-forward-char)
    map))
(with-eval-after-load 'ido
  (define-key ido-common-completion-map (kbd "<C-return>") 'ido-select-text)
  ;; (define-key ido-common-completion-map (kbd "<M-return>") 'ido-magic-forward-char)
  )
(add-to-ordered-list 'emulation-mode-map-alists
                     `((cua-mode . ,custom-ido-map))
                     0)


(provide 'my-testing-stuff)
