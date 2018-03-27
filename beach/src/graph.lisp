(in-package :cl-user)
(defpackage ahan-whun-shugoi-beach.db
  (:nicknames :aws-beach.db)
  (:use :cl)
  (:export #:*graph*
           #:start
           #:stop
           #:snapshot
           #:refresh))
(in-package :ahan-whun-shugoi-beach.db)

(defvar *graph* nil)

(defvar *graph-stor-dir*
  (merge-pathnames "data/graph/" (asdf:system-source-directory :ahan-whun-shugoi-beach)))

(defun start ()
  (when *graph* (stop))
  (setf *graph*
        (shinra:make-banshou 'shinra:banshou *graph-stor-dir*)))

(defun snapshot (&key (graph *graph*))
  (up:snapshot graph))

(defun stop ()
  (when *graph*
    (upanishad:stop *graph*)
    (setf *graph* nil)))

(defun remove-all-files ()
  (mapcar #'delete-file
          (fad:list-directory *graph-stor-dir*)))

(defun refresh ()
  (stop)
  (remove-all-files)
  (start))
