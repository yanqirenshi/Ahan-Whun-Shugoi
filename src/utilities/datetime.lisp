(in-package :cl-user)
(defpackage ahan-whun-shugoi.util.datetime
  (:nicknames :aws.util.datetime)
  (:use :cl)
  (:export #:unix2timestamp
           #:timestamp2unix
           #:timestamp2YYYYMMDD_HHMMSS
           #:one-week-ago
           #:one-month-ago
           #:2timestamp
           #:2unix))
(in-package :ahan-whun-shugoi.util.datetime)

(defvar *aws-unix-time-msec* 1000)

(defun unix2timestamp (unix-time &key (aws t))
  (when unix-time
    (local-time:unix-to-timestamp (if aws
                                      (floor (/ unix-time *aws-unix-time-msec*))
                                      unix-time))))

(defun timestamp2unix (timestamp &key (aws t))
  (let ((unix (local-time:timestamp-to-unix timestamp)))
    (if aws (* *aws-unix-time-msec* unix) unix)))


(defun timestamp2YYYYMMDD_HHMMSS (timestamp)
  (let ((format '((:YEAR 4) #\- (:MONTH 2) #\- (:DAY 2)
                  #\Space
                  (:HOUR 2) #\: (:MIN 2) #\: (:SEC 2))))
    (local-time:format-timestring nil timestamp :format format)))

(defun one-week-ago (&optional (timestamp (local-time:today)))
  (local-time:timestamp- timestamp 7 :day))

(defun one-month-ago (&optional (timestamp (local-time:today)))
  (local-time:timestamp- timestamp 1 :month))

(defgeneric 2timestamp (value)
  (:method ((value local-time:timestamp))
    value)
  (:method ((value string))
    (local-time:parse-timestring value))
  (:method ((value integer))
    (cond ((= 13 (length (princ-to-string value)))
           (unix2timestamp value :aws t))
          ((< value 2000000000)
           (local-time:unix-to-timestamp value))
          ((> value 2000000000)
           (local-time:universal-to-timestamp value)))))

(defun 2unix (value &key (aws t))
  (let* ((timestamp (2timestamp value))
         (unix (local-time:timestamp-to-unix timestamp)))
    (if aws
        (+ (* *aws-unix-time-msec* unix)
           (local-time:timestamp-millisecond timestamp))
        unix)))
