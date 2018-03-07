(in-package :ahan-whun-shugoi.scraping)

;;;
;;; DB(shinra)
;;;
(defun get-option (&key code)
  (car (find-vertex *graph*
                    'option
                    :slot 'code
                    :value code)))

(defun tx-update-option (graph option plist)
  (declare (ignore plist graph))
  option)

(defun tx-make-option (graph plist)
  "plist から option クラスインスタンスを作成する。
すでに存在する場合は更新する。
 plist ::= (:code ... :value-types (...) :attributes (...) :require)
"
  (when plist
    (let* ((code (ensure-keyword (getf plist :code)))
           (option (get-option :code code)))
      (if option
          (tx-update-option graph option plist)
          (tx-make-vertex graph
                          'option
                          `((code ,code)))))))

(defun tx-make-r-command-option (graph command option option-data)
  (print option-data)
  (shinra:tx-make-edge graph 'r-command2options command option :r
                       `((option-type ,(if (getf option-data :require) :required :optional))
                         (value-types ,(getf option-data :value-types))
                         (attributes  ,(getf option-data :attributes)))))

(defun tx-add-option (graph command option-data)
  "command に option を追加します。
option は存在しない場合は新設されます。"
  (let ((option (tx-make-option graph option-data)))
    (tx-make-r-command-option graph command option option-data)))

;;;
;;; ADD-OPTIONS
;;;
(defun add-options (command options)
  (dolist (option-data options)
    (up:execute-transaction
     (tx-add-option *graph* command option-data))))
