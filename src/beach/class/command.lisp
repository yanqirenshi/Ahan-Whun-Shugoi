(in-package :aws.beach)

(defclass command (sand)
  ((uri :accessor uri :initarg :uri :initform nil))
  (:documentation "コマンドを現わすクラスです。

# Relashonship

```
 command --1:n--> subcommand
```
"))
