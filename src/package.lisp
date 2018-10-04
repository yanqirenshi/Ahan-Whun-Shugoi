(in-package :cl-user)
(defpackage ahan-whun-shugoi
  (:nicknames :aws)
  (:nicknames :shugoi)
  (:use #:cl
        #:aws.cli
        #:aws.beach
        #:aws.help)
  (:export :aws)
  (:export #:start
           #:stop
           #:graph-data-stor)
  (:export #:*print-command-stream*)
  (:export #:collect))
(in-package :ahan-whun-shugoi)
