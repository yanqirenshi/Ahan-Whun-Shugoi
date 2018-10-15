(in-package :ahan-whun-shugoi-api.controller)

(defun make-response-option (option)
  (list :option option
        :parent-relationships (shinra:find-r-edge *graph* 'aws.beach::r-subcommand2options :to option)))

(defun get-option-at-%id (%id)
  (get-vertex-at-%id 'aws.beach::option %id))

(defun get-option (&key %id)
  (when %id
    (get-vertex-at-%id 'aws.beach::option %id)))
