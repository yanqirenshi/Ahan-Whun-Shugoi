(in-package :cl-user)
(defpackage ahan-whun-shugoi-api.cosmos
  (:nicknames :aws-api.cosmos)
  (:use :cl)
  (:import-from :aws.cosmos.graph
                #:*graph*))
(in-package :ahan-whun-shugoi-api.cosmos)

(defun find-ec2-instances ()
  (shinra:find-vertex *graph* 'aws.cosmos::ec2-instance))
