(in-package :aws.beach)

(defclass command (sand)
  ((uri     :accessor uri     :initarg :uri     :initform nil)
   (display :accessor display :initarg :display :initform nil)
   (stroke  :accessor stroke  :initarg :stroke  :initform '(:color (:r 217 :g 51 :b 63 :a 0.2) :width 5)))
  (:documentation "コマンドを現わすクラスです。

# Relashonship

```
 command --1:n--> subcommand
```
"))

(defmethod jojo:%to-json ((obj command))
  (jojo:with-object
    (jojo:write-key-value "_id"         (slot-value obj 'up:%id))
    (jojo:write-key-value "code"        (slot-value obj 'code))
    (jojo:write-key-value "name"        (slot-value obj 'code)) ;; web/ での表示用
    (jojo:write-key-value "description" (slot-value obj 'description))
    (jojo:write-key-value "uri"         (slot-value obj 'uri))
    (jojo:write-key-value "x"           (slot-value obj 'x))
    (jojo:write-key-value "y"           (slot-value obj 'y))
    (jojo:write-key-value "z"           (slot-value obj 'z))
    (jojo:write-key-value "display"     (let ((v (slot-value obj 'display))) (or v :false)))
    (jojo:write-key-value "stroke"      (slot-value obj 'stroke))
    (jojo:write-key-value "_class"      "COMMAND")))
