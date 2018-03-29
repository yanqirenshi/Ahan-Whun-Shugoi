(in-package :aws-beach)

(defclass finder (shinra)
  ((look-at :accessor look-at :initarg :look-at :initform '(:x 0 :y 0 :z 0))
   (scale :accessor scale :initarg :scale :initform 1.0))
  (:documentation ""))
