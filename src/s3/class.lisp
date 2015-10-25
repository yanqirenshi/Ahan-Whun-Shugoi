(in-package :ahan-whun-sgoi)

(defclass s3-object ()
  ((name :accessor name
         :initarg :name)))

(defclass s3-root-bucket (s3-object)
  ((timestamp :accessor timestamp
              :initarg :timestamp)))

(defclass s3-branch-bucket (s3-object) ())

(defclass s3-file (s3-root-bucket)
  ((size :accessor size
         :initarg :size)))
