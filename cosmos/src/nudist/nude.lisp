(in-package :ahan-whun-shugoi.cosmos.nudist)

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
      (nconc (list (make-keyword (string-upcase (symbol-name (first key-val))))
                   (second key-val))
             (plist2plist (subseq plist 2))))))

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

(defun plist2object (class columns plist)
  (up:execute-transaction
   (shinra:tx-make-vertex *graph* class
                          (plist2object-slot-values plist columns))))

(defun plists2objects (class columns plists)
  (alexandria:when-let ((plist (car plists)))
    (cons (plist2object class columns plist)
          (plists2objects class columns (cdr plists)))))
