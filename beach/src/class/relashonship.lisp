(in-package :aws-beach)

;;;
;;; TODO: relashonship は全部で一つで良い気もする。最初は丁寧に分けてみたけど、、、
;;;
(defclass r-aws2commands (ra)
  ((stroke :accessor stroke
           :initarg :stroke
           :initform '(:color (:r 204 :g 204 :b 204 :a 1) :width 3))))

(defclass r-aws2options (ra)
  ((stroke :accessor stroke
           :initarg :stroke
           :initform '(:color (:r 204 :g 204 :b 204 :a 1) :width 2))))

(defclass r-command2subcommands (ra)
  ((stroke :accessor stroke
           :initarg :stroke
           :initform '(:color (:r 204 :g 204 :b 204 :a 1) :width 1))))

(defclass r-subcommand2options (ra)
  ((option-type :accessor option-type :initarg :option-type :initform :require)
   (value-types :accessor value-types :initarg :value-types :initform nil)
   (attributes  :accessor attributes  :initarg :attributes  :initform nil)
   (stroke      :accessor stroke
                :initarg :stroke
                :initform '(:color (:r 204 :g 204 :b 204 :a 1) :width 1))))

(defmethod jojo:%to-json ((obj r-aws2commands))
  (jojo:with-object
    (jojo:write-key-value "_id"     (slot-value obj 'up:%id))
    (jojo:write-key-value "from-id" (slot-value obj 'shinra:from-id))
    (jojo:write-key-value "to-id"   (slot-value obj 'shinra:to-id))
    (jojo:write-key-value "stroke"  (slot-value obj 'stroke))))

(defmethod jojo:%to-json ((obj r-aws2options))
  (jojo:with-object
    (jojo:write-key-value "_id"     (slot-value obj 'up:%id))
    (jojo:write-key-value "from-id" (slot-value obj 'shinra:from-id))
    (jojo:write-key-value "to-id"   (slot-value obj 'shinra:to-id))
    (jojo:write-key-value "stroke"  (slot-value obj 'stroke))))

(defmethod jojo:%to-json ((obj r-command2subcommands))
  (jojo:with-object
    (jojo:write-key-value "_id"     (slot-value obj 'up:%id))
    (jojo:write-key-value "from-id" (slot-value obj 'shinra:from-id))
    (jojo:write-key-value "to-id"   (slot-value obj 'shinra:to-id))
    (jojo:write-key-value "stroke"  (slot-value obj 'stroke))))

(defmethod jojo:%to-json ((obj r-subcommand2options))
  (jojo:with-object
    (jojo:write-key-value "_id"         (slot-value obj 'up:%id))
    (jojo:write-key-value "from-id"     (slot-value obj 'shinra:from-id))
    (jojo:write-key-value "to-id"       (slot-value obj 'shinra:to-id))
    (jojo:write-key-value "option-type" (slot-value obj 'option-type))
    (jojo:write-key-value "value-types" (slot-value obj 'value-types))
    (jojo:write-key-value "attributes"  (slot-value obj 'attributes))
    (jojo:write-key-value "stroke"  (slot-value obj 'stroke))))
