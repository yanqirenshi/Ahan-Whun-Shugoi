(in-package :ahan-whun-shugoi-api.controller)

(defun get-subcommand-at-%id (%id)
  (let ((subcommand (get-vertex-at-%id 'aws.beach::subcommand %id)))
    (list :subcommand subcommand
          :options (find-subcommand-options subcommand))))

(defun find-subcommand-options (subcommand)
  (find-to-vertexs-relationship (graph) subcommand 'aws.beach::r-subcommand2options))
