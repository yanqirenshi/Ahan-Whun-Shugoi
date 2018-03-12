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

(defclass metric-filter ()
  ((filter-name :accessor filter-name :initarg :filter-name :initform nil)
   (filter-pattern :accessor filter-pattern :initarg :filter-pattern :initform nil)
   (metric-transformations :accessor metric-transformations :initarg :metric-transformations :initform nil)
   (log-group-name :accessor log-group-name :initarg :log-group-name :initform nil)
   (creation-time :accessor creation-time :initarg :creation-time :initform nil)))
