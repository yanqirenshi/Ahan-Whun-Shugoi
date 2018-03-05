(in-package :ahan-whun-shugoi)

(defvar *commands*
  `((:s3 ,(cmds-s3))
    (:ec2 ,(cmds-ec2))
    (:logs ,(cmds-logs))
    (:iam ,(cmds-iam))))

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
  '((:--profile 'string)
    (:--log-group-name 'string)
    (:--log-stream-name 'string)
    (:--filter-pattern 'string)
    (:test 'boolean)))

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
                     (if (eq :test option)
                         ""
                         (format nil "~(~a~) ~{\"~a\" ~}" option option-values))
                     (opt2cmd (subseq options (+ 1 (length option-values)))))))))

(defun assert-service (service)
  (unless (servicep service)
    (error "not supported service. service=~a" service)))

(defun assert-command (service command)
  (assert (list service command)))

(defun make-aws-command (service command &rest options)
  (format nil "aws ~a ~a ~a"
          (string-downcase (symbol-name service))
          (string-downcase (symbol-name command))
          (if options
              (opt2cmd options)
              "")))

(defvar *print-command-stream* t
  "実行するコマンドの出力先。
ストリームをセットする。
初期値は t(標準出力)。
nil にするとコマンドを出力しない。")

(defun aws-print-command (cmd)
  "実行するコマンドを出力する。"
  (when *print-command-stream*
    (format *print-command-stream* "Command⇒ ~a~%" cmd)))

(defun aws-faild (values output error-output exit-status)
  "aws cli 実行時エラー時の情報を出力する。"
  (format t "~%<error-output>~% ~a~%" error-output)
  (format t "<output>~% ~a~%" output)
  (format t "<exit-status>~% ~a~%~%" exit-status)
  (format t "<values>~% ~a~%" values))

(defun aws (service command &rest options)
  (assert (servicep service))
  (let ((cmd (apply #'make-aws-command service command options)))
    (aws-print-command cmd)
    (if (getf options :test)
        ;; test mode
        (format t "Skipt Submit(test-mode).~%" )
        ;; normal mode
        (multiple-value-bind (values output error-output exit-status)
            (trivial-shell:shell-command cmd)
          (if (= 0 error-output)
              (jojo:parse values)
              (aws-faild values output error-output exit-status))))))
