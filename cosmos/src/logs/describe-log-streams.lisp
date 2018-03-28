(in-package :aws.cosmos)

;; '(:|storedBytes| 77591518
;;   :|arn| "arn:aws:logs:ap-northeast-1:224455897222:log-group:/tatta-production/web/access.log:log-stream:i-041e8faeecdef8e83"
;;   :|lastIngestionTime| 1520918506481
;;   :|logStreamName| "i-041e8faeecdef8e83"
;;   :|uploadSequenceToken| "49579857578985126101169492599136357871630204350872176578"
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
