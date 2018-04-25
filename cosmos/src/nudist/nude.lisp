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

(defun tags2plists (tags)
  (when-let ((tag (car tags)))
    (let ((key (getf tag :|Key|))
          (value (getf tag :|Value|)))
      (nconc (list (make-keyword (string-upcase key))
                   value)
             (tags2plists (cdr tags))))))

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

(defun %plist2object (class columns plist)
  (let* ((primary (find-if #'(lambda (c) (getf c :primary)) columns))
         (primary-slot (getf primary :slot))
         (key (getf primary :code)))
    (or (shinra:find-vertex *graph* class
                            :slot primary-slot
                            :value (getf plist key))
        (up:execute-transaction
         (shinra:tx-make-vertex *graph* class
                                (plist2object-slot-values plist columns))))))

(defun relationship-data (plists)
  (when-let ((plist (car plists)))
    (if (not (null (getf plist :slot)))
       (relationship-data (cdr plists))
       (cons plist
             (relationship-data (cdr plists))))))

(defun plist2object (class columns plist)
  (let ((node (%plist2object class columns plist))
        (r-cols (relationship-data columns)))
    (dolist (r-col r-cols)
      (dolist (data (funcall (getf r-col :set-value) plist (getf r-col :code)))
        (let ((node (getf data :node))
              (edge (getf data :edge)))
          ;; TODO: make node & edge
          ;; (print (list node edge))
          (declare (ignore node edge))
          )))
    node))

(defun plists2objects (class columns plists)
  (when-let ((plist (car plists)))
    (cons (plist2object class columns plist)
          (plists2objects class columns (cdr plists)))))
