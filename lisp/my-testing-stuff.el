;; ;; taken from here: https://github.com/mattmahn/emacsfiles/blob/master/emacs-config.org

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (prog-mode . lsp-deferred)
  :init
  (setq lsp-prefer-capf t))

;; TODO: make the window disappear/behave normally && hide line numbers
(defun my/hide-frame-line-numbers (frame _window)
  "Hides line nunmbers from a specific frame in a winow."
  (select-frame frame)
  (display-line-numbers-mode -1))

(use-package lsp-ui
  :requires (lsp-mode)
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-ignore-duplicate t)
  ;; (add-hook 'lsp-ui-doc-frame-hook #'my/hide-frame-line-numbers)
  )

(use-package lsp-ivy
  ;; :disabled
  :requires (lsp-mode)
  :commands (lsp-ivy-workspace-symbol lsp-ivy-global-workspace-symbol))

(use-package company-lsp
  :commands company-lsp
  :config
  (push 'company-lsp company-backends)
  (setq company-lsp-async t
        company-lsp-cache-candidates 'auto
        company-lsp-enable-recompletion t))


(setq gc-cons-threshold (* 10 1024 1024)
      read-process-output-max (* 1024 1024))




;; new splash screen
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


(defun splash-screen ()
  "Emacs splash screen"

  (interactive)
  (let* ((splash-buffer  (get-buffer-create "*splash*"))
         (recover-session (and auto-save-list-file-prefix
                               (file-directory-p (file-name-directory
                                                  auto-save-list-file-prefix))))
         (height         (- (window-body-height nil) 1))
         (width          (window-body-width nil))
         (padding-center (- (/ height 2) 1))
         (padding-bottom (- height (/ height 2) 3)))

    ;; If there are buffer associated with filenames,
    ;;  we don't show splash screen.
    (if (eq 0 (length (cl-loop for buf in (buffer-list)
                               if (buffer-file-name buf)
                               collect (buffer-file-name buf))))

        (with-current-buffer splash-buffer
          (erase-buffer)

          ;; Buffer local settings
          (if (one-window-p)
              (setq mode-line-format nil))
          (setq cursor-type nil)
          (setq vertical-scroll-bar nil)
          (setq horizontal-scroll-bar nil)
          (setq fill-column width)
          (face-remap-add-relative 'link :underline nil)

          ;; Vertical padding to center
          (insert-char ?\n padding-center)

          ;; Central text
          (insert-text-button " www.gnu.org "
			      'action (lambda (_) (browse-url "https://www.gnu.org"))
			      'help-echo "Visit www.gnu.org website"
			      'follow-link t)
          (center-line) (insert "\n")
          (insert (concat
                   (propertize "GNU Emacs"  'face 'bold)
                   " " "version "
                   (format "%d.%d" emacs-major-version emacs-minor-version)))
          (center-line) (insert "\n")
          (insert (propertize "A free/libre editor" 'face 'shadow))
          (center-line)


          ;; Vertical padding to bottom
          (insert-char ?\n padding-bottom)

          ;; Recover session button
          (when recover-session
            (delete-char -2)
            (insert-text-button " [Recover session] "
				'action (lambda (_) (call-interactively 'recover-session))
				'help-echo "Recover previous session"
				'face 'warning
				'follow-link t)
            (center-line) (insert "\n") (insert "\n"))

          ;; Copyright text
          (insert (propertize
                   "GNU Emacs comes with ABSOLUTELY NO WARRANTY" 'face 'shadow))
          (center-line) (insert "\n")
          (insert (propertize
                   "Copyright (C) 2020 Free Software Foundation, Inc." 'face 'shadow))
          (center-line) (insert "\n")

          (goto-char 0)
          (read-only-mode t)

          ;; (local-set-key [t]               'splash-screen-fade-to-about)
          (local-set-key (kbd "C-[")       'splash-screen-fade-to-default)
          (local-set-key (kbd "<escape>")  'splash-screen-fade-to-default)
          (local-set-key (kbd "q")         'splash-screen-fade-to-default)
          (local-set-key (kbd "<mouse-1>") 'mouse-set-point)
          (local-set-key (kbd "<mouse-2>") 'operate-this-button)
          ;; (local-set-key " "               'splash-screen-fade-to-default)
          ;; (local-set-key "x"               'splash-screen-fade-to-default)
          ;; (local-set-key (kbd "<RET>")     'splash-screen-fade-to-default)
          ;; (local-set-key (kbd "<return>")  'splash-screen-fade-to-default)
          (display-buffer-same-window splash-buffer nil)
          ;; (run-with-idle-timer 10.0 nil    'splash-screen-fade-to-about)


	  ;; (modalka-mode)		;I added this just to help us navigate quicker
	  ))))


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

(provide 'splash-screen)
;;; splash-screen.el ends here



(setq frame-title-format
      '("" invocation-name ": "
        (:eval
         (if buffer-file-name
             (abbreviate-file-name buffer-file-name)
           "%b"))))



;; (setq ido-separator "\n")		;tells ido mode to display vertically

(setq flx-ido-mode 1)
(setq ido-enable-flex-matching t)

(ido-mode 1)
(ido-everywhere 1)


(use-package ido-completing-read+
  :defer t
  :config

  )

(ido-ubiquitous-mode 1)
(use-package amx
  :init
  (amx-mode 1)
  :defer t
  :config

  )

(require 'icomplete)
(icomplete-mode 1)


(defun ido-my-keys ()
  (define-key ido-completion-map (kbd "C-k")   'ido-prev-match)
  (define-key ido-completion-map (kbd "C-j") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-k")   'ido-prev-match)
  (define-key ido-completion-map (kbd "C-j") 'ido-next-match)

  )


(add-hook 'ido-setup-hook 'ido-my-keys)

(setq ido-decorations (quote ("\n-> " "" "\n " "\n ..." "[" "]" "
  [No match]" " [Matched]" " [Not readable]" " [Too big]" "
  [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)


(setq tramp-default-method "ssh")

;; (customize-set-variable 'tramp-syntax 'simplified)



(defvar custom-ido-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<C-return>") 'ido-select-text)
    ;; (define-key map (kbd "<M-return>") 'ido-magic-forward-char)
    map))
(with-eval-after-load 'ido
  (define-key ido-common-completion-map (kbd "<C-return>") 'ido-select-text)
  ;; (define-key ido-common-completion-map (kbd "<M-return>") 'ido-magic-forward-char)
  )
(add-to-ordered-list 'emulation-mode-map-alists
                     `((cua-mode . ,custom-ido-map))
                     0)



(provide 'my-testing-stuff)
