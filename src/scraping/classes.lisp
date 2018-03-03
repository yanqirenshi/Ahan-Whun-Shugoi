(in-package :ahan-whun-shugoi.scraping)

(defclass aws (shin)
  ((code        :accessor code        :initarg :code        :initform nil)
   (description :accessor description :initarg :description :initform nil)
   (synopsis    :accessor synopsis    :initarg :synopsis    :initform nil)
   (options     :accessor options     :initarg :options     :initform nil)
   (uri         :accessor uri         :initarg :uri         :initform nil)))

;; aws --> services
;;     --> options
(defclass service (shin)
  ((code        :accessor code        :initarg :code        :initform nil)
   (description :accessor description :initarg :description :initform nil)
   (uri         :accessor uri         :initarg :uri         :initform nil)))

;; service --> commands
;;         --> options
(defclass command (shin)
  ((code        :accessor code        :initarg :code        :initform nil)
   (description :accessor description :initarg :description :initform nil)
   (synopsis    :accessor synopsis    :initarg :synopsis    :initform nil)
   (examples    :accessor examples    :initarg :examples    :initform nil)
   (output      :accessor output      :initarg :output      :initform nil)
   (uri         :accessor uri         :initarg :uri         :initform nil)))

(defclass option (shin)
  ((code        :accessor code        :initarg :code        :initform nil)
   (description :accessor description :initarg :description :initform nil)))

(defclass r-services (ra) ())
(defclass r-commands (ra) ())
(defclass r-options  (ra) ())
