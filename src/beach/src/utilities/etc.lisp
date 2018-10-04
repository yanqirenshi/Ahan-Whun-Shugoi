(in-package :cl-user)
(defpackage ahan-whun-shugoi-beach.util
  (:nicknames :aws.beach.util)
  (:use #:cl)
  (:import-from :split-sequence
                #:split-sequence)
  (:import-from :aws.beach.db
                #:*graph*)
  (:import-from :shinra
                #:find-vertex)
  (:export #:split-str-token
           #:trim
           #:str2keyword
           #:ensure-keyword))
(in-package :ahan-whun-shugoi-beach.util)

(defun trim (v)
  (string-trim '(#\Space #\Tab #\Newline) v))

(defun split-str-token (str delimiter)
  (mapcar #'trim
          (split-sequence delimiter str)))

(defun str2keyword (str)
  (alexandria:make-keyword (string-upcase str)))

(defun ensure-keyword (v)
  (cond ((keywordp v) v)
        ((stringp v) (str2keyword v))
        (t (error v))))
