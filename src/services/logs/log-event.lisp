(in-package :ahan-whun-shugoi)

(defclass log-event ()
  ((log-stream-name :accessor log-stream-name
                    :initarg :log-stream-name
                    :initform nil)
   (event-id :accessor event-id
             :initarg :event-id
             :initform nil)
   (message :accessor message
            :initarg :message
            :initform nil)
   (timestamp :accessor timestamp
              :initarg :timestamp
              :initform nil)
   (ingestion-time :accessor ingestion-time
                   :initarg :ingestion-time
                   :initform nil)))

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
