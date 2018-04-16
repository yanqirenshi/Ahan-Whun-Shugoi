(in-package :cl-user)
(defpackage ahan-whun-shugoi.cli.config
  (:nicknames :aws.cli.config)
  (:use :cl)
  (:import-from :alexandria
                #:if-let)
  (:import-from :cl-ppcre
                #:scan-to-strings)
  (:export #:get-config))
(in-package :ahan-whun-shugoi.cli.config)

(defun header-line-regex () "^\\[([\\S\\s]+)\\]$")

(defun header-line-p (line)
  (cl-ppcre:scan-to-strings (header-line-regex) line))

(defun get-header-info (line)
  (multiple-value-bind (ret arr)
      (cl-ppcre:scan-to-strings (header-line-regex) line)
    (when ret (first (last (split-sequence:split-sequence #\Space (aref arr 0)))))))

(defun %read-aws-config-file (s &optional header plist)
  (if-let ((line (read-line s nil nil)))
    (if (not (header-line-p line))
        (%read-aws-config-file s header (cons line plist))
        (if (null header)
            (%read-aws-config-file s (get-header-info line) nil)
            (cons (list header plist)
                  (%read-aws-config-file s (get-header-info line) nil))))
    `((,header ,plist))))

(defun read-aws-config-file (&optional (aws-config-file #P"~/.aws/config"))
  "return (:defult () :profile () ....)"
  (with-open-file (s aws-config-file)
    (%read-aws-config-file s)))

(defun get-config (config-name)
  (cadr (assoc config-name (read-aws-config-file) :test 'equal)))
