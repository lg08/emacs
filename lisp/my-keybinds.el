;; GLOBAL KEYS-----------------------------------------------------------------
(general-define-key
 "M-y" 'counsel-yank-pop
 "M-x" 'amx
 "C-s" 'swiper-isearch
 "C-z" 'nil
 "C-h" 'backward-char
 "C-l" 'forward-char
 "C-j" 'next-line
 "C-k" 'previous-line
 "M-h" 'backward-word
 "M-l" 'forward-word
 "C-b" 'kill-whole-line
 "M-k" "C-u 5 C-v"
 "M-j" "C-u 5 M-v"
 "M-w" 'xah-copy-line-or-region
 "C-o" 'crux-smart-open-line-above
 "C-a" 'crux-move-beginning-of-line
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
 "C-=" 'er/expand-region
 "C--" 'er/contract-region
 "C-;"  'goto-last-change
 ;; "M-u" 'xah-toggle-letter-case
 "M-u" 'fix-word-upcase
 "C-r" 'avy-goto-char
 "C-." 'company-complete
 "C-z" 'my/modalka-normal-mode
 "<f9>" 'my/modalka-normal-mode
 "C-c _" 'undo-tree-visualize
 "C-c c r" 'my/reload-emacs-configuration
 "C-x C-d" 'my/double-pane-dired
 "C-x d" 'dired
 "<f8>" 'dired-sidebar-toggle-sidebar
 "C-M-w" 'avy-kill-region
 "M-g" 'nil
 "M-g" 'avy-goto-end-of-line
 "C-<backspace>" 'smart-hungry-delete-backward-char
 "C-M-a" 'sp-beginning-of-sexp
 "C-M-e" 'sp-end-of-sexp
 "C-M-l" 'sp-forward-sexp
 "C-M-h" 'sp-backward-sexp
 "M-]" 'sp-unwrap-sexp
 "M-[" 'sp-backward-unwrap-sexp 
 )

;; MINOR MODE MAPS---------------------------------------------------------------------


(general-define-key
 :keymaps 'projectile-mode-map
 "s-p" 'projectile-command-map
 "C-c p" 'projectile-command-map
 )

(general-define-key
 :keymaps 'ivy-minibuffer-map
 "C-j" 'ivy-next-line
 "C-k" 'ivy-previous-line
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
 ;; "w" 'crux-smart-kill-line
 "v" 'set-mark-command
 "q" 'set-mark-command
 "y" "C-y"
 "u" 'undo
 "i" 'modalka-mode
 ";" 'smart-comment
 "e" "C-e"
 "a" "C-a"
 "." "M->"
 "," "M-<"
 "w" 'xah-cut-line-or-region
 "SPC" 'nil
 "r" 'avy-goto-char
 "c" 'smart-comment
 "x" 'recenter-top-bottom
 "d" 'delete-char
 "o" 'crux-smart-open-line-above
 "s" 'swiper-isearch
 "[" 'backward-sexp
 "]" 'forward-sexp
 "f" 'iy-go-to-char
 "p" 'my/select-current-line-and-forward-line
 )

(general-define-key
 :keymaps 'modalka-mode-map
 :prefix "SPC"
 "f f" 'counsel-find-file
 "f b" 'bookmark-jump
 "p p" 'projectile-switch-project
 "p f" 'projectile-find-file
 "g" 'magit-status
 "x" 'execute-extended-command
 "o" 'switch-window
 "1" 'switch-window-then-maximize
 "2" 'switch-window-then-split-below
 "3" 'switch-window-then-split-right
 "0" 'switch-window-then-delete
 "b" 'switch-to-buffer
 "s s" 'persp-switch
 "SPC" 'amx
 "w n" 'eyebrowse-next-window-config        
 "w p" 'eyebrowse-prev-window-config
 "d d" 'dired-sidebar-toggle-sidebar
 "w w" 'avy-kill-region
 "k" 'kill-buffer
 "s s" 'persp-switch
 )


(provide 'my-keybinds)


