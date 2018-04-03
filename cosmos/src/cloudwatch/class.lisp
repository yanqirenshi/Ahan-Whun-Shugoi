(in-package :aws.cosmos)

(defclass metrics ()
  ((metric-name :accessor metric-name
                :initarg :metric-name
                :initform nil
                :type 'string)
   (namespace :accessor namespace
              :initarg :namespace
              :initform nil
              :type 'string)
   (dimensions :accessor dimensions
               :initarg :dimensions
               :initform nil
               :type 'plist)))

(defclass metric-alarm ()
  ((metric-name :accessor metric-name :initarg :metric-name :initform nil)
   (actions-enabled :accessor actions-enabled :initarg :actions-enabled :initform nil)
   (ok-actions :accessor ok-actions :initarg :ok-actions :initform nil)
   (insufficient-data-actions :accessor insufficient-data-actions :initarg :insufficient-data-actions :initform nil)
   (state-reason :accessor state-reason :initarg :state-reason :initform nil)
   (statistic :accessor statistic :initarg :statistic :initform nil)
   (dimensions :accessor dimensions :initarg :dimensions :initform nil)
   (alarm-name :accessor alarm-name :initarg :alarm-name :initform nil)
   (threshold :accessor threshold :initarg :threshold :initform nil)
   (state-value :accessor state-value :initarg :state-value :initform nil)
   (period :accessor period :initarg :period :initform nil)
   (state-reason-data :accessor state-reason-data :initarg :state-reason-data :initform nil)
   (namespace :accessor namespace :initarg :namespace :initform nil)
   (alarm-actions :accessor alarm-actions :initarg :alarm-actions :initform nil)
   (comparison-operator :accessor comparison-operator :initarg :comparison-operator :initform nil)
   (alarm-configuration-updated-timestamp :accessor alarm-configuration-updated-timestamp :initarg :alarm-configuration-updated-timestamp :initform nil)
   (state-updated-timestamp :accessor state-updated-timestamp :initarg :state-updated-timestamp :initform nil)
   (alarm-arn :accessor alarm-arn :initarg :alarm-arn :initform nil)
   (evaluation-periods :accessor evaluation-periods :initarg :evaluation-periods :initform nil)))

(defmethod jojo:%to-json ((obj metric-alarm))
  (jojo:with-object
    (jojo:write-key-value "metric-name" (slot-value obj 'metric-name))
    (jojo:write-key-value "actions-enabled" (slot-value obj 'actions-enabled))
    (jojo:write-key-value "ok-actions" (slot-value obj 'ok-actions))
    (jojo:write-key-value "insufficient-data-actions" (slot-value obj 'insufficient-data-actions))
    (jojo:write-key-value "state-reason" (slot-value obj 'state-reason))
    (jojo:write-key-value "statistic" (slot-value obj 'statistic))
    (jojo:write-key-value "dimensions" (slot-value obj 'dimensions))
    (jojo:write-key-value "alarm-name" (slot-value obj 'alarm-name))
    (jojo:write-key-value "threshold" (slot-value obj 'threshold))
    (jojo:write-key-value "state-value" (slot-value obj 'state-value))
    (jojo:write-key-value "period" (slot-value obj 'period))
    ;; TODO: timestamp が対処出来ていない。
    ;; (jojo:write-key-value "state-reason-data" (slot-value obj 'state-reason-data))
    (jojo:write-key-value "namespace" (slot-value obj 'namespace))
    (jojo:write-key-value "alarm-actions" (slot-value obj 'alarm-actions))
    (jojo:write-key-value "comparison-operator" (slot-value obj 'comparison-operator))
    (jojo:write-key-value "alarm-configuration-updated-timestamp" (slot-value obj 'alarm-configuration-updated-timestamp))
    (jojo:write-key-value "state-updated-timestamp" (slot-value obj 'state-updated-timestamp))
    (jojo:write-key-value "alarm-arn" (slot-value obj 'alarm-arn))
    (jojo:write-key-value "evaluation-periods" (slot-value obj 'evaluation-periods))))
