#|
  This file is a part of ahan-whun-shugoi.cosmos project.
|#

(defsystem "ahan-whun-shugoi.cosmos"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "util")
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
                                                    (:file "describe-alarms"))))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "ahan-whun-shugoi.cosmos-test"))))
