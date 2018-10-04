#|
  This file is a part of ahan-whun-shugoi-beach project.
|#

(defsystem "ahan-whun-shugoi-beach-test"
  :defsystem-depends-on ("prove-asdf")
  :author ""
  :license ""
  :depends-on ("ahan-whun-shugoi-beach"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "ahan-whun-shugoi-beach"))))
  :description "Test system for ahan-whun-shugoi-beach"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
