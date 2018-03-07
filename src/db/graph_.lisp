(in-package :ahan-whun-shugoi)

(defvar *graph-data-stor* nil)
(defvar *graph* nil)

(defun graph-data-stor ()
  *graph-data-stor*)

(defun (setf graph-data-stor) (value)
  (setf *graph-data-stor* value))

(defun start ()
  (when *graph* (error "aledy started graph."))
  (let ((data-stor (graph-data-stor)))
    (unless data-stor (error "*tree-stor* is empty."))
    (setf *graph*
          (shinra:make-banshou 'shinra:banshou data-stor))))

(defun stop (&key (auto-commit nil))
  (unless *graph*
    (error "まだ初まってもいません。"))
  (when auto-commit
    (up:snapshot *graph*))
  (up:close-open-streams *graph*)
  (setf *graph* nil))
