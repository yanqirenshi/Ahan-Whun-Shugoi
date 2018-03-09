(in-package :cl-user)
(defpackage ahan-whun-shugoi.cli.command
  (:nicknames :aws.cli.command)
  (:use #:cl
        #:ahan-whun-shugoi.scraping
        #:ahan-whun-shugoi.cli.option)
  (:export #:make-aws-cli-command))
(in-package :ahan-whun-shugoi.cli.command)

(defun get-master (command-code subcommand-code)
  (let* ((command (get-command :code command-code))
         (subcommand (get-command-subcommand command subcommand-code))
         (aws-options (find-aws-options))
         (comman-options (find-subcommand-options subcommand)))
    (assert command)
    (assert subcommand)
    (assert aws-options)
    (values command subcommand (nconc aws-options comman-options))))

(defun get-code (obj &key to-str)
  (let ((code (aws.scraping::code obj)))
    (if (not to-str)
        code
        (string-downcase (symbol-name code)))))

(defun make-aws-cli-command (command-code subcommand-code &optional options_in)
  (multiple-value-bind (command subcommand options)
      (get-master command-code subcommand-code)
    (format nil "aws ~a ~a~a"
            (get-code command :to-str t)
            (get-code subcommand :to-str t)
            (opt2cmd options_in :master options))))
