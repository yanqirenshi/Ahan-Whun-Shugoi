(in-package :aws.beach)

(defclass subcommand (sand)
  ((synopsis :accessor synopsis :initarg :synopsis :initform nil)
   (examples :accessor examples :initarg :examples :initform nil)
   (output   :accessor output   :initarg :output   :initform nil)
   (uri      :accessor uri      :initarg :uri      :initform nil)
   (lock     :accessor lock     :initarg :lock     :initform t))
  (:documentation "コマンドを現わすクラスです。

# Relashonship

```
 subcommand --1:n--> option
```
"))

(defmethod jojo:%to-json ((obj subcommand))
  (jojo:with-object
    (jojo:write-key-value "_id"         (slot-value obj 'up:%id))
    (jojo:write-key-value "code"        (slot-value obj 'code))
    (jojo:write-key-value "description" (slot-value obj 'description))
    (jojo:write-key-value "uri"         (slot-value obj 'uri))
    (jojo:write-key-value "lock"        (slot-value obj 'lock))))
