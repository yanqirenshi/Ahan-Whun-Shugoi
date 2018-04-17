(in-package :cl-user)
(defpackage ahan-whun-shugoi.cli.command
  (:nicknames :aws.cli.command)
  (:use #:cl
        #:aws.beach
        #:ahan-whun-shugoi.cli.option)
  (:export #:make-aws-cli-command))
(in-package :ahan-whun-shugoi.cli.command)

(defun get-master (command-code subcommand-code)
  (let* ((command (get-command :code command-code))
         (subcommand (get-command-subcommand command subcommand-code))
         (aws-options (find-aws-options (aws.beach:get-aws)))
         (comman-options (find-subcommand-options subcommand)))
    (assert command (command-code) "コマンド ~S は存在しません。" command-code)
    (assert subcommand (subcommand) "サブコマンド ~S は存在しません。" subcommand-code)
    (assert aws-options (aws-options) "サブコマンド ~S にオプションが存在しません。" subcommand)
    (values command subcommand (nconc aws-options comman-options))))

(defun get-code (obj &key to-str)
  "TODO:これは aws.beach のコードじゃないかな。"
  (let ((code (aws.beach::code obj)))
    (if (not to-str)
        code
        (string-downcase (symbol-name code)))))

(defun assert-lock-subcommand (subcommand force)
  (let ((lock (aws.beach:lock-p subcommand)))
    (assert (or (null lock)
                (and lock force))
            (subcommand)
            "このコマンド ~a は Lock されています。Lock を解除するか、:force オプションを追加して実行してください。"
            subcommand)))

(defun make-aws-cli-command (command-code subcommand-code options_in &key force)
  (multiple-value-bind (command subcommand options)
      (get-master command-code subcommand-code)
    (assert-lock-subcommand subcommand force)
    (format nil "aws ~a ~a~a"
            (get-code command :to-str t)
            (get-code subcommand :to-str t)
            (options2cmd-string options_in :master options))))
