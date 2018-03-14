(in-package :aws.beach)

(defclass aws (sand)
  ((synopsis :accessor synopsis :initarg :synopsis :initform nil)
   (options  :accessor options  :initarg :options  :initform nil)
   (uri      :accessor uri      :initarg :uri      :initform nil))
  (:documentation "AWS Cli の `aws` コマンドを現わすクラスです。

# Relashonship

```
 aws --+--1:n--> command
       `--1:n--> options
```
"))
