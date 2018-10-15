(in-package :ahan-whun-shugoi-api.controller)

(defun make-response-aws ()
  (let ((aws (car (shinra:find-vertex (graph) 'aws.beach::aws))))
    (list :aws aws
          :commands (mapcar #'aws.beach::command2response-display (find-commands))
          :options (find-aws-options aws))))

(defun find-aws-options (aws)
  (find-to-vertexs-relationship (graph) aws 'aws.beach::r-aws2options))

(defun find-aws-commands (aws)
  (find-to-vertexs-relationship (graph) aws 'aws.beach::r-aws2commands))
