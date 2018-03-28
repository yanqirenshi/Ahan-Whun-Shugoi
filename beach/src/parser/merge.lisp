(in-package :aws-beach)

;;;
;;; merge-synopsis&options
;;;
(defun squeeze-code (plists)
  (when plists
    (let ((plist (car plists)))
      (cons (getf plist :code)
            (squeeze-code (cdr plists))))))

(defun make-code-lsit (synopsis options)
  (remove-duplicates (merge 'list
                            (squeeze-code synopsis)
                            (squeeze-code options)
                            #'string<)
                     :test 'equal))

(defun get-plist-rec-at-code (code plists)
  (find-if #'(lambda (plist)
               (string= code (getf plist :code)))
           plists))

(defun %merge-synopsis&options (code-list synopsis options)
  (when code-list
    (let* ((code (car code-list))
           (synopsis-data (get-plist-rec-at-code code synopsis))
           (options-data (get-plist-rec-at-code code options)))
      (if (not (and synopsis-data options-data))
          (%merge-synopsis&options (cdr code-list) synopsis options)
          (cons (list :code        (ensure-keyword (getf options-data :code))
                      :value-types (getf options-data :value-types)
                      :attributes  (getf synopsis-data :attributes)
                      :require     (getf synopsis-data :require))
                (%merge-synopsis&options (cdr code-list) synopsis options))))))

(defun merge-synopsis&options (synopsis options)
  (%merge-synopsis&options (make-code-lsit synopsis options)
                           synopsis
                           options))
