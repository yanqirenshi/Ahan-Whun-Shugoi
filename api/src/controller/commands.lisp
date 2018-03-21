(in-package :ahan-whun-shugoi-api.controller)

(defun get-command-at-%id (%id)
  (let ((command (get-vertex-at-%id 'aws.beach::command %id)))
    (list :command command
          :subcommands (find-command-subcommands command))))

(defun find-command-subcommands (command)
  (find-to-vertexs-relationship (graph) command 'aws.beach::r-command2subcommands))

(defun update-command-display (_id value)
  (list _id value))
