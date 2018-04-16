(in-package :aws.beach)

(defclass finder (shin)
  ((code    :accessor code    :initarg :code    :initform nil)
   (look-at :accessor look-at :initarg :look-at :initform '(:x 0 :y 0 :z 0))
   (scale   :accessor scale   :initarg :scale   :initform 1.0))
  (:documentation ""))

(defmethod jojo:%to-json ((obj finder))
  (jojo:with-object
    (jojo:write-key-value "_id"         (slot-value obj 'up:%id))
    (jojo:write-key-value "code"        (slot-value obj 'code))
    (jojo:write-key-value "look-at"     (slot-value obj 'look-at))
    (jojo:write-key-value "scale"       (slot-value obj 'scale))
    (jojo:write-key-value "_class" "FINDER")))

(defun get-finder (&key code)
  (assert code)
  (car (shinra:find-vertex *graph* 'finder :slot 'code :value code)))

(defun tx-make-finder (graph code &key (look-at '(:x 0 :y 0 :z 0)) (scale 1.0))
  (assert (not (get-finder :code code))
          (code) "Aledy exist finder. code=~a" code)
  (shinra:tx-make-vertex graph
                         'finder
                         `((code ,code)
                           (look-at ,look-at)
                           (scale ,scale))))

(defun find-finder ()
  (shinra:find-vertex *graph* 'finder))
