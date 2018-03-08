(in-package :cl-user)
(defpackage ahan-whun-shugoi.cli.command
  (:nicknames :aws.cli.command)
  (:use #:cl
        #:ahan-whun-shugoi.scraping
        #:ahan-whun-shugoi.cli.option)
  (:export #:make-aws-cli-command))
(in-package :ahan-whun-shugoi.cli.command)

(defun get-master (service-code command-code)
  (let* ((service (get-service :code service-code))
         (command (get-service-command service command-code))
         (aws-options (find-aws-options))
         (comman-options (find-command-options command)))
    (assert service)
    (assert command)
    (assert aws-options)
    (values service command (nconc aws-options comman-options))))

(defun get-code (obj &key to-str)
  (let ((code (aws.scraping::code obj)))
    (if (not to-str)
        code
        (string-downcase (symbol-name code)))))

(defun make-aws-cli-command (service-code command-code &optional options_in)
  (multiple-value-bind (service command options)
      (get-master service-code command-code)
    (format nil "aws ~a ~a~a"
            (get-code service :to-str t)
            (get-code command :to-str t)
            (opt2cmd options_in :master options))))
