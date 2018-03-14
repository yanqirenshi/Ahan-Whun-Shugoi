(in-package :aws.beach)

;;;
;;; TODO: relashonship は全部で一つで良い気もする。最初は丁寧に分けてみたけど、、、
;;;
(defclass r-aws2commands (ra) ())
(defclass r-aws2options (ra) ())
(defclass r-command2subcommands (ra) ())
(defclass r-subcommand2options (ra)
  ((option-type :accessor option-type :initarg :option-type :initform :require)
   (value-types :accessor value-types :initarg :value-types :initform nil)
   (attributes  :accessor attributes  :initarg :attributes  :initform nil)))
