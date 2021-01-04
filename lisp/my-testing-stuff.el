;; ;; taken from here: https://github.com/mattmahn/emacsfiles/blob/master/emacs-config.org

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy)

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))




(use-package company-anaconda
  :init
  (eval-after-load "company"
    '(add-to-list 'company-backends 'company-anaconda))
  (add-hook 'python-mode-hook 'anaconda-mode)
  :defer t
  :config

  )



(setq frame-title-format
      '("" invocation-name ": "
        (:eval
         (if buffer-file-name
             (abbreviate-file-name buffer-file-name)
           "%b"))))



;; (setq ido-separator "\n")		;tells ido mode to display vertically

;; (setq flx-ido-mode 1)
;; (setq ido-enable-flex-matching t)

;; (ido-mode 1)
;; (ido-everywhere 1)


;; (use-package ido-completing-read+
;;   :defer t
;;   :config

;;   )

;; (ido-ubiquitous-mode 1)
;; (use-package amx
;;   :init
;;   (amx-mode 1)
;;   :defer t
;;   :config

;;   )

;; (require 'icomplete)
;; (icomplete-mode 1)


;; (defun ido-my-keys ()
;;   (define-key ido-completion-map (kbd "C-k")   'ido-prev-match)
;;   (define-key ido-completion-map (kbd "C-j") 'ido-next-match)
;;   (define-key ido-completion-map (kbd "C-k")   'ido-prev-match)
;;   (define-key ido-completion-map (kbd "C-j") 'ido-next-match)

;;   )


;; (add-hook 'ido-setup-hook 'ido-my-keys)

;; ;; (setq ido-decorations (quote ("\n-> " "" "\n " "\n ..." "[" "]" "
;; ;;   [No match]" " [Matched]" " [Not readable]" " [Too big]" "
;; ;;   [Confirm]")))
;; (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
;; (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)


(setq tramp-default-method "ssh")

;; ;; (customize-set-variable 'tramp-syntax 'simplified)



;; (defvar custom-ido-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "<C-return>") 'ido-select-text)
;;     ;; (define-key map (kbd "<M-return>") 'ido-magic-forward-char)
;;     map))
;; (with-eval-after-load 'ido
;;   (define-key ido-common-completion-map (kbd "<C-return>") 'ido-select-text)
;;   ;; (define-key ido-common-completion-map (kbd "<M-return>") 'ido-magic-forward-char)
;;   )
;; (add-to-ordered-list 'emulation-mode-map-alists
;;                      `((cua-mode . ,custom-ido-map))
;;                      0)

;;; org-watchlist.el --- Playlist logging based on org-mode -*- lexical-binding: t; -*-
;;;
;;
;; Copyright (C) 2020 Tadeáš Vintrlík
;; This package is published under GNU GPLv3
;; more info here: https://www.gnu.org/licenses/gpl-3.0.en.html
;;
;; Author: Tadeáš Vintrlík <https://github.com/Brwo>
;; Maintainer: Tadeáš Vintrlík <tadeas.vintrlik@protonmail.com>
;; Created: June 21, 2020
;; Modified: June 21, 2020
;; Version: 0.0.1
;; Keywords: emms, org, log, media
;; Homepage: https://github.com/Brwo/org-watchlist
;; Package-Requires: ((emacs 26.3) (cl-lib "0.5") (emms "5.4") (org-mode "9.4"))
;;
;;; Code:


(defgroup org-watchlist nil
  "Playlist logging based on org-mode."
  :prefix "org-watchlist-"
  :group 'org-watchlist)

(defcustom org-watchlist-file (concat org-directory "/watchlist.org")
  "File with infromation about shows in 'org-mode'."
  :group 'org-watchlist
  :type 'file)


(defun org-watchlist-cookie-value (point)
  "Return value of first 'org-mode' statistics cookie on line after POINT.
For example [2/7]. Nil if no cookie is found"
  (save-excursion
    (goto-char (point-min))
    (org-mode)
    (goto-char point)
    (when
        (search-forward "[" (line-end-position) t)
      (goto-char (- (point) 1))
      (plist-get (car(cdr (org-element-statistics-cookie-parser))) :value))))


(defun org-watchlist-cookie-parse (value)
  "Parse statistics cookie VALUE.
return list where car is done and cdr is total.
Does not work on % cookies. For a cookie [2/7] it will return (2 . 7)."
  (when value
    (let ((strlen (- (length value) 1)))
      (while (and (> strlen 0) (not(=(aref value strlen)47))) ;; while char not /
        (setq strlen (- strlen 1)))
      (cons (string-to-number(substring value 1 strlen)) (string-to-number(substring value (1+ strlen) (- (length value)1)))))))


(defun org-watchlist-folder-name-from-path (path)
  "Return just the last directory from PATH."
  (let* ((NAME path)
         (STRLEN (-(length NAME)2))) ;; -2 since the last / symbol is undeisred
    (while (and (> STRLEN 0) (not(=(aref NAME STRLEN)47))) ;; while char not /
      (setq STRLEN (1- STRLEN)))
    (substring NAME (1+ STRLEN) (1-(length NAME))))) ;; then text between last two /s is directory name


(defun org-watchlist-generate-cookie (done total)
  "Create an 'org-mode' statistics cookie [DONE/TOTAL]."
  (concat "[" (number-to-string done) "/" (number-to-string total) "]"))


(defun org-watchlist-show-end ()
  "Find end of show by NAME.
NAME is 'default-directory' which should be current directory in most cases.
Copies the contents of org-watchlist-file into a new temporary buffer.
Find show with the same name as 'default-directory'. Check if it is not DONE.
Returns a list of season and episode or nil and episode if show does not
have seasons. If anything fails returns nil."
  (interactive)
  (let* ((SEASON-END nil) ;; Number of current season
         (EPISODE-END nil) ;; Number of last episode
         (BOUND-SEASONS nil) ;; boundary for search if seasons exist
         (BOUND-TODO nil) ;; EOL for finding todo
         (NAME (org-watchlist-folder-name-from-path default-directory)))
    (with-temp-buffer
      (insert-file-contents org-watchlist-file)
      (when (search-forward NAME nil t) ;; if in watchlist
        (save-excursion
          (end-of-line)
          (setq BOUND-TODO (point))
          (forward-line)
          (end-of-line)
          (setq BOUND-SEASONS (point)))
        (beginning-of-line)
        (when (save-excursion(search-forward "TODO" BOUND-TODO t)) ;; if not done
          (if (save-excursion(search-forward "Season" BOUND-SEASONS t)) ;; if the word Season is on next line has seasons
              (save-excursion
                (setq SEASON-END (1+(car(org-watchlist-cookie-parse(org-watchlist-cookie-value(point))))))
                (forward-line SEASON-END)
                (setq EPISODE-END (car(org-watchlist-cookie-parse(org-watchlist-cookie-value(point))))))
            (setq EPISODE-END (car(org-watchlist-cookie-parse(org-watchlist-cookie-value (point))))))))
      (cons SEASON-END EPISODE-END))))


(defun org-watchlist-play ()
  "Play show in current directory.
Search for name of directory in 'wathclist-file'. Get SHOW-END.
If it has seasons enter the correct directory of the Season.
Then play the file. Throw an error message otherwise."
  (interactive)
  (let* ((PATH default-directory)
         (SHOW-END (org-watchlist-show-end))
         (TIME nil)
         (SEASON nil)
         (EPISODE nil))
    (when (cdr SHOW-END)
      (setq EPISODE (number-to-string(1+(cdr SHOW-END)))) ;; 1+ to get episode to watch
      (when (car SHOW-END)
        (setq SEASON (number-to-string(car SHOW-END)))))
    (message EPISODE)
    (if EPISODE ;; If show exists is non nil (every show must have an episode number)
        (progn
          (when SEASON ;; If show has seasons use the directory called Season N
            (setq PATH (concat PATH "Season " SEASON "/")))
          (when (= 1 (length EPISODE)) ;; Prepend 0 to episode number
            (setq EPISODE (concat "0" EPISODE)))
          (setq PATH (car(directory-files PATH t EPISODE)))
          (setq TIME (org-watchlist-get-time))
          (emms-play-file PATH)
          (sit-for 1) ;; must wait for the player process to start
          (when TIME ;; When time is logged
            (emms-seek-to TIME))) ;; seek forward to that TIME
      (message "Show not in watchlist or done."))))


(defun org-watchlist-replace-cookies (COOKIE COOKIE-AFTER POINT FINISHED)
  "Help function for org-watchlist-finished.
COOKIE Value of statistics cookie that will be replaced.
COOKIE-AFTER the value to replace COOKIE with.
POINT number of line on which this replacement should occur.
FINISHED Boolean if the entire Season or Show should be logged as DONE."
  (let ((START nil)
        (END nil))
    (goto-char (point-min))
    (goto-char POINT)
    (end-of-line)
    (setq END (point))
    (beginning-of-line)
    (setq START (point))
    (search-forward COOKIE END)
    (replace-match COOKIE-AFTER)
    (goto-char START)
    (when FINISHED ;; when season or show DONE
      (search-forward "TODO" END t)
      (replace-match "DONE"))))

(defun org-watchlist-finished ()
  "Log episode finished by NAME.
Find NAME in 'org-watchlist-file' and get the statistics cookie.
If show does not have seasons get cookie of entire show. If it does
get cookie of the current season. Increase the first number of the cookie
by one. If the change from TODO to DONE if the cookie is complete. Also change
the Season as done if the show has Seasons."
  (interactive)
  (let* ((NAME (org-watchlist-folder-name-from-path default-directory))
         (COOKIE nil) ;; Value of statistics cookie
         (HAS-SEASONS nil)
         (COOKIE-AFTER nil) ;; Statistics cookie used for replace
         (BOUND-SEASONS nil) ;; boundary for search if seasons exist
         (POINT nil)
         (DONE nil)
         (TOTAL nil))
    (org-watchlist-delete-time) ;; Remove logged time
    (with-temp-file org-watchlist-file
      (insert-file-contents org-watchlist-file)
      (when (search-forward NAME nil t)
        ;; Episode is done thus progress is no longer neccessary
        (beginning-of-line)
        (save-excursion
          (forward-line)
          (end-of-line)
          (setq BOUND-SEASONS (point)))
        (save-excursion
          (when (search-forward "Season" BOUND-SEASONS t)
            (setq HAS-SEASONS t)))
        (if HAS-SEASONS
            (save-excursion
              (forward-line (1+(car(org-watchlist-cookie-parse(org-watchlist-cookie-value (point)))))) ;; Go to current season
              (setq POINT (point))
              (setq COOKIE (org-watchlist-cookie-value(point)))) ;; get season cookie
          (save-excursion ;; if no seasons
            (setq COOKIE (org-watchlist-cookie-value(point))) ;; get show cookie
            (setq POINT (point))))
        (setq DONE (1+(car(org-watchlist-cookie-parse COOKIE))))
        (setq TOTAL (cdr(org-watchlist-cookie-parse COOKIE)))
        (setq COOKIE-AFTER (org-watchlist-generate-cookie DONE TOTAL)) ;; set cookie for replace
        (save-excursion
          (org-watchlist-replace-cookies COOKIE COOKIE-AFTER POINT (= TOTAL DONE)))
        (when (and HAS-SEASONS (= TOTAL DONE)) ;; If has seasons also log season as DONE
          (setq COOKIE (org-watchlist-cookie-value(point)))
          (setq DONE (1+(car(org-watchlist-cookie-parse COOKIE))))
          (setq TOTAL (cdr(org-watchlist-cookie-parse COOKIE)))
          (setq POINT (point))
          (setq COOKIE-AFTER (org-watchlist-generate-cookie DONE TOTAL))
          (org-watchlist-replace-cookies COOKIE COOKIE-AFTER POINT (= TOTAL DONE)))))))


(defun org-watchlist-get-time ()
  "Getter for time of current show.
Reads the time from my custom time cookie.
Located at the end of the line with name of the show in
org-watchlist-file. Might look like this [TIME: 12]
Meaning 12 seconds into the playback."
  (interactive)
  (let
      ((NAME (org-watchlist-folder-name-from-path default-directory))
       (END nil))
    (with-temp-buffer
      (insert-file-contents org-watchlist-file)
      (when (search-forward NAME nil t)
        (save-excursion
          (end-of-line)
          (setq END (point)))
        (if (search-forward "[" END t)
              (string-to-number (buffer-substring (+ 6 (point)) (1- END)))
          nil)))))


(defun org-watchlist-delete-time ()
  "Remove the time for current show.
Dletes the my custom time cookie"
  (interactive)
  (let
      ((NAME (org-watchlist-folder-name-from-path default-directory))
       (END nil))
    (with-temp-file org-watchlist-file
      (insert-file-contents org-watchlist-file)
      (when (search-forward NAME nil t)
        (save-excursion
          (end-of-line)
          (setq END (point)))
        (when (search-forward "[" END t)
          (progn
            (backward-char)
            (delete-region (1-(point)) END)))))))


(defun org-watchlist-set-time ()
  "Save time from the currently watched show."
  (interactive)
  (let
      ((NAME (org-watchlist-folder-name-from-path default-directory)))
    (org-watchlist-delete-time)
    (with-temp-file org-watchlist-file
      (insert-file-contents org-watchlist-file)
      (when (search-forward NAME nil t)
        (end-of-line)
        (insert (concat " [TIME: "(number-to-string emms-playing-time) "]"))))))


(provide 'org-watchlist)
;;; org-watchlist.el ends here

(setq org-watchlist-file (concat user-emacs-directory "watchlist.org"))

(provide 'my-testing-stuff)
