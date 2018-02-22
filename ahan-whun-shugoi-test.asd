#|
  This file is a part of ahan-whun-sgoi project.
  Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

(in-package :cl-user)
(defpackage ahan-whun-shugoi-test-asd
  (:use :cl :asdf))
(in-package :ahan-whun-shugoi-test-asd)

(defsystem ahan-whun-shugoi-test
  :author "Satoshi Iwasaki"
  :license "MIT"
  :depends-on (:ahan-whun-shugoi
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "ahan-whun-shugoi"))))
  :description "Test system for ahan-whun-shugoi"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
