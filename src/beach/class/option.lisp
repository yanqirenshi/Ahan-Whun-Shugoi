(in-package :aws.beach)

(defclass option (sand)
  () (:documentation "コマンドを現わすクラスです。

# Relashonship

```
 option --+--1:1--> 2json
          `--1:1--> 2class-instance
```
"))

(defmethod jojo:%to-json ((obj option))
  (jojo:with-object
    (jojo:write-key-value "_id"    (slot-value obj 'up:%id))
    (jojo:write-key-value "code"   (slot-value obj 'code))
    (jojo:write-key-value "_class" "OPTION")))
