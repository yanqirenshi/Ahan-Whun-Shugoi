#|
  This file is a part of ahan-whun-shugoi-beach project.
|#

(defsystem "ahan-whun-shugoi-beach"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "graph"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "ahan-whun-shugoi-beach-test"))))
