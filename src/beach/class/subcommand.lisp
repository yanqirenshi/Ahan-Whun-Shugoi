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
