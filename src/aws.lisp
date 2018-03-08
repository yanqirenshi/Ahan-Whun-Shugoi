(in-package :ahan-whun-shugoi)

;;;
;;; Printer
;;;
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

;;;
;;; test mode
;;;
(defun aws-test-mode ()
  (format t "Skipt Submit(test-mode).~%" ))

;;;
;;; submit mode
;;;
(defun aws-submit-mode (cmd)
  (multiple-value-bind (values output error-output exit-status)
      (trivial-shell:shell-command cmd)
    (if (= 0 error-output)
        (jojo:parse values)
        (aws-faild values output error-output exit-status))))

;;;
;;; AWS CLI
;;;
(defun aws (service subcommand &rest options)
  (let* ((cmd (make-aws-cli-command service
                                    subcommand
                                    options)))
    (aws-print-command cmd)
    (if (getf options :test)
        (aws-test-mode)
        (aws-submit-mode cmd))))
