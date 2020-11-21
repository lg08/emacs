
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

(setq line-spacing 0)

;; trying this out from purcell emacs
(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill))




;; (use-package bbdb
;;   :defer t
;;   :config
;;   (bbdb-initialize 'message)
;;   (bbdb-insinuate-message)
;;   (add-hook 'message-setup-hook 'bbdb-insinuate-mail)
;;   )




;;; splash-screen.el --- An alternative splash screen -*- lexical-binding: t; -*-

;; Copyright (C) 2020 Nicolas .P Rougier

;; Author: Nicolas P. Rougier <nicolas.rougier@inria.fr>
;; URL: https://github.com/rougier/emacs-splash
;; Keywords: startup
;; Version: 0.1
;; Package-Requires: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;;  An alternative splash screen:
;;
;;  +–—————————––––––––––––––––––––––––––––————————————————————+
;;  |                                                          |
;;  |                                                          |
;;  |                                                          |
;;  |                                                          |
;;  |                                                          |
;;  |                                                          |
;;  |                       www.gnu.org                        |
;;  |                  GNU Emacs version XX.Y                  |
;;  |                   a free/libre editor                    |
;;  |                                                          |
;;  |                                                          |
;;  |                                                          |
;;  |                                                          |
;;  |                                                          |
;;  |        GNU Emacs comes with ABSOLUTELY NO WARRANTY       |
;;  |     Copyright (C) 2020 Free Software Foundation, Inc.    |
;;  |                                                          |
;;  +––––––––––––––––––––––––––––––––––––––————————————————————+
;;
;; Features:
;;
;;  - No logo, no moddeline, no scrollbars
;;  - "q" or <esc> kills the splash screen
;;  - Any other key open the about-emacs buffer
;;  - With emacs-mac (Mituharu), splash screen is faded out after 3 seconds
;;
;; Note: The screen is not shown if there are opened file buffers. For
;;       example, if you start emacs with a filename on the command
;;       line, the splash is not shown.
;;
;; Usage:
;; 
;;  (require 'splash-screen)
;;
;;; Code:
(require 'cl-lib)


;; (defun splash-screen ()
;;   "Emacs splash screen"
  
;;   (interactive)
;;   (let* ((splash-buffer  (get-buffer-create "*splash*"))
;;          (recover-session (and auto-save-list-file-prefix
;;                                (file-directory-p (file-name-directory
;;                                                   auto-save-list-file-prefix))))
;;          (height         (- (window-body-height nil) 1))
;;          (width          (window-body-width nil))
;;          (padding-center (- (/ height 2) 1))
;;          (padding-bottom (- height (/ height 2) 3)))

;;     ;; If there are buffer associated with filenames,
;;     ;;  we don't show splash screen.
;;     (if (eq 0 (length (cl-loop for buf in (buffer-list)
;;                               if (buffer-file-name buf)
;;                               collect (buffer-file-name buf))))
        
;;         (with-current-buffer splash-buffer
;;           (erase-buffer)
          
;;           ;; Buffer local settings
;;           (if (one-window-p)
;;               (setq mode-line-format nil))
;;           (setq cursor-type nil)
;;           (setq vertical-scroll-bar nil)
;;           (setq horizontal-scroll-bar nil)
;;           (setq fill-column width)
;;           (face-remap-add-relative 'link :underline nil)

;;           ;; Vertical padding to center
;;           (insert-char ?\n padding-center)

;;           ;; Central text
;;           (insert-text-button " www.gnu.org "
;;                      'action (lambda (_) (browse-url "https://www.gnu.org"))
;;                      'help-echo "Visit www.gnu.org website"
;;                      'follow-link t)
;;           (center-line) (insert "\n")
;;           (insert (concat
;;                    (propertize "GNU Emacs"  'face 'bold)
;;                    " " "version "
;;                    (format "%d.%d" emacs-major-version emacs-minor-version)))
;;           (center-line) (insert "\n")
;;           (insert (propertize "A free/libre editor" 'face 'shadow))
;;           (center-line) (insert "\n") (insert "\n")
;;           (insert (propertize
;;                    "Welcome back old friend." 'face 'shadow))
;;           (center-line) (insert "\n")
;;           (insert (propertize
;;                    "Emacs is here. You're ok now." 'face 'shadow))
;;           (center-line) (insert "\n")


;;           ;; Vertical padding to bottom
;;           (insert-char ?\n padding-bottom)

;;           ;; Recover session button
;;           (when recover-session
;;             (delete-char -2)
;;             (insert-text-button " [Recover session] "
;;                  'action (lambda (_) (call-interactively 'recover-session))
;;                    'help-echo "Recover previous session"
;;                    'face 'warning
;;                    'follow-link t)
;;             (center-line) (insert "\n") (insert "\n"))

;;           ;; Copyright text
;;           (insert (propertize
;;                    "GNU Emacs comes with ABSOLUTELY NO WARRANTY" 'face 'shadow))
;;           (center-line) (insert "\n")
;;           (insert (propertize
;;                    "Copyright (C) 2020 Free Software Foundation, Inc." 'face 'shadow))
;;           (center-line) (insert "\n")


;;           (goto-char 0)
;;           (read-only-mode t)
          
;;           (local-set-key [t]               'splash-screen-fade-to-about)
;;           (local-set-key (kbd "C-[")       'splash-screen-fade-to-default)
;;           (local-set-key (kbd "<escape>")  'splash-screen-fade-to-default)
;;           (local-set-key (kbd "q")         'splash-screen-fade-to-default)
;;           (local-set-key (kbd "<mouse-1>") 'mouse-set-point)
;;           (local-set-key (kbd "<mouse-2>") 'operate-this-button)
;;           ;; (local-set-key " "               'splash-screen-fade-to-default)
;;           ;; (local-set-key "x"               'splash-screen-fade-to-default)
;;           ;; (local-set-key (kbd "<RET>")     'splash-screen-fade-to-default)
;;           ;; (local-set-key (kbd "<return>")  'splash-screen-fade-to-default)
;;           (display-buffer-same-window splash-buffer nil)
;;           ;; (run-with-idle-timer 10.0 nil    'splash-screen-fade-to-about)
;;           ))))


;; Mac animation, only available from
;;  https://bitbucket.org/mituharu/emacs-mac/src/master/
;;  https://github.com/railwaycat/homebrew-emacsmacport
(defvar mac-animation-locked-p nil)
(defun mac-animation-toggle-lock ()
  (setq mac-animation-locked-p (not mac-animation-locked-p)))
(defun mac-animation-fade-out (duration &rest args)
  (unless mac-animation-locked-p
    (mac-animation-toggle-lock)
    (mac-start-animation nil :type 'fade-out :duration duration)
    (run-with-timer duration nil 'mac-animation-toggle-lock)))

(defun splash-screen-fade-to (about duration)
  "Fade out current frame for duration and goes to command-or-bufffer"
  (interactive)
  (defalias 'mac-animation-fade-out-local
    (apply-partially 'mac-animation-fade-out duration))
  (if (get-buffer "*splash*")
      (progn (if (and (display-graphic-p) (fboundp 'mac-start-animation))
                 (advice-add 'set-window-buffer
                             :before 'mac-animation-fade-out-local))
             (if about (about-emacs))
             (kill-buffer "*splash*")
             (if (and (display-graphic-p) (fboundp 'mac-start-animation))
                 (advice-remove 'set-window-buffer
                                'mac-animation-fade-out-local)))))
(defun splash-screen-fade-to-about ()
  (interactive) (splash-screen-fade-to 1 1.0))
(defun splash-screen-fade-to-default ()
  (interactive) (splash-screen-fade-to nil 0.25))

(defun splash-screen-kill ()
  "Kill the splash screen buffer (immediately)."
  (interactive)
  (if (get-buffer "*splash*")
        (kill-buffer "*splash*")))

;; Suppress any startup message in the echo area
(run-with-idle-timer 0.05 nil (lambda() (message nil)))

;; Install hook after frame parameters have been applied and only if
;; no option on the command line
(if (and (not (member "-no-splash"  command-line-args))
         (not (member "--file"      command-line-args))
         (not (member "--insert"    command-line-args))
         (not (member "--find-file" command-line-args))
         (not inhibit-startup-screen)
         )
    (progn
      (add-hook 'window-setup-hook 'splash-screen)
      (setq inhibit-startup-screen t 
            inhibit-startup-message t
            inhibit-startup-echo-area-message t)))

;;; splash-screen.el ends here



;; (splash-screen)


(defun insert-comment-with-description (comment-syntax comment)
  "Inserts a comment with '―' (Unicode character: U+2015) on each side."
  (let* ((comment-length (length comment))
         (current-column-pos (current-column))
         (space-on-each-side (/ (- fill-column
                                   current-column-pos
                                   comment-length
                                   (length comment-syntax)
                                    ;; Single space on each side of comment
                                   (if (> comment-length 0) 2 0)
                                   ;; Single space after comment syntax sting
                                   1)
                                2)))
    (if (< space-on-each-side 2)
        (message "Comment string is too big to fit in one line")
      (progn
        (insert comment-syntax)
        (insert " ")
        (dotimes (_ space-on-each-side) (insert "―"))
        (when (> comment-length 0) (insert " "))
        (insert comment)
        (when (> comment-length 0) (insert " "))
        (dotimes (_ (if (= (% comment-length 2) 0)
                      space-on-each-side
                      (- space-on-each-side 1)))
          (insert "―"))))))

;; For Clojure
(defun clj-insert-comment-with-description ()
  "Inserts a pretty Clojure comment."
  (interactive)
  (insert-comment-with-description ";;" (read-from-minibuffer "Comment: ")))

;; For C
(defun c-insert-comment-with-description ()
  "Inserts a pretty C comment."
  (interactive)
  (insert-comment-with-description "//" (read-from-minibuffer "Comment: ")))


(defun aj-toggle-fold ()
  "Toggle fold all lines larger than indentation on current line"
  (interactive)
  (let ((col 1))
    (save-excursion
      (back-to-indentation)
      (setq col (+ 1 (current-column)))
      (set-selective-display
       (if selective-display nil (or col 1))))))
(global-set-key [(M C i)] 'aj-toggle-fold)


(provide 'my-testing-stuff)
