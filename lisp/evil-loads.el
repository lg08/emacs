(setq evil-want-keybinding nil)

(use-package evil
  :init
  (evil-mode 1)
  :defer t
  :config

  ;; evil key-bindings
  (evil-define-key 'normal 'global (kbd "M-h") 'windmove-left)
  (evil-define-key 'normal 'global (kbd "M-l") 'windmove-right)
  (evil-define-key 'normal 'global (kbd "M-k") 'windmove-up)
  (evil-define-key 'normal 'global (kbd "M-j") 'windmove-down)
  (evil-define-key 'normal org-mode-map (kbd "C-c b r") 'my/revert-other-buffer)
  (evil-define-key 'normal 'global (kbd "u") 'undo-tree-undo)
  (evil-define-key 'normal 'global (kbd "C-r") 'avy-goto-char-2)
  (evil-define-key 'normal 'global (kbd "g b") 'ivy-switch-buffer)


(add-hook 'pdf-view-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map
              (kbd "j") 'pdf-continuous-scroll-forward)
            (define-key evil-normal-state-local-map
              (kbd "k") 'pdf-continuous-scroll-backward)
            ))


  ;; (evil-define-key 'normal 'global (kbd "C-d") 'persp-mode-map)

  (evil-define-key 'normal org-mode-map (kbd "SPC a o") 'begin/end_org)

  (evil-define-key '(normal insert) 'global (kbd "C-e") 'end-of-line)

  (defmacro define-and-bind-text-object (key start-regex end-regex)
    (let ((inner-name (make-symbol "inner-name"))
          (outer-name (make-symbol "outer-name")))
      `(progn
         (evil-define-text-object ,inner-name (count &optional beg end type)
           (evil-select-paren ,start-regex ,end-regex beg end type count nil))
         (evil-define-text-object ,outer-name (count &optional beg end type)
           (evil-select-paren ,start-regex ,end-regex beg end type count t))
         (define-key evil-inner-text-objects-map ,key (quote ,inner-name))
         (define-key evil-outer-text-objects-map ,key (quote ,outer-name)))))
  ;; between dollar signs:
  (define-and-bind-text-object "$" "\\$" "\\$")

  ;; between pipe characters:
  (define-and-bind-text-object "|" "|" "|")
  (define-and-bind-text-object "," "," ",")

  ;; from regex "b" up to regex "c", bound to k (invoke with "vik" or "vak"):
  (define-and-bind-text-object "k" "b" "c")
  (define-and-bind-text-object "c" "<!--" "-->")


  (defun new_line_no_cut ()
    (interactive)
    (end-of-line)
    (newline)
    )

  (evil-define-key '(normal) 'global (kbd "<RET>") 'new_line_no_cut)
  (evil-define-key '(normal insert) 'global (kbd "M-<RET>") 'crux-smart-open-line-above)

  )

(use-package evil-args
  ;; :defer t
  ;; :config
  :init
  ;; bind evil-args text objects
  (define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
  (define-key evil-outer-text-objects-map "a" 'evil-outer-arg)

  ;; bind evil-forward/backward-args
  (define-key evil-normal-state-map "L" 'evil-forward-arg)
  (define-key evil-normal-state-map "H" 'evil-backward-arg)
  (define-key evil-motion-state-map "L" 'evil-forward-arg)
  (define-key evil-motion-state-map "H" 'evil-backward-arg)

  ;; bind evil-jump-out-args
  (define-key evil-normal-state-map "K" 'evil-jump-out-args)
  )

(use-package evil-quickscope
  ;; :defer t
  ;; :config
  :init
  (global-evil-quickscope-always-mode 1)
  )

(use-package evil-lion
  :ensure t
  :bind (:map evil-normal-state-map
              ("g l " . evil-lion-left)
              ("g L " . evil-lion-right)
              :map evil-visual-state-map
              ("g l " . evil-lion-left)
              ("g L " . evil-lion-right)))

(use-package evil-indent-plus
  :defer t
  :config
  (evil-indent-plus-default-bindings)
  )

(use-package evil-easymotion
  :init
  (evilem-default-keybindings (kbd "C-f"))
  )

(use-package evil-numbers
  :init
  (global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
  (global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)
  )

(use-package evil-collection
  ;; :defer 1
  :config
  (evil-collection-init)
  )



(add-hook 'dired-mode-hook (lambda ()
                             (use-package evil-collection
                               ;; :defer 1
                               :config
                               (evil-collection-init)
                               )
                             ))

(add-hook 'python-mode-hook (lambda ()
                              (use-package evil-text-object-python
                                :config
                                (evil-text-object-python-add-bindings)
                                )
                              ))

(add-hook 'magit-mode-hook (lambda ()
                             (use-package evil-collection
                               ;; :defer 1
                               :config
                               (evil-collection-init)
                               )

                             ))
(use-package evil-matchit
                              :defer t
                              :config

                              )

(add-hook 'prog-mode-hook (lambda ()
                            (use-package evil-collection
                              ;; :defer 1
                              :config
                              (evil-collection-init)
                              )

                            ;; link here: https://github.com/emacs-evil/evil-surround
                            (use-package evil-surround
                              :defer t
                              :ensure t
                              :config
                              (global-evil-surround-mode 1)
                              )
                            (use-package evil-matchit
                              :defer t
                              :config

                              )
                            (use-package evil-multiedit
                              :init
                              ;; Highlights all matches of the selection in the buffer.
                              (define-key evil-visual-state-map "R" 'evil-multiedit-match-all)

                              ;; Match the word under cursor (i.e. make it an edit region). Consecutive presses will
                              ;; incrementally add the next unmatched match.
                              (define-key evil-normal-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
                              ;; Match selected region.
                              (define-key evil-visual-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
                              ;; Insert marker at point
                              (define-key evil-insert-state-map (kbd "M-d") 'evil-multiedit-toggle-marker-here)
                              ;; Same as M-d but in reverse.
                              (define-key evil-normal-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)
                              (define-key evil-visual-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)

                              ;; OPTIONAL: If you prefer to grab symbols rather than words, use
                              ;; `evil-multiedit-match-symbol-and-next` (or prev).

                              ;; Restore the last group of multiedit regions.
                              (define-key evil-visual-state-map (kbd "C-M-D") 'evil-multiedit-restore)


                              ;; ...and in visual mode, RET will disable all fields outside the selected region
                              (define-key evil-motion-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)


                              ;; Ex command that allows you to invoke evil-multiedit with a regular expression, e.g.
                              (evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)
                              :defer t
                              :config
                              ;; RET will toggle the region under the cursor
                              (define-key evil-multiedit-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

                              ;; For moving between edit regions
                              (define-key evil-multiedit-state-map (kbd "C-n") 'evil-multiedit-next)
                              (define-key evil-multiedit-state-map (kbd "C-p") 'evil-multiedit-prev)
                              (define-key evil-multiedit-insert-state-map (kbd "C-n") 'evil-multiedit-next)
                              (define-key evil-multiedit-insert-state-map (kbd "C-p") 'evil-multiedit-prev)
                              )
                            ))

;; Make movement keys work like they should (taken out, messes up undo tree rn)
;; (define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
;; (define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
;; (define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
;; (define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
;; ; Make horizontal movement cross lines
;; (setq-default evil-cross-lines t)

(provide 'evil-loads)
