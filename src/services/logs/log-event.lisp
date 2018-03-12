(in-package :ahan-whun-shugoi)

(defun unix-time2timestamp (unix-time)
  (when unix-time
    (local-time:unix-to-timestamp (floor unix-time 10000))))

(defun plist2log-event (plist)
  (make-instance 'log-event
                 :log-stream-name (getf plist :|logStreamName|)
                 :event-id (getf plist :|eventId|)
                 :message (getf plist :|message|)
                 :timestamp (unix-time2timestamp (getf plist :|timestamp|))
                 :ingestion-time (unix-time2timestamp (getf plist :|ingestionTime|))))
