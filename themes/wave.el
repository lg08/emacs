;;; -*- mode: emacs-lisp; lexical-binding: t -*-


;; USER SETTINGS

(defconst --wave-rows 20)
(defconst --wave-cols 20)
(defconst --wave-frames-per-second 5)

;;      ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;      ++ / .-'---'-. \  |  / .-'---'-. \  |  / .-'---'-. \  |  / .-'++
;;      ++.-'---'-. \  |  / .-'---'-. \  |  / .-'---'-. \  |  / .-'---++
;;      ++---'-. \  |  / .-'---'-. \  |  / .-'---'-. \  |  / .-'---'-.++
;;      ++'-. \  |  / .-'---'-. \  |  / .-'---'-. \  |  / .-'---'-. \ ++
;;      ++ \  |  / .-'---'-. \  |  / .-'---'-. \  |  / .-'---'-. \  | ++
;;      ++ |  / .-'---'-. \  |  / .-'---'-. \  |  / .-'---'-. \  |  / ++
;;      ++ / .-'---'-. \  |  / .-'---'-. \  |  / .-'---'-. \  |  / .-'++
;;      ++.-'---'-. \  |  / .-'---'-. \  |  / .-'---'-. \  |  / .-'---++
;;      ++---'-. \  |  / .-'---'-. \  |  / .-'---'-. \  |  / .-'---'-.++
;;      ++'-. \  |  / .-'---'-. \  |  / .-'---'-. \  |  / .-'---'-. \ ++
;;      ++ \  |  / .-'---'-. \  |  / .-'---'-. \  |  / .-'---'-. \  | ++
;;      ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; BODY


(defvar --wave--current-thread nil)

(defun --wave-start ()
  (interactive)
  (let*((buffer (get-buffer-create "*animation*"))
        (states ["---"
                 "'-."
                 " \\ "
                 " | "
                 " / "
                 ".-'"])
        (n-states (length states))
        (--wave-anim-state 0))
    (switch-to-buffer buffer)
    (setq --wave--current-thread
      (make-thread
       (lambda ()
         (with-demoted-errors "%S"
           (while (and (eq (current-thread) --wave--current-thread)
                       (eq (window-buffer) buffer))
             (with-current-buffer buffer
               (erase-buffer)
               (setq --wave-anim-state (mod (+ 1 --wave-anim-state) n-states))
               (insert (format "%02d" --wave-anim-state) "\n\n")
               (dotimes (row --wave-rows)
                 (insert "\t++")
                 (dotimes (col --wave-cols)
                   (cond ((= row 0)
                          (insert "+++"))
                         ((= row (1- --wave-cols))
                          (insert "+++"))
                         (t
                          (insert (aref states (mod (+ --wave-anim-state col row)
                                                    n-states))))))
                 (insert "++\n"))
               (redisplay)
               (sleep-for (/ 1.0 --wave-frames-per-second))))
           (message "Wave thread %s will stop." (current-thread))))))))


(defun --wave-stop ()
  (interactive)
  (setq --wave--current-thread nil))


(--wave-start)
