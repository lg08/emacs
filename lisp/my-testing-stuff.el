
;; seems to work pretty well


(global-hl-line-mode 1)
(set-face-attribute hl-line-face nil :underline t)



;; (setq gc-cons-threshold most-positive-fixnum) ;basically sets the garbage collection super high

;; HACK Stop sessions from littering the user directory
;; (defadvice! doom--use-cache-dir-a (session-id)
;;   :override #'emacs-session-filename
;;   (concat doom-cache-dir "emacs-session." session-id))

;; Disable bidirectional text rendering for a modest performance boost. I've set
;; this to `nil' in the past, but the `bidi-display-reordering's docs say that
;; is an undefined state and suggest this to be just as good:
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)






;; Remove command line options that aren't relevant to our current OS; means
;; slightly less to process at startup.
;; (unless IS-MAC   (setq command-line-ns-option-alist nil))
;; (unless IS-LINUX (setq command-line-x-option-alist nil))



;; HACK `tty-run-terminal-initialization' is *tremendously* slow for some
;;      reason. Disabling it completely could have many side-effects, so we
;;      defer it until later, at which time it (somehow) runs very quickly.
;; (unless (daemonp)
;;   (advice-add #'tty-run-terminal-initialization :override #'ignore)
;;   (add-hook! 'window-setup-hook
;;     (defun doom-init-tty-h ()
;;       (advice-remove #'tty-run-terminal-initialization #'ignore)
;;       (tty-run-terminal-initialization (selected-frame) nil t))))


(progn
  ;; Make whitespace-mode with very basic background coloring for whitespaces.
  ;; http://ergoemacs.org/emacs/whitespace-mode.html
  (setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark )))

  ;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
  (setq whitespace-display-mappings
        ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
        '(
          (space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
          (newline-mark 10 [182 10]) ; LINE FEED,
          (tab-mark 9 [9655 9] [92 9]) ; tab
          )))


(setq-default indent-tabs-mode nil)

;; (winner-mode 1)


;; git shit
;; [submodule "straight/repos/nyan-mode"]
;; path = straight/repos/nyan-mode
;; url = https://github.com/TeMPOraL/nyan-mode.git
;; [submodule "straight/repos/buffer-flip.el"]
;; path = straight/repos/buffer-flip.el
;; url = https://github.com/killdash9/buffer-flip.el.git

;; from git config
;; [submodule "straight/repos/nyan-mode"]
;; url = https://github.com/TeMPOraL/nyan-mode.git
;; active = true
;; [submodule "straight/repos/buffer-flip.el"]
;; url = https://github.com/killdash9/buffer-flip.el.git
;; active = true

(defun disable-all-minor-modes ()
  (interactive)
  (mapc
   (lambda (mode-symbol)
     (when (functionp mode-symbol)
       ;; some symbols are functions which aren't normal mode functions
       (ignore-errors 
         (funcall mode-symbol -1))))
   minor-mode-list))


(setq enable-recursive-minibuffers t)

;; ;; I use alien because native is slow. I think I used to use native
;; ;; for reasons that escape me now.
;; (setq projectile-indexing-method 'alien)
;; (setq projectile-enable-caching t)

(setq line-spacing 0.5)




;; (use-package bbdb
;;   :defer t
;;   :config
;;   (bbdb-initialize 'message)
;;   (bbdb-insinuate-message)
;;   (add-hook 'message-setup-hook 'bbdb-insinuate-mail)
;;   )




(provide 'my-testing-stuff)
