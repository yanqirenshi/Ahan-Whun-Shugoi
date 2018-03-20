(in-package :cl-user)
(defpackage ahan-whun-shugoi-api.controller
  (:nicknames :aws-api.controller)
  (:use :cl)
  (:import-from #:ahan-whun-shugoi-api.config
                #:config)
  (:export #:get-aws
           #:get-command-at-%id
           #:get-subcommand-at-%id
           #:get-option-at-%id
           #:find-aws-options
           #:find-aws-commands
           #:find-command-subcommands
           #:find-subcommand-options))
(in-package :ahan-whun-shugoi-api.controller)

(defun graph () aws.db::*graph*)


(defun find-to-vertexs-relationship (graph from-vertex to-class)
  (let ((vertexs nil)
        (relationship nil))
    (dolist (plist (shinra:find-r graph to-class :from from-vertex))
      (push (getf plist :vertex) vertexs)
      (push (getf plist :edge) relationship))
    (list :nodes vertexs :relationships relationship)))

(defun find-aws-options (aws)
  (find-to-vertexs-relationship (graph) aws 'aws.beach::r-aws2options))

(defun find-aws-commands (aws)
  (find-to-vertexs-relationship (graph) aws 'aws.beach::r-aws2commands))

(defun find-command-subcommands (command)
  (find-to-vertexs-relationship (graph) command 'aws.beach::r-command2subcommands))

(defun find-subcommand-options (subcommand)
  (find-to-vertexs-relationship (graph) subcommand 'aws.beach::r-subcommand2options))



(defun get-aws ()
  (let ((aws (car (shinra:find-vertex (graph) 'aws.beach::aws))))
    (list :aws aws
          :commands (find-aws-commands aws)
          :options (find-aws-options aws))))

(defun get-vertex-at-%id (class &optional %id)
  (shinra:get-vertex-at (graph) class :%id %id))

(defun get-command-at-%id (%id)
  (let ((command (get-vertex-at-%id 'aws.beach::command %id)))
    (list :command command
          :subcommands (find-command-subcommands command))))

(defun get-subcommand-at-%id (%id)
  (let ((subcommand (get-vertex-at-%id 'aws.beach::subcommand %id)))
    (list :subcommand subcommand
          :options (find-subcommand-options subcommand))))

(defun get-option-at-%id (%id)
  (get-vertex-at-%id 'aws.beach::option %id))
