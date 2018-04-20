(in-package :cl-user)
(defpackage ahan-whun-shugoi-api.cosmos
  (:use #:cl
        #:caveman2
        #:lack.middleware.validation
        #:ahan-whun-shugoi-api.config
        #:ahan-whun-shugoi-api.render
        #:aws-api.controller)
  (:export #:*api-cosmos*))
(in-package :ahan-whun-shugoi-api.cosmos)

;;;;;
;;;;; Application
;;;;;
(defclass <router> (<app>) ())
(defvar *api-cosmos* (make-instance '<router>))
(clear-routing-rules *api-cosmos*)

(defun graph () aws.cosmos.graph:*graph*)

;;;;;
;;;;; Routing rules
;;;;;
(defroute "/" ()
  (render-json (list 4 5 6)))

(defroute "/ec2/instances" ()
  (render-json (aws-api.cosmos::find-ec2-instances)))

;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <router>) (code (eql 404)))
  (declare (ignore app))
  "404")
