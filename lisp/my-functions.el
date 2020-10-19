;; loads all custom functions

(defun my/select-current-line-and-forward-line (arg)
  "Select the current line and move the cursor by ARG lines IF
no region is selected.
If a region is already selected when calling this command, only move
the cursor by ARG lines."
  (interactive "p")
  (when (not (use-region-p))
    (forward-line 0)
    (set-mark-command nil))
  (forward-line arg))

(defun my/modalka-normal-mode ()
  "turns on modalka normal mode and change modeline color"
  (interactive)
  (setq modalka-mode 1)
  ;; (set-face-background 'mode-line "#333")
  (setq cursor-type 'box)

  )

;; (defun my/match-paren (arg)
;;   "Go to the matching paren if on a paren; otherwise insert %."
;;   (interactive "p")
;;   (cond ((looking-at "\\s(") (forward-list 1) (backward-char 1))
;;         ((looking-at "\\s)") (forward-char 1) (backward-list 1))
;;         (t (self-insert-command (or arg 1)))))

(defun my/where-am-i ()
  "An interactive function showing function `buffer-file-name' or `buffer-name'."
  (interactive)
  (message (kill-new (if (buffer-file-name) (buffer-file-name) (buffer-name)))))

(defun my/reload-emacs-configuration()
  "Reload the configuration"
  (interactive)
  (load "~/.emacs.d/init.el"))

(defun my/dired-up-directory-same-buffer ()
  "Go up in the same buffer."
  (interactive)
  (find-alternate-file ".."))

(defun my/byte-compile-init-dir ()
  "Byte-compile all your dotfiles."
  (interactive)
  (byte-recompile-directory user-emacs-directory 0))

(defun my/remove-elc-on-save ()
  "If you're saving an Emacs Lisp file, likely the .elc is no longer valid."
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))
            nil
            t))

(defun toggle-window-split ()
  "with windows split horizontally, it makes the vertical and vice versa"
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))


;; Toggle window dedication
(defun toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not"
  (interactive)
  (message
   (if (let ((window (get-buffer-window (current-buffer))))
	 (set-window-dedicated-p window
				 (not (window-dedicated-p window))))
       "Window '%s' is dedicated"
     "Window '%s' is normal")
   (current-buffer)))

(defun xah-cut-line-or-region ()
  "Cut current line, or text selection.
When `universal-argument' is called first, cut whole buffer (respects `narrow-to-region').

URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
Version 2015-06-10"
  (interactive)
  (if current-prefix-arg
      (progn ; not using kill-region because we don't want to include previous kill
        (kill-new (buffer-string))
        (delete-region (point-min) (point-max)))
    (progn (if (use-region-p)
               (kill-region (region-beginning) (region-end) t)
             (kill-region (line-beginning-position) (line-beginning-position 2))))))


(defun xah-copy-line-or-region ()
  "Copy current line, or text selection.
When called repeatedly, append copy subsequent lines.
When `universal-argument' is called first, copy whole buffer (respects `narrow-to-region').

URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
Version 2018-09-10"
  (interactive)
  (if current-prefix-arg
      (progn
        (copy-region-as-kill (point-min) (point-max)))
    (if (use-region-p)
        (progn
          (copy-region-as-kill (region-beginning) (region-end)))
      (if (eq last-command this-command)
          (if (eobp)
              (progn )
            (progn
              (kill-append "\n" nil)
              (kill-append
               (buffer-substring-no-properties (line-beginning-position) (line-end-position))
               nil)
              (progn
                (end-of-line)
                (forward-char))))
        (if (eobp)
            (if (eq (char-before) 10 )
                (progn )
              (progn
                (copy-region-as-kill (line-beginning-position) (line-end-position))
                (end-of-line)))
          (progn
            (copy-region-as-kill (line-beginning-position) (line-end-position))
            (end-of-line)
            (forward-char)))))))


(defun xah-toggle-letter-case ()
  "Toggle the letter case of current word or text selection.
Always cycle in this order: Init Caps, ALL CAPS, all lower.
URL `http://ergoemacs.org/emacs/modernization_upcase-word.html'
Version 2020-06-26"
  (interactive)
  (let (
        (deactivate-mark nil)
        $p1 $p2)
    (if (use-region-p)
        (setq $p1 (region-beginning) $p2 (region-end))
      (save-excursion
        (skip-chars-backward "[:alpha:]")
        (setq $p1 (point))
        (skip-chars-forward "[:alpha:]")
        (setq $p2 (point))))
    (when (not (eq last-command this-command))
      (put this-command 'state 0))
    (cond
     ((equal 0 (get this-command 'state))
      (upcase-initials-region $p1 $p2)
      (put this-command 'state 1))
     ((equal 1 (get this-command 'state))
      (upcase-region $p1 $p2)
      (put this-command 'state 2))
     ((equal 2 (get this-command 'state))
      (downcase-region $p1 $p2)
      (put this-command 'state 0)))))

(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 800000))


(defun my/double-pane-dired ()
  "opens up dired in two buffers"
  (interactive)
  (require 'dired-x)
  (delete-other-windows)
  (dired-jump)
  (switch-window-then-split-horizontally 1)
  (dired-other-window "~/")
  (other-window 1)
  )

(defun my/edit-armlab-file ()
  "opens a file on the armlab cluster at princeton for editing"
  (interactive)
  (find-file "/ssh:lgen@armlab.cs.princeton.edu:")
  )

;; kills all buffers
(defun close-all-buffers ()
(interactive)
  (mapc 'kill-buffer (buffer-list)))

(provide 'my-functions)
