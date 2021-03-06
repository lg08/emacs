    ;;; -*- lexical-binding: t -*-

;; basic settings


(setq fill-column 80)                   ;sets the default fill column

(setq lexical-binding t)              ;idk, something to do with loading lexical files faster

(setq inhibit-startup-message t)  ;disable the default startup screen

(setq ring-bell-function 'ignore)   ;don't annoy me with bells and shit

(setq save-abbrevs 'silent)        ;; save abbrevs when files are saved

(setq initial-major-mode 'fundamental-mode) ;starts in fundamental mode to load faster

;; (global-subword-mode 1)		;detects camel case and counts them as muliple words

;; (setq-default indicate-empty-lines t)   ; shows the little black lines on the side of the buffer

;; (setq indicate-empty-lines t)           ; show empty lines in the fringe

(electric-pair-mode 1)                  ;automatically inserts matching parentheses and shit

(setq use-dialog-box nil)		;don't give me gui windows

(global-display-line-numbers-mode)      ;seems to be the best line number mode in my experience
(setq-default display-line-numbers 'relative) ;shows the relative line numbers instead
(setq display-line-numbers-type 'relative)
(global-hl-line-mode 1)            ;highlights the current line
(set-face-attribute hl-line-face nil :underline t) ;underlines the current line

(global-display-fill-column-indicator-mode)

;; starts a server if there's not already one running
(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))


(display-time-mode 1)                             ; Enable time in the mode-line

(fset 'yes-or-no-p 'y-or-n-p)                     ; Replace yes/no prompts with y/n

(set-default-coding-systems 'utf-8)               ; Default to utf-8 encoding

(show-paren-mode 1)                               ; Show the parent

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

;; (setq scroll-margin 2)                  ;keeps the cursor this far away from screen edge

(setq scroll-conservatively 10000)      ; only 'jump' when moving this far off the screen

(setq scroll-step 1)                    ; keyboard scroll one line at a time

(setq mouse-wheel-progressive-speed nil) ;don't accelerate scrolling

(setq scroll-preserve-screen-position t) ; preserve line/column (nicer page up/down)

(setq scroll-error-top-bottom t)        ; Move the cursor to top/bottom even if the screen is viewing top/bottom (for page up/down)

;; Ask before killing emacs
(setq confirm-kill-emacs 'y-or-n-p)

;; Show Keystrokes in Progress Instantly
;; (setq echo-keystrokes 0.1)


;; redefines basic folders and files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-directory-alist    `(("." . ,(concat user-emacs-directory "auto-save-list/backups"))))
(setq bookmark-default-file (expand-file-name "bookmarks" gemacs-misc-dir))


(setq auto-save-list-file-prefix nil)	;keeps the auto-save-list dir from being created

					;don't ask me to confirm when killing buffers with running processes
(setq kill-buffer-query-functions
      (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

(setq isearch-wrap-function '(lambda nil)) ;disables wrapping for isearch

(setq-default indent-tabs-mode nil)	;no tabs!

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

;; (setq visual-order-cursor-movement t)

;; makes dired sort by date by default
(setq dired-listing-switches "-la")
;; (setq dired-listing-switches "-aBhl  --group-directories-first")


;; (add-hook 'before-save-hook 'delete-trailing-whitespace) ;deletes the whitespace at end of lines on save

(defun delete-trailing-whitespace-except-current-line ()
  (interactive)
  (let ((begin (line-beginning-position))
        (end (line-end-position)))
    (save-excursion
      (when (< (point-min) begin)
        (save-restriction
          (narrow-to-region (point-min) (1- begin))
          (delete-trailing-whitespace)))
      (when (> (point-max) end)
        (save-restriction
          (narrow-to-region (1+ end) (point-max))
          (delete-trailing-whitespace))))))

(add-hook 'before-save-hook 'delete-trailing-whitespace-except-current-line)

;; (set-face-attribute 'default nil :height 80)

;just turns off a warning about deprecated package
(setq byte-compile-warnings '(cl-functions))


;; Show the current function name in the header line
(which-function-mode)
(setq-default header-line-format
              '((which-func-mode ("" which-func-format " "))))
(setq mode-line-misc-info
            ;; We remove Which Function Mode from the mode line, because it's mostly
            ;; invisible here anyway.
            (assq-delete-all 'which-func-mode mode-line-misc-info))


;; show filename in header
(setq frame-title-format
      '("" invocation-name ": "
        (:eval
         (if buffer-file-name
             (abbreviate-file-name buffer-file-name)
           "%b"))))


(provide 'my-settings)
