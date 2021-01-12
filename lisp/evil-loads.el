(setq evil-want-keybinding nil)

(use-package evil
  :init
  (evil-mode 1)
  :defer t
  :config

  ;; evil key-bindings
  (evil-define-key 'normal 'global (kbd "q") 'end-of-line)
  (evil-define-key 'normal 'global (kbd "M-h") 'windmove-left)
  (evil-define-key 'normal 'global (kbd "M-l") 'windmove-right)
  (evil-define-key 'normal 'global (kbd "M-k") 'windmove-up)
  (evil-define-key 'normal 'global (kbd "M-j") 'windmove-down)
  (evil-define-key 'normal org-mode-map (kbd "C-c b r") 'my/revert-other-buffer)
  (evil-define-key 'normal 'global (kbd "u") 'undo-tree-undo)
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


(provide 'evil-loads)