(in-package :cl-user)
(defpackage ahan-whun-shugoi.db
  (:nicknames :aws.db)
  (:use :cl))
(in-package :ahan-whun-shugoi.db)

(defvar *graph* nil)

(defvar *graph-stor-dir*
  (merge-pathnames "data/graph/" (asdf:system-source-directory :wnqi-big-size-api)))

(defun start ()
  (when *graph* (stop))
  (setf *graph*
        (shinra:make-banshou 'shinra:banshou *graph-stor-dir*)))

(defun stop ()
  (when *graph*
    (upanishad:stop *graph*)
    (setf *graph* nil)))
