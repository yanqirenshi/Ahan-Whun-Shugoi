#|
This file is a part of ahan-whun-shugoi project.
Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

#|
Author: Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

(in-package :cl-user)
(defpackage ahan-whun-shugoi-asd
  (:use :cl :asdf))
(in-package :ahan-whun-shugoi-asd)

(defsystem ahan-whun-shugoi
  :version "0.1"
  :author "Satoshi Iwasaki"
  :license "MIT"
  :depends-on (:cl-ppcre
               :local-time
               :trivial-shell
               :split-sequence
               :jonathan
               :upanishad
               :shinrabanshou
               :closure-html
               :quri
               :dexador
               :lparallel)
  :components ((:module "src"
                :components
                ((:module "db" :components ((:file "graph")))
                 (:module "utilities" :components ((:file "html")))
                 (:module "beach"
                  :components ((:file "package")
                               (:file "util")
                               (:file "classes")
                               (:file "options")
                               (:file "parser-synopsis")
                               (:file "parser-options")
                               (:file "subcommands")
                               (:file "commands")
                               (:file "aws")))
                 (:module "cli" :components ((:file "config")
                                             (:file "option")
                                             (:file "command")))
                 (:file "package")
                 (:module "services" :components
                          ((:file "util")
                           (:module "ec2" :components ((:file "ec2")))
                           (:module "elb" :components ((:file "elb")))
                           (:module "s3" :components ((:file "class")
                                                      (:file "s3")))
                           (:module "logs" :components ((:file "log-group")
                                                        (:file "log-event")
                                                        (:file "describe-metric-filters")))
                           (:module "iam" :components ((:file "log-user")))
                           (:module "cloudwatch" :components ((:file "class")
                                                              (:file "list-metrics")
                                                              (:file "describe-alarms")))))
                 (:file "aws"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op ahan-whun-shugoi-test))))
