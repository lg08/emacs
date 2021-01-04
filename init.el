;; it.el, main config file, basically just sets things up and loads other files

(setq user-full-name "Lucas Gen")
(setq user-mail-address "lucasgen08@gmail.com")

(message "Gemacs is powering up... Be patient, Master %s!" user-full-name)

(when (version< emacs-version "25.1")
  (error "Sorry, gemacs requires GNU Emacs 25.1 or newer, but you're running %s" emacs-version))


;; define the folders needed for this configuration
(defvar gemacs-dir (file-name-directory load-file-name)
  "The root dir of this distribution.")
(defvar gemacs-lisp-dir (expand-file-name "lisp" gemacs-dir)
  "Where all the lisp files for gemacs are stored.")
(defvar gemacs-themes-dir (expand-file-name "themes" gemacs-dir)
  "Where all the custom themes for gemacs are stored.")
(defvar gemacs-misc-dir (expand-file-name "misc" gemacs-dir)
  "Where all the miscellaneous auto-made files for gemacs are stored.")

;; make the folders if necessary
(unless (file-exists-p gemacs-lisp-dir)
  (make-directory gemacs-lisp-dir))
(unless (file-exists-p gemacs-themes-dir)
  (make-directory gemacs-themes-dir))
(unless (file-exists-p gemacs-misc-dir)
  (make-directory gemacs-misc-dir))

;; makes gemacs look for all our personal files
(add-to-list 'load-path gemacs-lisp-dir)
;; tells gemacs where to look for personally loaded themes
(add-to-list 'custom-theme-load-path gemacs-themes-dir)


;; declares the custom file and loads it
;; (setq custom-file (concat gemacs-lisp-dir "custom-file.el"))
;; (when (file-exists-p custom-file)
;;   (load custom-file))
(setq custom-file (make-temp-file ""))
(setq custom-safe-themes t)


(load-theme 'nord)

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



(message "Loading Gemacs' configurations...")

;; requires all necessary files
(require 'my-functions)

(require 'my-settings)

(require 'my-packages)

(require 'my-keybinds)

(require 'my-skeletons)

(require 'my-modes)

(require 'my-testing-stuff)

;; startup message
(setq startup-message
      (format "Welcome back old friend. Emacs ready in %.2f seconds with %d garbage collections."
              (float-time (time-subtract after-init-time before-init-time)) gcs-done))
(defun display-startup-echo-area-message ()
  (display-message-or-buffer startup-message))
(message startup-message)

;; sets up frame title and initial scratch messsage
;; (setq frame-title-format '("" "%b - My-Dope-Ass Config"))
(setq initial-scratch-message "Welcome back old friend... \n\nEmacs is here. You're ok now.\n\n\n")
