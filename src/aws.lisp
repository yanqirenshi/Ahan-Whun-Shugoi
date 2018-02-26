(in-package :ahan-whun-shugoi)

(defvar *commands*
  `((:s3 ,(cmds-s3))
    (:ec2 ,(cmds-ec2))))

(defun mapline (func text)
  (let ((out nil))
    (with-input-from-string (stream text)
      (do ((line (read-line stream nil 'eof)
                 (read-line stream nil 'eof)))
          ((eq line 'eof) out)
        (push (funcall func line) out)))))

(defun servicep (service)
  (assert (keywordp service))
  (assoc service *commands*))

(defun get-command-options (service cmd)
  (cadr (assoc cmd (cadr (assoc service *commands*)))))

(defun make-aws-command (service command &rest options)
  (let ((options (get-command-options service command)))
    (declare (ignore options))
    (format nil "aws ~a ~a ~a"
            (string-downcase (symbol-name service))
            (string-downcase (symbol-name command))
            (first options))))

(defun valudation-service (service)
  (unless (servicep service)
    (error "not supported service. service=~a" service)))

(defun aws (service command &rest options)
  (assert (servicep service))
  (let ((cmd (apply #'make-aws-command service command options)))
    (multiple-value-bind (values output error-output exit-status)
        (trivial-shell:shell-command cmd)
      (declare (ignore output error-output exit-status))
      values)))
