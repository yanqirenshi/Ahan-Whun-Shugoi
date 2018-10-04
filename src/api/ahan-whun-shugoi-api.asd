(in-package :cl-user)
(defpackage ahan-whun-shugoi-api-asd
  (:use :cl :asdf))
(in-package :ahan-whun-shugoi-api-asd)

(defsystem ahan-whun-shugoi-api
  :version "0.1"
  :author ""
  :license ""
  :depends-on (:clack
               :lack
               :caveman2
               :envy
               :cl-ppcre
               :uiop
               :lack-middleware-validation
               :jonathan
               ;; Database
               :upanishad
               :shinrabanshou
               :sephirothic
               :ahan-whun-shugoi)
  :components ((:module "src"
                :components
                ((:file "config")
                 (:module "beach"
                  :components ((:file "package")
                               (:file "util")
                               (:file "aws")
                               (:file "commands")
                               (:file "subcommands")
                               (:file "options")
                               (:file "finder")))
                 (:file "render")
                 (:module "router"
                  :components ((:file "route")
                               (:file "beach")
                               (:file "api-v1")))
                 (:file "main"))))
  :description ""
  :in-order-to ((test-op (load-op ahan-whun-shugoi-api-test))))
