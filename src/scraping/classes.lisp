(in-package :ahan-whun-shugoi.scraping)

(defclass aws (shin)
  ((code        :accessor code        :initarg :code        :initform nil)
   (description :accessor description :initarg :description :initform nil)
   (synopsis    :accessor synopsis    :initarg :synopsis    :initform nil)
   (options     :accessor options     :initarg :options     :initform nil)
   (uri         :accessor uri         :initarg :uri         :initform nil)))

;; aws --> command
;;     --> options
(defclass command (shin)
  ((code        :accessor code        :initarg :code        :initform nil)
   (description :accessor description :initarg :description :initform nil)
   (uri         :accessor uri         :initarg :uri         :initform nil)))

;; command --> subcommands
;;         --> options
(defclass subcommand (shin)
  ((code        :accessor code        :initarg :code        :initform nil)
   (description :accessor description :initarg :description :initform nil)
   (synopsis    :accessor synopsis    :initarg :synopsis    :initform nil)
   (examples    :accessor examples    :initarg :examples    :initform nil)
   (output      :accessor output      :initarg :output      :initform nil)
   (uri         :accessor uri         :initarg :uri         :initform nil)))

(defclass option (shin)
  ((code        :accessor code        :initarg :code        :initform nil)
   (description :accessor description :initarg :description :initform nil)))

(defclass r-aws2commands (ra) ())
(defclass r-aws2options (ra) ())
(defclass r-command2subcommands (ra) ())
(defclass r-subcommand2options (ra)
  ((option-type :accessor option-type :initarg :option-type :initform :require)
   (value-types :accessor value-types :initarg :value-types :initform nil)
   (attributes  :accessor attributes  :initarg :attributes  :initform nil)))
