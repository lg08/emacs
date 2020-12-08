;; GLOBAL KEYS-----------------------------------------------------------------

;; just necessary for our scroll-down function
(autoload 'View-scroll-half-page-forward "view") (autoload 'View-scroll-half-page-backward "view")


(defun my/u-key-diff-modes-function ()
  "trying this out"
  (interactive)
  (if (eq major-mode 'dired-mode)
      (dired-unmark 1)
    (undo-tree-undo)
    )
  )


(defun my/w-key-diff-modes-function ()
  "trying this out"
  (interactive)
  (if (eq major-mode 'dired-mode)
      (browse-url-of-dired-file)
    (xah-cut-line-or-region)
    )
  )


(general-define-key
 "M-y" 'counsel-yank-pop
 "M-x" 'execute-extended-command
 "C-s" 'swiper-isearch
 "C-z" 'nil
 "C-h" 'backward-char
 "C-l" 'forward-char
 "C-j" 'next-line
 "C-k" 'previous-line
 "M-h" 'backward-word
 "M-l" 'forward-word
 "C-b" 'kill-whole-line
 "M-k" 'View-scroll-half-page-forward
 "M-j" 'View-scroll-half-page-backward
 "M-w" 'xah-copy-line-or-region
 "C-o" 'crux-smart-open-line-above
 "C-a" 'move-beginning-of-line
 "C-x 4 t" 'crux-transpose-windows
 "C-x o" 'switch-window
 "C-x 1" 'switch-window-then-maximize
 "C-x 2" 'switch-window-then-split-below
 "C-x 3" 'switch-window-then-split-right
 "C-x 0" 'switch-window-then-delete
 "C-x 4 d" 'switch-window-then-dired
 "C-x 4 f" 'switch-window-then-find-file
 "C-x 4 C-f" 'switch-window-then-find-file
 "M-<right>" 'eyebrowse-next-window-config
 "M-<left>" 'eyebrowse-prev-window-config
 "M-1" 'eyebrowse-switch-to-window-config-1
 "M-2" 'eyebrowse-switch-to-window-config-2
 "M-3" 'eyebrowse-switch-to-window-config-3
 "M-4" 'eyebrowse-switch-to-window-config-4
 "M-5" 'eyebrowse-switch-to-window-config-5
 "M-6" 'eyebrowse-switch-to-window-config-6
 "S-<left>"  'windmove-left
 "S-<right>"  'windmove-right
 "S-<up>"  'windmove-up
 "S-<down>"  'windmove-down
 "C-s-c C-s-c" 'mc/edit-lines
 "C->" 'mc/mark-next-like-this
 "C-<" 'mc/mark-previous-like-this
 "C-c C->" 'mc/mark-all-like-this
 "C--" 'er/contract-region
 "C-;"  'goto-last-change
 ;; "M-u" 'xah-toggle-letter-case
 "M-u" 'fix-word-upcase
 "M-c" 'fix-word-capitalize
 "C-r" 'avy-goto-char
 ;; "C-." 'company-complete
 "C-z" 'my/modalka-normal-mode
 "<f9>" 'my/modalka-normal-mode
 "C-c _" 'undo-tree-visualize
 "C-c c r" 'my/reload-emacs-configuration
 "C-x C-d" 'my/double-pane-dired
 "C-x d" 'dired
 "<f8>" 'dired-sidebar-toggle-sidebar
 "C-M-w" 'avy-kill-region
 "C-<backspace>" 'smart-hungry-delete-backward-char
 "C-M-a" 'sp-beginning-of-sexp
 "C-M-e" 'sp-end-of-sexp
 "C-M-l" 'forward-list
 "C-M-h" 'backward-list
 "C-M-k" 'backward-up-list
 "C-M-j" 'down-list
 "C-c k" 'highlight-symbol-prev
 "C-c j" 'highlight-symbol-next
 "<f5>" 'revert-buffer-no-confirm
 )

;; MINOR MODE MAPS---------------------------------------------------------------------


(general-define-key
 :keymaps 'projectile-mode-map
 "s-p" 'projectile-command-map
 "C-c p" 'projectile-command-map
 )

(general-define-key
 :keymaps 'helm-map
 "C-j" 'helm-next-line
 "C-k" 'helm-previous-line
 ;; "<tab>" 'helm-execute-persistent-action
 "C-z" 'helm-select-action
 )

(general-define-key
 :keymaps 'ivy-minibuffer-map
 "C-j" 'ivy-next-line
 "C-k" 'ivy-previous-line
 )

(general-define-key
 :keymaps 'helm-find-files-map
 "C-h" 'helm-find-files-up-one-level
 )

(general-define-key
 :keymaps 'company-active-map
 "C-j" 'company-select-next
 "C-l" 'nil
 "C-k" 'company-select-previous
 )

(general-define-key
 :keymaps 'dired-mode-map
 "K" 'dired-k
 "g" 'revert-buffer
 "<tab>" 'dired-subtree-toggle
 "C-c n" 'dired-narrow
 "/" 'dired-narrow
 "<DEL>" 'my/dired-up-directory-same-buffer
 "<RET>" 'dired-find-alternate-file
 )

(general-define-key
 :keymaps 'org-mode-map

 )

;; MODALKA STUFF------------------------------------------------------------------------
(general-define-key
 :keymaps 'modalka-mode-map
 "j" 'next-line
 "k" 'previous-line
 "l" 'forward-char
 "h" 'backward-char
 ";"  'goto-last-change
 "v" 'set-mark-command
 "y" "C-y"
 "u" 'my/u-key-diff-modes-function
 "i" 'modalka-mode
 "e" "C-e"
 "a" 'move-beginning-of-line
 "A" 'back-to-indentation
 "." "M->"
 "," "M-<"
 "w" 'my/w-key-diff-modes-function
 "SPC" 'nil
 "r" 'avy-goto-char
 "c" 'smart-comment
 "x" 'recenter-top-bottom
 "d" 'delete-char
 "o" 'crux-smart-open-line-above
 "s" 'swiper
 "f" 'iy-go-to-char
 "b" 'iy-go-to-char-backward
 "p" 'my/select-current-line-and-forward-line
 "J" 'windmove-down
 "K" 'windmove-up
 "H" 'windmove-left
 "L" 'windmove-right
 "z" 'zop-to-char
 )

(general-define-key
 :keymaps 'modalka-mode-map
 :prefix "SPC"
 "f f" 'find-file
 "f b" 'bookmark-jump
 "p p" 'projectile-switch-project
 "p f" 'projectile-find-file
 "g g" 'magit-status
 "g s" 'google-this
 "x" 'execute-extended-command
 "o o" 'switch-window
 "1" 'switch-window-then-maximize
 "2" 'switch-window-then-split-below
 "3" 'switch-window-then-split-right
 "0" 'switch-window-then-delete
 ;; "b" 'switch-to-buffer
 "b" 'switch-to-buffer
 "s s" 'my/term
 "SPC" 'counsel-M-x
 "w n" 'eyebrowse-next-window-config
 "w p" 'eyebrowse-prev-window-config
 "d d" 'dired-sidebar-toggle-sidebar
 "w w" 'avy-kill-region
 "k" 'kill-buffer
 "e b" 'eval-buffer
 "r e" 'restart-emacs
 "o e" 'my/open-buffer-path-in-explorer
 "o t" 'my/open-terminal-in-workdir
 )


(provide 'my-keybinds)
