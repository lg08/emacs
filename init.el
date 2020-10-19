;; init.el, main config file, basically just sets things up and loads other files

(setq user-full-name "Lucas Gen")
(setq user-mail-address "lucasgen08@gmail.com")

;; adds the path to personal lisp files
(add-to-list 'load-path ".emacs.d/lisp/")
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "lisp/themes"))

;; declares the custom file and loads it
(setq custom-file (concat user-emacs-directory "lisp/custom-file.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;; bootstraps straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; replaces use-package with straight-use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; loads the theme
(straight-use-package 'doom-themes)
(load-theme 'doom-one t)
(set-background-color "black")


;; requires all necessary files
(require 'my-settings)

(require 'my-packages)

(require 'my-functions)

(require 'my-keybinds)

(require 'my-skeletons)

(require 'my-modes)

(require 'my-testing-stuff)





;; (my/double-pane-dired)
