(in-package :cl-user)
(defpackage ahan-whun-shugoi-api.controller
  (:nicknames :aws-api.controller)
  (:use :cl)
  (:import-from #:ahan-whun-shugoi-api.config
                #:config)
  (:export #:get-aws
           #:get-command-at-%id
           #:get-subcommand-at-%id
           #:get-option-at-%id))
(in-package :ahan-whun-shugoi-api.controller)

(defun graph () aws.db::*graph*)

(defun get-aws ()
  (car (shinra:find-vertex (graph) 'aws.beach::aws)))

(defun get-vertex-at-%id (class &optional %id)
  (shinra:get-vertex-at (graph) class :%id %id))

(defun get-command-at-%id (%id)
  (get-vertex-at-%id 'aws.beach::command %id))

(defun get-subcommand-at-%id (%id)
  (get-vertex-at-%id 'aws.beach::subcommand %id))

(defun get-option-at-%id (%id)
  (get-vertex-at-%id 'aws.beach::option %id))
