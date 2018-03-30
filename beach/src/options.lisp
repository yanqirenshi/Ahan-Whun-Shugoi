(in-package :aws-beach)

;;;
;;; DB(shinra)
;;;
(defun get-option (&key code (graph *graph*))
  (car (find-vertex graph
                    'option
                    :slot 'code
                    :value code)))

(defun tx-make-option (graph plist)
  (when plist
    (let* ((code (ensure-keyword (getf plist :code)))
           (option (get-option :code code :graph graph))
           (slot-values `((code ,code))))
      (if (null option)
          (tx-make-vertex graph 'option slot-values)
          (up:tx-change-object-slots graph 'option (up:%id option) slot-values)))))

(defun tx-make-r-subcommand-option (graph subcommand option option-data)
  (tx-make-edge graph 'r-subcommand2options
                subcommand option :r
                `((option-type ,(if (getf option-data :require) :required :optional))
                  (value-types ,(getf option-data :value-types))
                  (attributes  ,(getf option-data :attributes)))))

(defun tx-add-option (graph subcommand option-data)
  "subcommand に option を追加します。
option は存在しない場合は新設されます。"
  (let ((option (tx-make-option graph option-data)))
    (tx-make-r-subcommand-option graph subcommand option option-data)))

;;;
;;; ADD-OPTIONS
;;;
(defun add-options (subcommand options)
  (dolist (option-data options)
    (up:execute-transaction
     (tx-add-option *graph* subcommand option-data))))
