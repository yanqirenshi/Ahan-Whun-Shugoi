(in-package :ahan-whun-shugoi-api.controller)

(defclass aws (aws.beach::aws)
  ((children-display :accessor children-display  :initarg :children-display  :initform nil))
  (:documentation ""))

(defun aws2aws (aws_in)
  (let ((aws_out (make-instance 'aws)))
    (setf (slot-value aws_out 'up:%id)                  (slot-value aws_in 'up:%id))
    (setf (slot-value aws_out 'aws.beach::code)         (slot-value aws_in 'aws.beach::code))
    (setf (slot-value aws_out 'aws.beach::description)  (slot-value aws_in 'aws.beach::description))
    (setf (slot-value aws_out 'aws.beach::synopsis)     (slot-value aws_in 'aws.beach::synopsis))
    (setf (slot-value aws_out 'aws.beach::options)      (slot-value aws_in 'aws.beach::options))
    (setf (slot-value aws_out 'aws.beach::location)     (slot-value aws_in 'aws.beach::location))
    (setf (slot-value aws_out 'aws.beach::display)      (slot-value aws_in 'aws.beach::display))
    (setf (slot-value aws_out 'aws.beach::stroke)       (slot-value aws_in 'aws.beach::stroke))
    (setf (slot-value aws_out 'children-display)        (mapcar #'aws.beach::command2response-display (find-commands)))
    aws_out))


(defmethod jojo:%to-json ((obj aws))
  (jojo:with-object
    (jojo:write-key-value "_id"              (slot-value obj 'up:%id))
    (jojo:write-key-value "code"             (slot-value obj 'aws.beach::code))
    (jojo:write-key-value "name"             (slot-value obj 'aws.beach::code)) ;; web/ での表示用
    (jojo:write-key-value "description"      (slot-value obj 'aws.beach::description))
    (jojo:write-key-value "synopsis"         (slot-value obj 'aws.beach::synopsis))
    (jojo:write-key-value "options"          (slot-value obj 'aws.beach::options))
    (jojo:write-key-value "location"         (slot-value obj 'aws.beach::location))
    (jojo:write-key-value "display"          (let ((v (slot-value obj 'aws.beach::display))) (or v :false)))
    (jojo:write-key-value "stroke"           (slot-value obj 'aws.beach::stroke))
    (jojo:write-key-value "children_display" (slot-value obj 'children-display))
    (jojo:write-key-value "_class"           "AWS")))


(defun make-response-aws ()
  (let ((aws (car (shinra:find-vertex (graph) 'aws.beach::aws))))
    (list :aws (aws2aws aws)
          :options (find-aws-options aws))))

(defun find-aws-options (aws)
  (find-to-vertexs-relationship (graph) aws 'aws.beach::r-aws2options))

(defun find-aws-commands (aws)
  (find-to-vertexs-relationship (graph) aws 'aws.beach::r-aws2commands))
