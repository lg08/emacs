;; helm -------------------------------------------------------

(use-package helm
  :config
  (helm-adaptive-mode 1)
  (helm-mode)
  )

(use-package helm-spotify-plus
  ;; :defer t
  :config

  )

;; lets you browse system packages with helm
(use-package helm-system-packages
  :defer t
  :config

  )

(use-package helm-swoop
  :defer t
  :config

  )

(use-package helm-descbinds
  :defer t
  :config

  )

;; ivy -------------------------------------------------------


;; (use-package ivy
;;   :init
;;   ;; (ivy-mode)
;;   :defer t
;;   :config
;;   (setq ivy-use-virtual-buffers t       ;    Add recent files and bookmarks to the ivy-switch-buffer
;;         ivy-count-format "%d/%d ")      ;    Displays the current and total number in the collection in the prompt

;;   (add-to-list                          ;should make find-file and stuff sort by date
;;    'ivy-sort-matches-functions-alist
;;    '(read-file-name-internal . ivy--sort-files-by-date))

;;   (setq ivy-extra-directories nil)
;;   (setq ivy-height 25)
;;   (setq ivy-count-format "【%d/%d】")
;;   )

;; (use-package ivy-rich
;;   :defer 1
;;   :config
;;   ;; (ivy-rich-mode 1)
;;   ;; (ivy-rich-project-root-cache-mode 1)  ;better performance especially for switch to buffer
;;   )

;; (use-package counsel
;;   :defer t
;;   :config

;;   )

;; (use-package prescient                  ;much better sorting for ivy
;;   :defer 1
;;   :init
;;   (setq prescient-save-file (expand-file-name "prescient-save.el" gemacs-misc-dir))
;;   :ensure t
;;   :config
;;   ;; (prescient-persist-mode +1)

;;   )

;; (use-package ivy-prescient              ;integrates prescient with ivy
;;   :init
;;   ;; (ivy-prescient-mode)
;;   :defer t
;;   :config

;;   )

;; ;makes the minibuffer resize for ubuntu users
;; (setq x-gtk-resize-child-frames 'resize-mode)
;; ;moves the modeline up to the top
;; (use-package mini-frame
;;   :init
;;   ;; (mini-frame-mode)
;;   :defer t
;;   :config
;;   (add-to-list 'mini-frame-ignore-commands 'swiper)
;;   ;; dimensions of the box
;;   (custom-set-variables
;;    '(mini-frame-show-parameters
;;      '((top . 0)
;;        (width . 0.7)
;;        (left . 0.5)
;;        (height . 15))))
;;   )

;; (use-package swiper
;;   :init
;;   (define-key ivy-minibuffer-map "\C-k" 'nil)
;;   :defer t
;;   :config
  ;; )

(provide 'ivy-helm)
