(in-package :cl-user)
(defpackage ahan-whun-shugoi
  (:nicknames :aws)
  (:use #:cl
        #:aws.cli.command
        #:aws.help)
  (:import-from :local-time
                #:now)
  (:import-from :aws.beach
                #:collect
                #:find-aws-options
                #:get-command)
  (:export :aws)
  ;; db
  (:export #:start
           #:stop
           #:graph-data-stor)
  ;; ??
  (:export #:name
           #:*print-command-stream*))
(in-package :ahan-whun-shugoi)


(defun mapline (func text)
  (let ((out nil))
    (with-input-from-string (stream text)
      (do ((line (read-line stream nil 'eof)
                 (read-line stream nil 'eof)))
          ((eq line 'eof) out)
        (push (funcall func line) out)))))
