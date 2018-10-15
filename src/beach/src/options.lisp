(in-package :aws.beach)

;;;
;;; DB(shinra)
;;;
(defun get-option (&key %id code (graph *graph*))
  (cond (%id (shinra:get-vertex-at graph 'option :%id %id))
        (code (car (find-vertex graph
                                'option
                                :slot 'code
                                :value code)))))

(defun make-option-slot-values (option-data)
  (let ((code (ensure-keyword (getf option-data :code)))
        (value-types (getf option-data :value-types))
        (values-org (list :synopsis (getf option-data :attributes)
                          :options (getf option-data :value-types)))
        (required (getf option-data :require)))
    `((code ,code)
      (value-types ,value-types)
      (values-org ,values-org)
      (required ,required))))

(defun tx-make-option (graph option-data)
  (when option-data
    (tx-make-vertex graph 'option
                    (make-option-slot-values option-data))))

(defun tx-update-option (graph option option-data)
  (up:tx-change-object-slots graph 'option
                             (up:%id option)
                             (make-option-slot-values option-data)))

(defun tx-make-r-subcommand-option (graph subcommand option)
  (tx-make-edge graph 'r-subcommand2options
                subcommand option :r))

(defun get-subcommand-option (graph subcommand option-code)
  (find-if #'(lambda (option)
               (eq (code option) option-code))
           (find-r-vertex graph 'r-subcommand2options :from subcommand)))

(defun tx-add-option (graph subcommand option-data)
  (let* ((option-code (ensure-keyword (getf option-data :code)))
         (option (get-subcommand-option graph subcommand option-code)))
    (if option
        (tx-update-option graph option option-data)
        (tx-make-r-subcommand-option graph
                                     subcommand
                                     (tx-make-option graph option-data)))))

;;;
;;; ADD-OPTIONS
;;;
(defun add-options (subcommand options)
  (dolist (option-data options)
    (up:execute-transaction
     (tx-add-option *graph* subcommand option-data))))


;;;
;;; Chek option
;;;
(defun options-values (option)
  (alexandria:ensure-list (value-types option)))
