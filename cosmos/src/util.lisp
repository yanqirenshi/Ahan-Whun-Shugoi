(in-package :aws.cosmos)

(defun make-dimensions (plist)
  (mapcar #'(lambda (dim)
              (list :name (getf dim :|Name|)
                    :value (getf dim :|Value|)))
          (getf plist :|Dimensions|)))

(defun unix-time2timestamp (unix-time)
  (when unix-time
    (local-time:unix-to-timestamp (floor unix-time 10000))))
