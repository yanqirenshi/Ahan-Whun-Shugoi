(in-package :aws.cosmos)

(defclass node (shinrabanshou:shin)
  ((location :accessor location :initarg :location :initform '(:x 0 :y 0 :z 0))))
