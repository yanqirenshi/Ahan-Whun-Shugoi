(in-package :cl-user)
(defpackage ahan-whun-shugoi-api.router
  (:use :cl
        :caveman2
        :lack.middleware.validation
        :ahan-whun-shugoi-api.config
        :ahan-whun-shugoi-api.render)
  (:export #:*route*))
(in-package :ahan-whun-shugoi-api.router)

;;;;;
;;;;; Router
;;;;;
(defclass <router> (<app>) ())
(defvar *route* (make-instance '<router>))
(clear-routing-rules *route*)

;;;;;
;;;;; Routing rules
;;;;;
(defroute "/" ()
  "")

;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <router>) (code (eql 404)))
  (declare (ignore app))
  "404")
