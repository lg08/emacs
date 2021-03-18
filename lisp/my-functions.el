;; loads all custom functions

(defun my/export-cover-letter ()
"trying to export my cover letter automatically"
(interactive)
(shell-command "xelatex ~/Documents/resume/Lucas_Gen_Cover_Letter.tex")
(shell-command "evince ~/Documents/resume/Lucas_Gen_Cover_Letter.pdf")
(delete-other-windows)
)


;; sets gargage collection very high while in minibuffer
(add-hook 'minibuffer-setup-hook #'my/minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my/minibuffer-exit-hook)
(defun my/minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my/minibuffer-exit-hook ()
  (setq gc-cons-threshold 800000))

(defun my/where-am-i ()
  "An interactive function showing function `buffer-file-name' or `buffer-name'."
  (interactive)
  (message (kill-new (if (buffer-file-name) (buffer-file-name) (buffer-name)))))

(defun my/reload-emacs-configuration()
  "Reload the configuration"
  (interactive)
  (load "~/.emacs.d/init.el"))

(defun my/dired-up-directory-same-buffer ()
  "Go up in the same buffer, used in dired mode."
  (interactive)
  (find-alternate-file ".."))

(defun my/byte-compile-init-dir ()
  "Byte-compile all your dotfiles."
  (interactive)
  (byte-recompile-directory user-emacs-directory 0))

;; deletes stale elc files on save
(add-hook 'emacs-lisp-mode-hook 'my/remove-elc-on-save)
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


(defun my/edit-armlab-file ()
  "opens a file on the armlab cluster at princeton for editing"
  (interactive)
  (find-file "/ssh:lgen@armlab.cs.princeton.edu:")
  )

;; opens the urrent buffer in the file explorer
(defun my/open-buffer-path-in-explorer ()
  "Run explorer on the directory of the current buffer."
  (interactive)
  (shell-command (concat
                  "xdg-open "
                  default-directory)))

;; gotten from here: https://www.reddit.com/r/emacs/comments/bed0ne/dry0_quickly_popup_a_terminal_run_a_command_close/
(defun my/ansi-term-toggle ()
  "Toggle ansi-term window on and off with the same command."
  (interactive)
  (defvar my--ansi-term-name "ansi-term-popup")
  (defvar my--window-name (concat "*" my--ansi-term-name "*"))
  (cond ((get-buffer-window my--window-name)
         (ignore-errors (delete-window
                         (get-buffer-window my--window-name))))
        (t (split-window-below)
           (other-window 1)
           (cond ((get-buffer my--window-name)
                  (switch-to-buffer my--window-name))
                 (t (ansi-term "bash" my--ansi-term-name))))))



;; opens a terminal in the working directory or the projects root if one is detected
(defun my/open-terminal-in-workdir ()
  (interactive)
  (let ((workdir
         default-directory))
    (call-process-shell-command
     (concat "gnome-terminal –working-directory=" workdir) nil 0)))


(defun crux-smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at its beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (insert "\n")
  (if electric-indent-inhibit
      ;; We can't use `indent-according-to-mode' in languages like Python,
      ;; as there are multiple possible indentations with different meanings.
      (let* ((indent-end (progn (crux-move-to-mode-line-start) (point)))
             (indent-start (progn (move-beginning-of-line nil) (point)))
             (indent-chars (buffer-substring indent-start indent-end)))
        (forward-line -1)
        ;; This new line should be indented with the same characters as
        ;; the current line.
        (insert indent-chars))
    ;; Just use the current major-mode's indent facility.
    (forward-line -1)
    (indent-according-to-mode)))


(defun crux-transpose-windows (arg)
  "Transpose the buffers shown in two windows.
Prefix ARG determines if the current windows buffer is swapped
with the next or previous window, and the number of
transpositions to execute in sequence."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (cl-plusp arg) (1- arg) (1+ arg))))))


;; Source: http://www.emacswiki.org/emacs-en/download/misc-cmds.el
(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer :ignore-auto :noconfirm))


(defun aj-toggle-fold ()
  "Toggle fold all lines larger than indentation on current line"
  (interactive)
  (let ((col 1))
    (save-excursion
      (back-to-indentation)

      (setq col (+ 1 (current-column)))
      (set-selective-display
       (if selective-display nil (or col 1)))
      )))


;; taken from here: https://emacsredux.com/blog/2013/04/28/switch-to-previous-buffer/
(defun er-switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun my/revert-other-buffer ()
  (interactive)
  (other-window 1)
  (revert-buffer-no-confirm)
  (other-window 1)
  )

;; from here: https://emacsredux.com/blog/2013/04/21/edit-files-as-root
(defun er-sudo-edit (&optional arg)
  "Edit currently visited file as root.

With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current
buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun tri-view ()
  "splits the view into three"
  (interactive)
  (delete-other-windows)
  (split-window-right)
  (other-window 1)
  (split-window-below)
  (other-window 2)
  (toggle-dired-sidebar-and-truncate-lines)
  (other-window 1)
  )

(defun triple-pane ()
  "three vertical panes"
  (interactive)
 (delete-other-windows)
  (split-window-right)
  (split-window-right)
  (balance-windows)
  )

(defun my/overview ()
 "show an overview of the file"
 (interactive)

 (text-scale-decrease 4)
 (font-lock-mode -1)
  )

(defun my/exit-overview ()
 "exit overview of file"
 (interactive)

 (text-scale-increase 4)
 (font-lock-mode 1)
  )

;; settings
(provide 'my-functions)
