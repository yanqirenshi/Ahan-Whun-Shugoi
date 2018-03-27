#|
  This file is a part of ahan-whun-shugoi-beach project.
|#

(defsystem "ahan-whun-shugoi-beach"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on (:cl-ppcre
               :local-time
               :upanishad
               :shinrabanshou
               :closure-html
               :dexador)
  :components ((:module "src"
                :components
                ((:file "graph")
                 (:module "utilities" :components ((:file "util")
                                                   (:file "util-html")
                                                   (:file "locker")))
                 (:file "package")
                 (:module "class" :components ((:file "sand")
                                               (:file "aws")
                                               (:file "command")
                                               (:file "subcommand")
                                               (:file "option")
                                               (:file "relashonship")))
                 (:file "options")
                 (:module "parser" :components ((:file "synopsis")
                                                (:file "options")))
                 (:file "subcommands")
                 (:file "commands")
                 (:file "aws"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "ahan-whun-shugoi-beach-test"))))
