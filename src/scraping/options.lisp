(in-package :ahan-whun-shugoi.scraping)

(defun get-option (&key code)
  (car (shinra:find-vertex *graph* 'option
                           :slot 'code
                           :value code)))

(defun update-option (option plist)
  (declare (ignore plist))
  option)

(defun make-option (plist)
  (when plist
    (let* ((code (getf plist :code))
           (option (get-option :code code)))
      (if option
          (update-option option plist)
          (execute-transaction
           (tx-make-vertex *graph*
                           'option
                           `((code ,code))))))))

(defun make-r-command-option (command option)
  (execute-transaction
   (shinra:tx-make-edge *graph* 'r-options command option :r)))

(defun find-options (aws service command options)
  (declare (ignore aws service))
  (dolist (option-data options)
    (let ((option (make-option option-data)))
      (make-r-command-option command option))))
