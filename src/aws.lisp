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
;;; split-options
;;;
(defun split-options (options)
  (let ((aws-options (copy-list options))
        (other-options nil))
    (setf other-options
          (list :test (getf options :test)
                :format (getf options :format)))
    (remf aws-options :test)
    (remf aws-options :format)
    (values aws-options other-options)))

;;;
;;; test mode
;;;
(defun aws-test-mode ()
  (format t "Skipt Submit(test-mode).~%" ))

;;;
;;; submit mode
;;;
(defun aws-submit-mode (cmd &key (format :plist))
  (multiple-value-bind (values output error-output exit-status)
      (trivial-shell:shell-command cmd)
    (if (/= 0 error-output)
        (aws-faild values output error-output exit-status)
        (cond ((eq :json format) values)
              ((eq :plist format) (jojo:parse values))
              ;;((eq :object format) (jojo:parse values))
              (t (error "この format は対応していません。format=~S" format))))))

;;;
;;; AWS CLI
;;;
(defun aws (command subcommand &rest options)
  (multiple-value-bind (aws-options other-options)
      (split-options options)
    (let ((cmd (make-aws-cli-command command subcommand aws-options)))
      (aws-print-command cmd)
      (if (getf other-options :test)
          (aws-test-mode)
          (aws-submit-mode cmd)))))
