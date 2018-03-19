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
  "TODO: あれ、これマズくない？ 値無しの option があった場合正しく動かないな。
plist -> alist に変換してとかかな。"
  (let ((aws-options (copy-list options))
        (other-options nil))
    (setf other-options
          (list :test (getf options :test)
                :format (getf options :format)
                :force (getf options :force)))
    (remf aws-options :test)
    (remf aws-options :force )
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
(defun aws-submit-mode (cmd)
  (restart-case
      (multiple-value-bind (values output error-output exit-status)
          (trivial-shell:shell-command cmd)
        (if (/= 0 error-output)
            (aws-faild values output error-output exit-status)
            values))
    (retry-aws-submit-mode ()
      (aws-submit-mode cmd))))

;;;
;;; format response values
;;;
(defun values2objects (command subcommand values)
  (declare (ignore command subcommand))
  (warn "format :object は実装中です。:json として処理します。")
  values)

(defun format-values (command subcommand values &optional (format :plist))
  (cond ((or (null format)
             (eq :plist format))
         (jojo:parse values))
        ((eq :json format) values)
        ((eq :object format) (values2objects command subcommand values))
        (t (error "この format は対応していません。format=~S" format))))

;;;
;;; AWS CLI main
;;;
(defun aws (command subcommand &rest options)
  (multiple-value-bind (aws-options other-options)
      (split-options options)
    (let ((cmd (make-aws-cli-command command subcommand aws-options
                                     :force (getf other-options :force))))
      (aws-print-command cmd)
      (cond ((getf other-options :test) (aws-test-mode))
            ((getf other-options :help) (warn ":help は実装中です。処理をスキップします。"))
            (t (format-values command subcommand
                              (aws-submit-mode cmd)
                              (getf other-options :format)))))))
