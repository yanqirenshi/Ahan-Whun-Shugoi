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

(defun options-table ()
  '((:--profile 'string)))

(defun get-option-values (options)
  (let ((first-keyword-position (position-if (lambda (v) (keywordp v)) options)))
    (if (null first-keyword-position)
        options
        (subseq options 0 first-keyword-position))))

(defun assert-option-values (option-table-values option-values)
  (assert (= (length option-table-values)
             (length option-values))))

(defun opt2cmd (options &key (options-table (options-table)))
  (when options
    (let* ((option (car options))
           (option-table (assoc option options-table)))
      (assert (keywordp option))
      (assert option-table)
      (let ((option-table-values (cdr option-table))
            (option-values (get-option-values (cdr options))))
        (assert-option-values option-table-values option-values)
        (concatenate 'string
                     (format nil "~(~a~) ~{~a ~}" option option-values)
                     (opt2cmd (subseq options (+ 1 (length option-values)))))))))

(defun make-aws-command (service command &rest options)
  (format nil "aws ~a ~a ~a"
          (string-downcase (symbol-name service))
          (string-downcase (symbol-name command))
          (if options
              (opt2cmd options)
              "")))

(defun valudation-service (service)
  (unless (servicep service)
    (error "not supported service. service=~a" service)))

(defvar *print-command-stream* t)

(defun aws (service command &rest options)
  (assert (servicep service))
  (let ((cmd (apply #'make-aws-command service command options)))
    (when *print-command-stream*
      (format *print-command-stream* "~a~%" cmd))
    (multiple-value-bind (values output error-output exit-status)
        (trivial-shell:shell-command cmd)
      (declare (ignore output error-output exit-status))
      (jojo:parse values))))
