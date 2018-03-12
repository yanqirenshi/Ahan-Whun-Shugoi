(in-package :ahan-whun-shugoi)

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
