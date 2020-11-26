;; basic settings

(display-time-mode 1)                             ; Enable time in the mode-line

(fset 'yes-or-no-p 'y-or-n-p)                     ; Replace yes/no prompts with y/n

(set-default-coding-systems 'utf-8)               ; Default to utf-8 encoding

(show-paren-mode 1)                               ; Show the parent

(setq lexical-binding t)              ;idk, something to do with loading lexical files faster

;; (setq inhibit-startup-message t)  ;i kinda like it but most people don't

(setq ring-bell-function 'ignore)   ;don't annoy me with bells and shit

(setq save-abbrevs 'silent)        ;; save abbrevs when files are saved

(setq initial-major-mode 'fundamental-mode) ;starts in fundamental mode to load faster

(global-subword-mode 1)		;detects camel case and counts them as muliple words

(setq select-enable-clipboard t)            ; use the clipboard in addition to kill-ring

(global-so-long-mode)                   ;disables the major mode for files that have lines that are too long
(global-visual-line-mode)               ;makes the lines look a little better

(setq global-auto-revert-mode t)             ;automatically reload file when changed outside

(setq global-auto-revert-non-file-buffers t) ;reverts dired too

(setq dired-recursive-deletes 'always)  ;doesn't ask you whether to delete recursively

(setq delete-by-moving-to-trash t)      ;delete files by moving to the trash

(setq delete-old-versions t)

(setq auto-window-vscroll nil)          ;supposed to help with scrolling a bit

(setq fast-but-imprecise-scrolling t)   ;supposed to help with scrolling a bit, may cause brief periods of messed up colors, but will be fixed quickly

(setq electric-indent-mode 1)                ;make return key also do indent, globally

(setq-default indicate-empty-lines t)   ; shows the little black lines on the side of the buffer

(setq indicate-empty-lines t)           ; show empty lines in the fringe

(electric-pair-mode 1)                  ;automatically inserts matching parentheses and shit

(global-display-line-numbers-mode)      ;seems to be the best line number mode in my experience

(global-hl-line-mode 1)            ;highlights the current line
(set-face-attribute hl-line-face nil :underline t) ;underlines the current line

;; starts a server if there's not already one running
(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))

(setq scroll-margin 2)                  ;keeps the cursor this far away from screen edge

(setq scroll-conservatively 10000)      ; only 'jump' when moving this far off the screen

(setq scroll-step 1)                    ; keyboard scroll one line at a time

(setq mouse-wheel-progressive-speed nil) ;don't accelerate scrolling

(setq scroll-preserve-screen-position t) ; preserve line/column (nicer page up/down)

(setq scroll-error-top-bottom t)        ; Move the cursor to top/bottom even if the screen is viewing top/bottom (for page up/down)





;; deletes stale elc files on save
(add-hook 'emacs-lisp-mode-hook 'my/remove-elc-on-save)

;; sets gargage collection very high while in minibuffer
(add-hook 'minibuffer-setup-hook #'my/minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my/minibuffer-exit-hook)

;; just shows when emacs is gargage collecting, just useful while figuring out slowdowns
;; (setq garbage-collection-messages t)

;; doc here: https://www.gnu.org/software/emacs/manual/html_node/emacs/Bidirectional-Editing.html
;; supposed to help with display rendering as seen from my reddit post about it
(setq bidi-paragraph-direction 'left-to-right
      bidi-inhibit-bpa t)
;; Disable bidirectional text rendering for a modest performance boost. I've set
;; this to `nil' in the past, but the `bidi-display-reordering's docs say that
;; is an undefined state and suggest this to be just as good:
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)

(setq visual-order-cursor-movement t)

;; makes dired sort by date by default
(setq dired-listing-switches "-alt")

(display-splash-screen)                 ;just shows the splash screen

(add-hook 'org-mode-hook
          (lambda () (add-hook 'after-save-hook #'org-babel-tangle
                               :append :local)))

(add-hook 'before-save-hook 'delete-trailing-whitespace) ;deletes the whitespace at end of lines on save

(provide 'my-settings)
