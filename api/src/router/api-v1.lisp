(in-package :cl-user)
(defpackage ahan-whun-shugoi-api.api-v1
  (:use #:cl
        #:caveman2
        #:lack.middleware.validation
        #:ahan-whun-shugoi-api.config
        #:ahan-whun-shugoi-api.render
        #:aws-api.controller)
  (:export #:*api-v1*))
(in-package :ahan-whun-shugoi-api.api-v1)

;;;;;
;;;;; Application
;;;;;
(defclass <router> (<app>) ())
(defvar *api-v1* (make-instance '<router>))
(clear-routing-rules *api-v1*)

(defun graph () aws-beach.db::*graph*)

;;;;;
;;;;; Routing rules
;;;;;
(defroute "/" ()
  (render-json (list 1 2 3)))

;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <router>) (code (eql 404)))
  (declare (ignore app))
  "404")
