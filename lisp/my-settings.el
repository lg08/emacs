;; basic settings


(setq lexical-binding t)              ;idk, something to do with loading lexical files faster

(setq inhibit-startup-message t)  ;i kinda like it but most people don't

(setq ring-bell-function 'ignore)   ;don't annoy me with bells and shit

(setq save-abbrevs 'silent)        ;; save abbrevs when files are saved

(setq initial-major-mode 'fundamental-mode) ;starts in fundamental mode to load faster

;; (global-subword-mode 1)		;detects camel case and counts them as muliple words

(setq-default indicate-empty-lines t)   ; shows the little black lines on the side of the buffer

(setq indicate-empty-lines t)           ; show empty lines in the fringe

(electric-pair-mode 1)                  ;automatically inserts matching parentheses and shit

(setq use-dialog-box nil)		;don't give me gui windows

(global-display-line-numbers-mode)      ;seems to be the best line number mode in my experience
(setq-default display-line-numbers 'relative) ;shows the relative line numbers instead
(setq display-line-numbers-type 'relative)
(global-hl-line-mode 1)            ;highlights the current line
;; (set-face-attribute hl-line-face nil :underline t) ;underlines the current line

;; starts a server if there's not already one running
(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))





(provide 'my-settings)
