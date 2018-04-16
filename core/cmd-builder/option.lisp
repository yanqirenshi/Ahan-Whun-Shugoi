(in-package :cl-user)
(defpackage ahan-whun-shugoi.cli.option
  (:nicknames :aws.cli.option)
  (:use #:cl
        #:aws.beach)
  (:import-from :ahan-whun-shugoi.cli.config
                #:get-config)
  (:export #:opt2cmd))
(in-package :ahan-whun-shugoi.cli.option)


(defun get-option-values (options)
  "options から値を取得する。
 `(:key1 \"v1\" \"v2\" :key2 \"v3\" ...)` こんなリストだと `(\"v1\" \"v2\" :key2 \"v3\" ...)`が引数で渡される。"
  (let ((first-keyword-position (position-if (lambda (v) (keywordp v)) options)))
    (if (null first-keyword-position)
        options
        (subseq options 0 first-keyword-position))))

(defun assert-option-values (option-table-values option-values)
  (assert (= (length option-table-values)
             (length option-values))))

(defun get-master-option (master option-code)
  "option-code で master の中から option を探す。"
  (when master
    (let ((option (car master)))
      (if (eq option-code (aws.beach::code option))
          option
          (get-master-option (cdr master) option-code)))))

(defun assert-option-value-at-profile (option-code option-values)
  (let ((value (first option-values)))
    (assert (and (= 1 (length option-values))
                 (stringp value))
            (option-values) "値が変じゃない？ values=~S" option-values)
    (assert (get-config value)
            (option-code) "~S は存在しませんよ。" value)))

(defun assert-option (option-code option-master)
  (assert (keywordp option-code)
          (option-code)
          "option-code is not keyword. option-code= ~S" option-code)
  (assert option-master
          (option-code)
          "Cannot find master ~S." option-code))

(defun assert-option-values (option-code option-values)
  (cond ((eq :--profile option-code)
         (assert-option-value-at-profile option-code option-values))
        (t t)))

(defun option2cmd-string (option-code option-values)
  "オプションの名前と値をコマンド文字列に変換する。
TODO: 今のところ「名前:値=1:1」のみに対応。"
  (if (or (eq :test option-code) ;; ahan-whun-shugoi のオプションのときは何もしない。
          (null (remove nil option-values))) ;; 値が nil のものは無視する。
      ""
      (format nil " ~(~a~) ~{~S~}" option-code option-values)))

(defun %options2cmd-string (options master)
  (when options
    (let* ((option-code (car options))
           (option-master (get-master-option master option-code)))
      (assert-option option-code option-master)
      (let ((option-values (get-option-values (cdr options))))
        (assert-option-values option-code option-values)
        (concatenate 'string
                     (option2cmd-string option-code option-values)
                     (%options2cmd-string (subseq options (+ 1 (length option-values)))
                                          master))))))

(defun opt2cmd (options &key master)
  "options を aws コマンドの文字列に変換する。"
  (if (null options)
      ""
      (%options2cmd-string options master)))
