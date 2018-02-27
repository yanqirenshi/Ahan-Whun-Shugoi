(in-package :ahan-whun-shugoi.scraping)

;;;
;;; class
;;;
(defclass aws (shin)
  ((code :accessor code
         :initarg :code
         :initform nil)
   (synopsis :accessor synopsis
             :initarg :synopsis
             :initform nil)
   (uri :accessor uri
        :initarg :uri
        :initform nil)
   (description :accessor description
                :initarg :description
                :initform nil)))

;; aws --> services
;;     --> options
(defclass service (shin)
  ((code :accessor code
         :initarg :code
         :initform nil)
   (uri :accessor uri
         :initarg :uri
         :initform nil)
   (description :accessor description
                :initarg :description
                :initform nil)))

;; service --> commands
;;         --> options
(defclass command (shin)
  (description synopsis examples output))

(defclass option (shin)
  (description))

(defclass r-services (ra) ())
(defclass r-commands (ra) ())
(defclass r-options (ra) ())
