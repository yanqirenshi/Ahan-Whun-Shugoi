(in-package :ahan-whun-shugoi-api.controller)

(defun graph () aws-beach.db::*graph*)

(defun find-to-vertexs-relationship (graph from-vertex to-class)
  (let ((vertexs nil)
        (relationship nil))
    (dolist (plist (shinra:find-r graph to-class :from from-vertex))
      (push (getf plist :vertex) vertexs)
      (push (getf plist :edge) relationship))
    (list :nodes vertexs :relationships relationship)))

(defun get-vertex-at-%id (class &optional %id)
  (shinra:get-vertex-at (graph) class :%id %id))
