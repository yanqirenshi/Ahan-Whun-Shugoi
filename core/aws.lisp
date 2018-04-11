(in-package :ahan-whun-shugoi)

(define-condition aws-command-timeout-error (simple-error)
  ((command     :initarg :command     :initform nil :reader aws-command-timeout-error-command)
   (code        :initarg :code        :initform nil :reader aws-command-timeout-error-code)
   (output      :initarg :output      :initform nil :reader aws-command-timeout-error-output)
   (exit-status :initarg :exit-status :initform nil :reader aws-command-timeout-error-exit-status)
   (values      :initarg :values      :initform nil :reader aws-command-timeout-error-values))
  (:report (lambda (condition stream)
             (format stream
                     (concatenate 'string
                      "# command~%"      " ~a~%"
                      "# error-output~%" " ~a~%"
                      "# output~%"       " ~a~%"
                      "# exit-status~%"  " ~a~%"
                      "# values~%"       " ~a~%")
                     (aws-command-timeout-error-command condition)
                     (aws-command-timeout-error-code condition)
                     (aws-command-timeout-error-output condition)
                     (aws-command-timeout-error-output condition)
                     (aws-command-timeout-error-exit-status condition)
                     (aws-command-timeout-error-values condition)))))

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

(defun aws-faild (cmd values output error-output exit-status)
  "aws cli 実行時エラー時の情報を出力する。"
  (let ((msg (concatenate 'string
                      "# error-output~%" " ~a~%"
                      "# output~%"       " ~a~%"
                      "# exit-status~%"  " ~a~%"
                      "# values~%"       " ~a~%")))
    (if (and (= 255 error-output)
             (string= "[Errno 54] Connection reset by peer"
                      (string-trim '(#\Space #\Tab #\Newline) output)))
        (error (make-condition 'aws-command-timeout-error
                               :command cmd
                               :code error-output
                               :output output
                               :exit-status exit-status
                               :values values))
        (error msg
               error-output
               output
               exit-status
               values))))

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
                :force (getf options :force)
                :thread (getf options :thread)
                :help (getf options :help)))
    (remf aws-options :test)
    (remf aws-options :force )
    (remf aws-options :format)
    (remf aws-options :thread)
    (remf aws-options :hepl)
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
        (cond ((and (= 255 error-output)
                    (string= "[Errno 54] Connection reset by peer"
                             (string-trim '(#\Space #\Tab #\Newline) output)))
               ;; TODO: timeout retry の応急処置。ほんとうはコンディションでやりたい。。。
               (progn (format t "Retry: ~a~%" cmd)
                      (aws-submit-mode cmd)))
              ((/= 0 error-output)
               (aws-faild cmd values output error-output exit-status))
              (t values)))
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
(defun aws-run (command subcommand cmd other-options)
  (aws-print-command cmd)
  (cond ((getf other-options :test) (aws-test-mode))
        (t (format-values command subcommand
                          (aws-submit-mode cmd)
                          (getf other-options :format)))))

(defvar *aws-thread-output* (make-hash-table :test 'equal))

(defun aws-run-thread (command subcommand cmd other-options)
  (let ((thread-name (format nil "aws-~a-~a_~a" command subcommand (local-time:now))))
    (bordeaux-threads:make-thread
     #'(lambda ()
         (let ((start (local-time:now)))
           (setf (gethash thread-name *aws-thread-output*)
                 (aws-run command subcommand cmd other-options))
           (break "完了しました。~%~6a= ~a~%~6a=~a~%"
                  "start" start
                  "end"   (local-time:now))))
     :name thread-name)))

(defun aws (command &optional subcommand &rest options)
  (cond ((eq :help command) (print-aws-help))
        ((eq :help subcommand) (print-command-help command))
        ((eq :help (car options)) (print-subcommand-help subcommand))
        (t (multiple-value-bind (aws-options other-options)
               (split-options options)
             (let ((cmd (make-aws-cli-command command subcommand aws-options
                                              :force (getf other-options :force))))
               (if (not (getf other-options :thread))
                   (aws-run command subcommand cmd other-options)
                   (aws-run-thread command subcommand cmd other-options)))))))
