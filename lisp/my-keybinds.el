    ;;; -*- lexical-binding: t -*-

;; GLOBAL KEYS-----------------------------------------------------------------

;; just necessary for our scroll-down function
(autoload 'View-scroll-half-page-forward "view") (autoload 'View-scroll-half-page-backward "view")

(general-define-key
 "M-y" 'helm-show-kill-ring
 "M-x" 'execute-extended-command
 "M-<down>" 'move-text-down
 "M-<up>" 'move-text-up
 ;; "C-s" 'swiper-isearch
 "C-s" 'helm-swoop
 "C-z" 'nil
 "C-h" 'backward-char
 "C-l" 'forward-char
 "C-j" 'next-line
 "C-k" 'previous-line
 ;; "M-h" 'backward-word
 ;; "M-l" 'forward-word
 "C-b" 'kill-whole-line
 ;; "M-k" 'View-scroll-half-page-forward
 ;; "M-j" 'View-scroll-half-page-backward
 "M-w" 'xah-copy-line-or-region
 "C-o" 'open-line
 "C-a" 'move-beginning-of-line
 "C-x 4 t" 'crux-transpose-windows
 "C-x o" 'other-window
 "C-x 1" 'delete-other-windows
 "C-x 2" 'split-window-vertically
 "C-x 3" 'split-window-horizontally
 "C-x 0" 'delete-window
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
 ;; "C-;"  'goto-last-change
 ;; "M-u" 'xah-toggle-letter-case
 "M-u" 'fix-word-upcase
 "M-c" 'fix-word-capitalize
 "C-r" 'avy-goto-char
 ;; "C-." 'company-complete
 ;; "C-z" 'my/modalka-normal-mode
 ;; "<f9>" 'my/modalka-normal-mode
 "C-c _" 'undo-tree-visualize
 ;; "C-c c r" 'my/reload-emacs-configuration
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
 "C-<tab>" 'er-switch-to-previous-buffer
 "M-;" 'smart-comment
 )

;; MINOR MODE MAPS---------------------------------------------------------------------

(general-define-key
 :keymaps 'helm-map
 "C-j" 'helm-next-line
 "C-k" 'helm-previous-line
 )

(general-define-key
 :keymaps 'projectile-mode-map
 "s-p" 'projectile-command-map
 "C-c p" 'projectile-command-map
 )

(defun completatpoint ()
  (interactive)
  (ivy-alt-done t)
  )

(general-define-key
 :keymaps 'ivy-minibuffer-map
 "C-j" 'ivy-next-line
 "C-k" 'ivy-previous-line
 "C-h" "DEL"
 "C-l" 'completatpoint
 "C-<return>" 'completatpoint
 )

(general-define-key
 :keymaps 'ivy-switch-buffer-map
 "C-k" 'ivy-previous-line
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
 "C-M-h" 'windmove-left
 "C-M-l" 'windmove-right
 "C-M-j" 'windmove-down
 "C-M-k" 'windmove-up
 )



(general-create-definer my-leader-def
  ;; :prefix my-leader
  :prefix "SPC")

(general-create-definer my-local-leader-def
  ;; :prefix my-local-leader
  :prefix "SPC m")

(defun toggle-dired-sidebar-and-truncate-lines ()
  "truncates sidebar lines"
  (interactive)
  (dired-sidebar-toggle-sidebar)
  (toggle-truncate-lines)
  )

;; to prevent your leader keybindings from ever being overridden (e.g. an evil
;; package may bind "SPC"), use :keymaps 'override
(my-leader-def
  :states 'normal
  :keymaps 'override
  ;; "f f" 'counsel-find-file
  "f f" 'helm-find-files
  ;; "f b" 'counsel-bookmark
  "f b" 'helm-bookmarks
  ;; "p" 'projectile-command-map
  "p p" 'projectile-switch-project
  "p f" 'projectile-find-file
  "p s g" 'projectile-grep
  "p s g" 'projectile-grep
  "g g" 'magit-status
  "g s" 'google-this
  ;; "x s" 'persp-switch
  ;; "x k" 'persp-remove-buffer
  ;; "x c" 'persp-kill
  ;; "b b" 'ivy-switch-buffer
  "b b" 'helm-mini
  ;; "b a" 'persp-switch-to-buffer
  "o o" 'other-window
  "1" 'delete-other-windows
  "2" 'split-window-below
  "3" 'split-window-right
  "0" 'delete-window
  ;; "b" 'switch-to-buffer
  "s s" 'shell-pop
  "s m" 'smerge-start-session
  ;; "SPC" 'counsel-M-x
  "SPC" 'helm-M-x
  ;; "SPC" 'execute-extended-command
  ;; "w n" 'eyebrowse-next-window-config
  ;; "w p" 'eyebrowse-prev-window-config
  "d d" 'toggle-dired-sidebar-and-truncate-lines
  ;; "d d" 'treemacs
  ;; "w w" 'avy-kill-region
  ;; "k" 'kill-buffer
  "e b" 'eval-buffer
  "r e" 'restart-emacs
  "o e" 'my/open-buffer-path-in-explorer
  "o t" 'my/open-terminal-in-workdir
  "o v" 'my/overview
  "o a" 'my/exit-overview
  "t l" 'toggle-truncate-lines
  "i m" 'counsel-imenu
  "i a" 'ivy-imenu-anywhere
  )



(provide 'my-keybinds)
