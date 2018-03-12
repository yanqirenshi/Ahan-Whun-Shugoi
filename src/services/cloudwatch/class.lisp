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
