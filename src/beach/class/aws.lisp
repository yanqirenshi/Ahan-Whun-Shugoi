(in-package :aws.beach)

(defclass aws (sand)
  ((synopsis :accessor synopsis :initarg :synopsis :initform nil)
   (options  :accessor options  :initarg :options  :initform nil)
   (uri      :accessor uri      :initarg :uri      :initform nil)
   (display  :accessor display  :initarg :display  :initform t)
   (stroke   :accessor stroke   :initarg :stroke   :initform '(:color (:r 217 :g 51 :b 63 :a 0.1) :width 5)))
  (:documentation "AWS Cli の `aws` コマンドを現わすクラスです。

# Relashonship

```
 aws --+--1:n--> command
       `--1:n--> options
```
"))

(defmethod jojo:%to-json ((obj aws))
  (jojo:with-object
    (jojo:write-key-value "_id"         (slot-value obj 'up:%id))
    (jojo:write-key-value "code"        (slot-value obj 'code))
    (jojo:write-key-value "name"        (slot-value obj 'code)) ;; web/ での表示用
    (jojo:write-key-value "description" (slot-value obj 'description))
    (jojo:write-key-value "synopsis"    (slot-value obj 'synopsis))
    (jojo:write-key-value "options"     (slot-value obj 'options))
    (jojo:write-key-value "x"           (slot-value obj 'x))
    (jojo:write-key-value "y"           (slot-value obj 'y))
    (jojo:write-key-value "z"           (slot-value obj 'z))
    (jojo:write-key-value "dipslay"     (slot-value obj 'dipslay))
    (jojo:write-key-value "stroke"      (slot-value obj 'stroke))
    (jojo:write-key-value "_class"      "AWS")))
