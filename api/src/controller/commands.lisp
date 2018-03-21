(in-package :ahan-whun-shugoi-api.controller)

(defun get-command (&key %id)
  (get-vertex-at-%id 'aws.beach:command %id))

(defun get-command-at-%id (%id)
  (let ((command (get-vertex-at-%id 'aws.beach:command %id)))
    (list :command command
          :subcommands (find-command-subcommands command))))

(defun find-command-subcommands (command)
  (find-to-vertexs-relationship (graph) command 'aws.beach:r-command2subcommands))

(defun update-command-display (_id value)
  (let* ((command (get-command :%id _id))
         (relashonship (car (shinra:find-r *graph* 'aws.beach:r-aws2commands :to command))))
    (unless command (caveman2:throw-code 404))
    (up:execute-transaction
     (up:tx-change-object-slots *graph*
                                'aws.beach:command
                                _id
                                `((aws.beach:display ,value))))
    (list :node command
          :relashonship (list :node (getf relashonship :vertex)
                              :edge (getf relashonship :edge)))))
