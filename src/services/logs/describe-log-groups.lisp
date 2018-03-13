(in-package :ahan-whun-shugoi)

;; https://docs.aws.amazon.com/cli/latest/reference/logs/describe-log-groups.html

;; こんな感じで add していくか。。。。
;; (add-plist2log-group :aws :logs :describe-log-groups (:plist-key :|logGroups| :plist2log-group))

(defun plist2log-group (plist)
  (make-instance 'log-group
                 :arn (getf plist :|arn|)
                 :retention-in-days (getf plist :|retentionInDays|)
                 :log-group-name (getf plist :|logGroupName|)
                 :creation-time (getf plist :|creationTime|)
                 :metric-filter-count (getf plist :|metricFilterCount|)
                 :stored-bytes (getf plist :|storedBytes|)))

(defun plist2log-groups (plist)
  (when plist
    (assert (eq :|logGroups| (car plist)))
    (mapcar #'plist2log-group (cadr plist))))
