(in-package :aws.cosmos)

;; '(:|storedBytes| 77591518
;;   :|arn| ""
;;   :|lastIngestionTime| 1520918506481
;;   :|logStreamName| ""
;;   :|uploadSequenceToken| ""
;;   :|creationTime| 1519889691452
;;   :|lastEventTimestamp| 1520917488000
;;   :|firstEventTimestamp| 1519889684000)

(defun plist2log-streams (plist)
  (make-instance 'log-stream
                 :arn                   (getf plist :|arn|)
                 :log-stream-name       (getf plist :|logStreamName|)
                 :upload-sequence-token (getf plist :|uploadSequenceToken|)
                 :stored-bytes          (getf plist :|storedBytes|)
                 :last-ingestion-time   (getf plist :|lastIngestionTime|)
                 :creation-time         (getf plist :|creationTime|)
                 :last-event-timestamp  (getf plist :|lastEventTimestamp|)
                 :first-event-timestamp (getf plist :|firstEventTimestamp|)))

(defun plists2log-streams (plists)
  (mapcar #'plist2log-streams (getf plists :|logStreams|)))
