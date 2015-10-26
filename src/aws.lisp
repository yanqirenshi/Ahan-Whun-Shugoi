(in-package :ahan-whun-sgoi)

(defun mapline (func text)
  (let ((out nil))
    (with-input-from-string (stream text)
      (do ((line (read-line stream nil 'eof)
                 (read-line stream nil 'eof)))
          ((eq line 'eof) out)
        (push (funcall func line) out)))))

(defun servicep (service)
  (find service '(:s3 :elb :ec2)))

(defun make-aws-command (service &rest option)
  (format nil "aws ~a ~a"
          (string-downcase (symbol-name service))
          (first option)))

(defun valudation-service (service)
  (unless (servicep service)
    (error "not supported service. service=~a" service)))

(defun aws (service &rest options)
  (valudation-service service)
  (let ((cmd (apply #'make-aws-command service options)))
    (print cmd)
    (multiple-value-bind (values output error-output exit-status)
        (trivial-shell:shell-command cmd)
      (declare (ignore output error-output exit-status))
      values)))