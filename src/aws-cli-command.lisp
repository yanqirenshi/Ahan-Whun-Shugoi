(in-package :ahan-whun-shugoi)

(defun make-aws-cli-command (service command options)
  (format nil "aws ~a ~a ~a"
          (string-downcase (symbol-name service))
          (string-downcase (symbol-name command))
          (if options
              (opt2cmd options)
              "")))
