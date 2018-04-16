(in-package :ahan-whun-shugoi-api.controller)

(defun get-aws ()
  (let ((aws (car (shinra:find-vertex (graph) 'aws.beach::aws))))
    (list :aws aws
          :commands (find-aws-commands aws)
          :options (find-aws-options aws))))

(defun find-aws-options (aws)
  (find-to-vertexs-relationship (graph) aws 'aws.beach::r-aws2options))

(defun find-aws-commands (aws)
  (find-to-vertexs-relationship (graph) aws 'aws.beach::r-aws2commands))
