(in-package :aws.beach)

(defclass command (sand)
  ((uri :accessor uri :initarg :uri :initform nil))
  (:documentation "コマンドを現わすクラスです。

# Relashonship

```
 command --1:n--> subcommand
```
"))

(defmethod jojo:%to-json ((obj command))
  (jojo:with-object
    (jojo:write-key-value "_id" (slot-value obj 'up:%id))
    (jojo:write-key-value "code"        (slot-value obj 'code))
    (jojo:write-key-value "description" (slot-value obj 'description))
    (jojo:write-key-value "uri"         (slot-value obj 'uri))))
