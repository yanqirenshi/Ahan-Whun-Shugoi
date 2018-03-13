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

;;;;;
;;;;; Routing rules
;;;;;
(defroute "/" ()
  "api-v1")

;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <router>) (code (eql 404)))
  (declare (ignore app))
  "404")
