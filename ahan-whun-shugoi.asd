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
               :lparallel
               :ahan-whun-shugoi-beach)
  :components ((:module "core"
                :serial t
                :components
                ((:module "db" :components ((:file "graph")))
                 (:module "utilities" :components ((:file "html")
                                                   (:file "datetime")))
                 (:module "cli" :components ((:file "config")
                                             (:file "option")
                                             (:file "command")))
                 (:module "help" :components ((:file "help")))
                 (:file "package")
                 (:module "subcommands" :components
                          ((:file "util")
                           (:module "ec2" :components ((:file "ec2")))
                           (:module "elb" :components ((:file "elb")))
                           (:module "s3" :components ((:file "class")
                                                      (:file "s3")))
                           (:module "logs" :components ((:file "class")
                                                        (:file "describe-log-groups")
                                                        (:file "describe-log-streams")
                                                        (:file "describe-metric-filters")
                                                        (:file "log-event")))
                           (:module "iam" :components ((:file "log-user")))
                           (:module "cloudwatch" :components ((:file "class")
                                                              (:file "list-metrics")
                                                              (:file "describe-alarms")))))
                 (:file "aws"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.md"
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
