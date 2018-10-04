(defsystem "ahan-whun-shugoi-cli"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on (:cl-ppcre
               :local-time
               :jonathan
               :trivial-shell
               :upanishad
               :shinrabanshou
               :closure-html
               :closure-html-adapter
               :dexador
               :lparallel
               :ahan-whun-shugoi-beach)
  :components ((:module "src"
                :components
                ((:module "db" :components ((:file "graph")))
                 (:module "cmd-builder" :components ((:file "config")
                                                     (:file "option")
                                                     (:file "command")))
                 (:module "helper" :components ((:file "help")))
                 (:file "package")
                 (:file "condition")
                 (:file "aws"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "ahan-whun-shugoi-cli-test"))))
