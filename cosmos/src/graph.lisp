(defpackage ahan-whun-shugoi.cosmos.graph
  (:nicknames :aws.cosmos.graph)
  (:use #:cl)
  (:import-from :asdf
                #:system-source-directory)
  (:import-from :fad
                #:list-directory)
  (:import-from :shinra
                #:banshou
                #:make-banshou)
  (:export #:*graph*
           #:start
           #:stop
           #:snapshot
           #:refresh
           #:*fook-graph-start-after*))
(in-package :ahan-whun-shugoi.cosmos.graph)

(defvar *graph* nil)

(defvar *graph-stor-dir*
  (merge-pathnames "data/graph/" (system-source-directory :ahan-whun-shugoi.cosmos)))

(defvar *fook-graph-start-after* nil)

(defun stop ()
  (when *graph*
    (upanishad:stop *graph*)
    (setf *graph* nil)))

(defun start ()
  (when *graph* (stop))
  (setf *graph*
        (make-banshou 'banshou *graph-stor-dir*))
  (when *fook-graph-start-after*
    (funcall *fook-graph-start-after*)))

(defun snapshot (&key (graph *graph*))
  (up:snapshot graph))

(defun remove-all-files ()
  (mapcar #'delete-file
          (list-directory *graph-stor-dir*)))
