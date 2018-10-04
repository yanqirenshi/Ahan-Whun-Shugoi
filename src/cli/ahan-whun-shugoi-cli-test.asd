(defsystem "ahan-whun-shugoi-cli-test"
  :defsystem-depends-on ("prove-asdf")
  :author ""
  :license ""
  :depends-on ("ahan-whun-shugoi-cli"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "ahan-whun-shugoi-cli"))))
  :description "Test system for ahan-whun-shugoi-cli"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
