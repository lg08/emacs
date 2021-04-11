

;;; jsled, 2001.12.10 -- *grrr* This pisses me off...
(defun save-buffers-kill-emacs-with-confirm ()
 "jsled's special save-buffers-kill-emacs, but with confirm"
 (interactive)
 (if (null current-prefix-arg)
     (if (y-or-n-p "Aww, you're leaving so soon????")
         (save-buffers-kill-emacs))
     (save-buffers-kill-emacs)))
(global-set-key "\C-x\C-c" 'save-buffers-kill-emacs-with-confirm)

;; latex loads-------------------------------------------------------------


;; (use-package auctex-latexmk
;;   :ensure t
;;   :config
;;   (auctex-latexmk-setup)
;;   (setq auctex-latexmk-inherit-TeX-PDF-mode t))

;; (use-package reftex
;;   :ensure t
;;   :defer t
;;   :config
;;   (setq reftex-cite-prompt-optional-args t)) ;; Prompt for empty optional arguments in cite

;; (use-package auto-dictionary
;;   :ensure t
;;   :init(add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1))))

;; (use-package company-auctex
;;   :ensure t
;;   :init (company-auctex-init))

(use-package base16-theme
  :defer t
  :config

  )


(provide 'my-testing-stuff)
