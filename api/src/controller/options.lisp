(in-package :ahan-whun-shugoi-api.controller)

(defun get-option-at-%id (%id)
  (get-vertex-at-%id 'aws.beach::option %id))

(defun get-option (&key %id)
  (when %id
    (get-vertex-at-%id 'aws.beach::option %id)))
