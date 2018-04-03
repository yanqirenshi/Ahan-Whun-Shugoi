(in-package :aws.cosmos)

(defun make-dimensions (plist)
  (mapcar #'(lambda (dim)
              (list :name (getf dim :|Name|)
                    :value (getf dim :|Value|)))
          (getf plist :|Dimensions|)))

(defun unix-time2timestamp (unix-time)
  (when unix-time
    (local-time:unix-to-timestamp (floor unix-time 10000))))


;;;;
;;;; results 2 object utilities
;;;;
(defun tags2ht (plists &key (ht (make-hash-table :test 'equal)))
  (if (null plists)
      ht
      (let* ((plist (car plists))
             (key (getf plist :|Key|))
             (value (getf plist :|Value|)))
        (setf (gethash key ht) value)
        (tags2ht (cdr plists) :ht ht))))

(defun tags2alist (plists)
  (when plists
    (let* ((plist (car plists))
           (key (getf plist :|Key|))
           (value (getf plist :|Value|)))
      (cons (cons key value)
            (tags2alist (cdr plists))))))

(defun plist2plist (plist)
  (when plist
    (let ((key-val (subseq plist 0 2)))
      (nconc (list (alexandria:make-keyword (string-upcase (symbol-name (first key-val))))
                   (second key-val))
             (plist2plist (subseq plist 2))))))

(defun set-value-ignore (plist key)
  (declare (ignore plist key)))

(defun set-value-simple (plist indicator)
  (getf plist indicator))

(defun set-value-tags2alist (plist indicator)
  (tags2alist (getf plist indicator)))

(defun set-value-plist2plist (plist indicator)
  (plist2plist (getf plist indicator)))

(defun plist2object-slot-values (plist columns)
  (when columns
    (let* ((col (car columns))
           (indicator (getf col :code))
           (slot (getf col :slot))
           (get-value (getf col :set-value))
           (value (funcall get-value plist indicator)))
      (if (null slot)
          (plist2object-slot-values plist (cdr columns))
          (cons (list slot value)
                (plist2object-slot-values plist (cdr columns)))))))

;; (defun plist2object (class columns plist)
;;   (up:execute-transaction
;;    (shinra:tx-make-vertex aws.db:*graph* class
;;                           (plist2object-slot-values plist columns))))
