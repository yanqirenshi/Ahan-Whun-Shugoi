(in-package :ahan-whun-shugoi.scraping)

;;;
;;; DB(shinra)
;;;
(defun get-option (&key code)
  (car (shinra:find-vertex *graph*
                           'option
                           :slot 'code
                           :value code)))

(defun tx-update-option (graph option plist)
  (declare (ignore plist graph))
  option)

(defun tx-make-option (graph plist)
  (when plist
    (let* ((code (ensure-keyword (getf plist :code)))
           (option (get-option :code code)))
      (if option
          (tx-update-option graph option plist)
          (tx-make-vertex graph
                          'option
                          `((code ,code)))))))

(defun tx-make-r-command-option (graph command option)
  (shinra:tx-make-edge graph 'r-options command option :r))

(defun tx-add-option (graph command option-data)
  (let ((option (tx-make-option graph option-data)))
    (tx-make-r-command-option graph command option)))

;;;
;;; ADD-OPTIONS
;;;
(defun add-options (command options)
  (dolist (option-data options)
    (up:execute-transaction
     (tx-add-option *graph* command option-data))))
