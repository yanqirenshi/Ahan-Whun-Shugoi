(in-package :cl-user)
(defpackage ahan-whun-shugoi-api.api-v1
  (:use :cl
        :caveman2
        :lack.middleware.validation
        :ahan-whun-shugoi-api.config
        :ahan-whun-shugoi-api.render)
  (:export #:*api-v1*))
(in-package :ahan-whun-shugoi-api.api-v1)

;;;;;
;;;;; Application
;;;;;
(defclass <router> (<app>) ())
(defvar *api-v1* (make-instance '<router>))
(clear-routing-rules *api-v1*)

(defun graph () aws.db::*graph*)

;;;;;
;;;;; Routing rules
;;;;;
(defroute "/" ()
  (render-json (list 1 2 3)))

(defroute "/aws" ()
  (render-json (shinra:find-vertex (graph) 'aws.beach::aws)))

(defroute "/aws/options" ()
  (render-json (list 1 2 3)))

(defroute "/commands/:_id" ()
  (render-json (list 1 2 3)))

(defroute "/commands/:_id/subcommands" ()
  (render-json (list 1 2 3)))

(defroute "/subcommands/:_id" ()
  (render-json (list 1 2 3)))

(defroute "/subcommands/:_id/options" ()
  (render-json (list 1 2 3)))

(defroute "/options/:_id" ()
  (render-json (list 1 2 3)))

;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <router>) (code (eql 404)))
  (declare (ignore app))
  "404")
