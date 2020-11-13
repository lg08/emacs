;; basic settings
(display-time-mode 1)                             ; Enable time in the mode-line
(fset 'yes-or-no-p 'y-or-n-p)                     ; Replace yes/no prompts with y/n
;; (global-hl-line-mode)                             ; Hightlight current line
(set-default-coding-systems 'utf-8)               ; Default to utf-8 encoding
(show-paren-mode 1)                               ; Show the parent
(setq lexical-binding t)              ;idk, something to do with loading lexical files faster
(setq inhibit-startup-message t)  ;don't show me that ugly ass startup ad
(setq ring-bell-function 'ignore)   ;don't annoy me with bells and shit
(setq visible-bell t)
;; (electric-pair-mode 1)		;pairs parenthesis automatically
(setq save-abbrevs 'silent)        ;; save abbrevs when files are saved
(setq initial-major-mode 'fundamental-mode) ;starts in fundamental mode to load faster
(global-subword-mode 1)		;detects camel case and counts them as muliple words
;; (delete-selection-mode 1)		;after pasting or whatever you can just delete the selction by typing
(setq select-enable-clipboard t)            ; use the clipboard in addition to kill-ring
(global-so-long-mode)                   ;disables the major mode for files that have lines that are too long
;; (global-visual-line-mode)               ;makes the lines look a little better
;; (global-whitespace-mode 1)              ;shows all the whitespace stuff
(setq global-auto-revert-mode t)             ;automatically reload file when changed outside
(setq global-auto-revert-non-file-buffers t) ;reverts dired too
(setq dired-recursive-deletes 'always)  ;doesn't ask you whether to delete recursively
(setq delete-by-moving-to-trash t)      ;delete files by moving to the trash
(setq delete-old-versions t)

;; scrolling stuff
(setq auto-window-vscroll nil)          ;supposed to help with scrolling a bit
;; More performant rapid scrolling over unfontified regions. May cause brief
;; spells of inaccurate syntax highlighting right after scrolling, which should
;; quickly self-correct.
(setq fast-but-imprecise-scrolling t)
;; make return key also do indent, globally
(electric-indent-mode 1)
;; shows the little black lines on the side of the buffer
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))


(electric-pair-mode 1)
(global-display-line-numbers-mode)


(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))

(add-to-list 'default-frame-alist '(cursor-color . "green"))




(setq
 ;; scroll N lines to screen edge
 scroll-margin 2

 ;; only 'jump' when moving this far off the screen
 scroll-conservatively 10000

 ;; ensure when we move outside the screen we always recenter
 ;; (less hassle than attempting to make all jumping commands call recenter)
 ;; scroll-conservatively scroll-margin

 ;; keyboard scroll one line at a time
 scroll-step 1
 ;; mouse scroll N lines
 mouse-wheel-scroll-amount '(6 ((shift) . 1))
 ;; don't accelerate scrolling
 mouse-wheel-progressive-speed nil

 ;; preserve line/column (nicer page up/down)
 scroll-preserve-screen-position t
 ;; Move the cursor to top/bottom even if the screen is viewing top/bottom (for page up/down)
 scroll-error-top-bottom t

 ;; center after going to the next error
 next-error-recenter (quote (4))

 ;; Always redraw immediately when scrolling,
 ;; more responsive and doesn't hang!
 ;; http://emacs.stackexchange.com/a/31427/2418
 fast-but-imprecise-scrolling nil
 jit-lock-defer-time 0
 )




;; redefines basic folders and files
(setq make-backup-files nil)
(setq backup-directory-alist    `(("." . ,(concat user-emacs-directory "auto-save-list/backups"))))
(setq make-backup-files nil)

(global-visual-line-mode t)

;; startup message 
(setq startup-message
      (format "Welcome back old friend. Emacs ready in %.2f seconds with %d garbage collections."
              (float-time (time-subtract after-init-time before-init-time)) gcs-done))
(defun display-startup-echo-area-message ()
  (display-message-or-buffer startup-message))

;; sets up frame title and initial scratch messsage
(setq frame-title-format '("" "%b - My-Dope-Ass Config"))
;; (setq-default initial-scratch-message (concat ";; Welcome back, " user-login-name " - Emacs ♥ you!\n\n"))
(setq initial-scratch-message "Welcome back old friend... \n\nEmacs is here. You're ok now.\n\n\n")

;; deletes stale elc files on save
(add-hook 'emacs-lisp-mode-hook 'my/remove-elc-on-save)
(add-hook 'before-save-hook 'whitespace-cleanup)
;; sets gargage collection very high while in minibuffer
(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)

;; just shows when emacs is gargage collecting, just useful while figuring out slowdowns
;; (setq garbage-collection-messages t)

;; doc here: https://www.gnu.org/software/emacs/manual/html_node/emacs/Bidirectional-Editing.html
;; supposed to help with display rendering as seen from my reddit post about it
(setq bidi-paragraph-direction 'left-to-right
      bidi-inhibit-bpa t)
(setq visual-order-cursor-movement t)


(provide 'my-settings)
