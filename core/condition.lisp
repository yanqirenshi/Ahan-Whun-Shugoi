(in-package :ahan-whun-shugoi)

(define-condition aws-cli-error (simple-error)
  ((command     :initarg :command     :initform nil :reader aws-cli-error-command)
   (code        :initarg :code        :initform nil :reader aws-cli-error-code)
   (output      :initarg :output      :initform nil :reader aws-cli-error-output)
   (exit-status :initarg :exit-status :initform nil :reader aws-cli-error-exit-status)
   (values      :initarg :values      :initform nil :reader aws-cli-error-values))
  (:report (lambda (condition stream)
             (format stream
                     (concatenate 'string
                      "# command~%"      " ~a~%"
                      "# error-output~%" " ~a~%"
                      "# output~%"       " ~a~%"
                      "# exit-status~%"  " ~a~%"
                      "# values~%"       " ~a~%")
                     (aws-cli-error-command condition)
                     (aws-cli-error-code condition)
                     (aws-cli-error-output condition)
                     (aws-cli-error-exit-status condition)
                     (aws-cli-error-values condition)))))

(defun aws-faild (cmd values output error-output exit-status)
  "aws cli 実行時エラー時の情報を出力する。"
  (error (make-condition 'aws-cli-error
                         :command cmd
                         :code error-output
                         :output output
                         :exit-status exit-status
                         :values values)))
