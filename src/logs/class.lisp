(in-package :ahan-whun-shugoi)

;; '(:|logGroups|
;;   ((:|storedBytes| {integer}
;;     :|logGroupName| "..."
;;     :|metricFilterCount| {integer}
;;     :|creationTime| {integer}
;;     :|arn| "...")))

(defclass log-group ()
  ((stored-bytes :accessor stored-bytes
                 :initarg :stored-bytes
                 :initform nil)
   (log-group-name :accessor log-group-name
                   :initarg :log-group-name
                   :initform nil)
   (metric-filter-count :accessor metric-filter-count
                        :initarg :metric-filter-count
                        :initform nil)
   (creation-time :accessor :creation-time
                  :initarg :creation-time
                  :initform nil)
   (arn :accessor arn
        :initarg :arn
        :initform nil)))

(defun plist2log-group (plist)
  (print plist)
  (make-instance 'log-group
                 :stored-bytes (getf plist :|storedBytes|)
                 :log-group-name (getf plist :|logGroupName|)
                 :metric-filter-count (getf plist :|metricFilterCount|)
                 :creation-time (getf plist :|creationTime|)
                 :arn (getf plist :|arn|)))

(defun plist2log-groups (plist)
  (when plist
    (assert (eq :|logGroups| (car plist)))
    (mapcar #'plist2log-group (cadr plist))))
