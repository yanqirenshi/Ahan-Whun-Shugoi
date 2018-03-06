(in-package :ahan-whun-shugoi)

(defun servicep (service)
  (assert (keywordp service))
  (assoc service *commands*))

(defun assert-service (service)
  (unless (servicep service)
    (error "not supported service. service=~a" service)))
