(in-package :aws.beach)

(defclass node (shin)
  ((x :accessor x :initarg :x :initform 0)
   (y :accessor y :initarg :y :initform 0)
   (z :accessor z :initarg :z :initform 0)))

(defclass sand (node)
  ((code        :accessor code        :initarg :code        :initform nil)
   (description :accessor description :initarg :description :initform nil)))
