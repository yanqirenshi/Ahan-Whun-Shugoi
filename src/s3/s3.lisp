(in-package :ahan-whun-sgoi)

;; ex) (aws :s3 "ls")

;;;
;;; s3-root-bucket
;;;
(defun s3-root-bucket-p (line)
  "2015-07-29 09:07:41 eb-native-ad-log"
  (multiple-value-bind (ret arr)
      (cl-ppcre:scan-to-strings "^(\\d+-\\d+-\\d+\\s+\\d+:\\d+:\\d+)\\s+(.*)$" line)
    (when ret arr)))

(defun arr2s3-root-bucket (arr)
  (when arr
    (make-instance 's3-root-bucket
                   :name (aref arr 1)
                   :timestamp (aref arr 0))))


;;;
;;; s3-branch-bucket
;;;
(defun s3-branch-bucket-p (line)
  "                           PRE resources/"
  (multiple-value-bind (ret arr)
      (cl-ppcre:scan-to-strings "^\\s+PRE\\s+(.*)/$" line)
    (when ret arr)))

(defun arr2s3-branch-bucket (arr)
  (when arr
    (make-instance 's3-root-bucket
                   :name (aref arr 0))))


;;;
;;; s3-file
;;;
(defun s3-file-p (line)
  "2015-07-15 12:49:26        521 2015196Ydn-production.zip"
  (multiple-value-bind (ret arr)
      (cl-ppcre:scan-to-strings "^(\\d+-\\d+-\\d+\\s+\\d+:\\d+:\\d+)\\s+(\\d+)\\s+(.*)$" line)
    (when ret arr)))

(defun arr2s3-file (arr)
  (when arr
    (make-instance 's3-file
                   :name (aref arr 2)
                   :size (aref arr 1)
                   :timestamp (aref arr 0))))


;;;
;;; s3
;;;
(defun line2s3-object (l)
  (or (arr2s3-file (s3-file-p l))
      (arr2s3-branch-bucket (s3-branch-bucket-p l))
      (arr2s3-root-bucket (s3-root-bucket-p l))
      (error "Faild parse s3 line")))

(defun aws-s3-ls (path &key recursive page-size human-readable summarize)
  (declare (ignore recursive page-size human-readable summarize))
  (let ((args (concatenate 'string "ls " (or path ""))))
    (mapline #'line2s3-object (aws :s3 args))))
