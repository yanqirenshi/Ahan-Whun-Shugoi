(in-package :cl-user)
(defpackage ahan-whun-shugoi-api-test-asd
  (:use :cl :asdf))
(in-package :ahan-whun-shugoi-api-test-asd)

(defsystem ahan-whun-shugoi-api-test
  :author ""
  :license ""
  :depends-on (:ahan-whun-shugoi-api
               :prove)
  :components ((:module "t"
                :components
                ((:file "ahan-whun-shugoi-api"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
