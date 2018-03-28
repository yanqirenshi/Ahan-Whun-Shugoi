#|
  This file is a part of ahan-whun-shugoi.cosmos project.
|#

(defsystem "ahan-whun-shugoi.cosmos-test"
  :defsystem-depends-on ("prove-asdf")
  :author ""
  :license ""
  :depends-on ("ahan-whun-shugoi.cosmos"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "ahan-whun-shugoi.cosmos"))))
  :description "Test system for ahan-whun-shugoi.cosmos"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
