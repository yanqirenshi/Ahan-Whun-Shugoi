(in-package :cl-user)
(defpackage ahan-whun-shugoi.cli.option
  (:nicknames :aws.cli.option)
  (:use #:cl
        #:aws.beach)
  (:import-from :ahan-whun-shugoi.cli.config
                #:get-config)
  (:export #:options2cmd-string))
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

(defun assert-option-values-length (option-code input-values master-values)
  (when (/= (length input-values)
            (length master-values))
    (error "オプションの値の個数が異なります。 code=~a, input=~S, master=~S"
           option-code input-values master-values)))

(defun check-option-values-type (input-value master-value)
  ;; TODO: add value type check
  (cond ((string= master-value "JSON") t)
        ((string= master-value "blob") t)
        ((string= master-value "boolean") t)
        ((string= master-value "double") t)
        ((string= master-value "float") t)
        ((or (string= master-value "int")
             (string= master-value "integer"))
         t)
        ((string= master-value "list") t)
        ((string= master-value "long") t)
        ((string= master-value "map") t)
        ((string= master-value "string") t)
        ((string= master-value "structure") t)
        ((string= master-value "timestamp") t)
        (t (error "なんじゃこりゃぁ!! input-value=~a, master-value=~a"
                  input-value master-value))))

(defun assert-option-values-type (option-code input-values master-values)
  (when input-values
    (check-option-values-type (car input-values)
                              (car master-values))
    (assert-option-values-type option-code
                               (cdr input-values)
                               (cdr master-values))))

(defun assert-option-values (option-code option-values option-master)
  "ここでは過去からの経緯でオプションの値が複数設定されることを想定しています。
そのため input-values と master-values はリスト構造になっています。
メモ:現在は「名前:値=1:1」なんじゃないかなと推察しているのでリスト構造にする必要はないのかもしれません。"
  (let ((input-values (alexandria:ensure-list option-values))
        (master-values (aws.beach:options-values option-master)))
    (if (eq :--profile option-code)
        (assert-option-value-at-profile option-code option-values)
        (progn (assert-option-values-length option-code input-values master-values)
               (assert-option-values-type option-code input-values master-values)))))

(defun option2cmd-string (option-code option-values)
  "オプションの名前と値をコマンド文字列に変換する。
名前:値=1:1を前提としています。"
  (if (or (eq :test option-code) ;; ahan-whun-shugoi のオプションのときは何もしない。
          (null (remove nil option-values))) ;; 値が nil のものは無視する。
      ""
      (format nil " ~(~a~) ~{~S~}" option-code option-values)))

(defun %options2cmd-string (options master)
  (when options
    (let* ((option-code (car options))
           (value-types-master (get-master-option master option-code)))
      (assert-option option-code value-types-master)
      (let* ((option (cdr options))
             (value-types (get-option-values option)))
        (assert-option-values option-code value-types value-types-master)
        (concatenate 'string
                     (option2cmd-string option-code value-types)
                     (%options2cmd-string (subseq options (+ 1 (length value-types)))
                                          master))))))

(defun options2cmd-string (options &key master)
  "options を aws コマンドの文字列に変換する。"
  (if (null options)
      ""
      (%options2cmd-string options master)))
