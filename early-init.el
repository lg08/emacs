;;; early-init.el -*- lexical-binding: t; -*-
(set-background-color "black")

;; Defer garbage collection further back in the startup process
;; (setq gc-cons-threshold most-positive-fixnum)

;; just makes sure that there is no automatic package initialization
;; (setq package-enable-at-startup nil)
;; (advice-add #'package--ensure-init-file :override #'ignore)


;; Emacs "updates" its ui more often than it needs to, so we slow it down
;; slightly from 0.5s:
;; (setq idle-update-delay 1.0)
;; (setq idle-update-delay .05)

;; Disabling the BPA makes redisplay faster, but might produce incorrect display
;; reordering of bidirectional text with embedded parentheses and other bracket
;; characters whose 'paired-bracket' Unicode property is non-nil.
;; (setq bidi-inhibit-bpa t)  ; Emacs 27 only


;; Prevent the glimpse of un-styled Emacs by disabling these UI elements early.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we halve startup times, particularly when we use
;; fonts that are larger than the system default (which would resize the frame).
;; (setq frame-inhibit-implied-resize t)

;; Font compacting can be terribly expensive, especially for rendering icon
;; fonts on Windows. Whether it has a notable affect on Linux and Mac hasn't
;; been determined, but we inhibit it there anyway.
;; (setq inhibit-compacting-font-caches t)

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
;; (setq frame-inhibit-implied-resize t)

;; Ignore X resources; its settings would be redundant with the other settings
;; in this file and can conflict with later config (particularly where the
;; cursor color is concerned).
;; (advice-add #'x-apply-session-resources :override #'ignore)
