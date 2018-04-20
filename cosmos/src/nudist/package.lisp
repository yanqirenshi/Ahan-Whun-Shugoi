(defpackage ahan-whun-shugoi.cosmos.nudist
  (:nicknames :aws.cosmos.nudist)
  (:use #:cl)
  (:import-from :alexandria
                #:make-keyword)
  (:import-from :shinra
                #:tx-make-vertex)
  (:import-from :aws.cosmos.graph
                #:*graph*)
  (:export #:plists2objects
           #:undresses
           ;;
           #:set-value-ignore
           #:set-value-simple
           #:set-value-tags2alist
           #:set-value-plist2plist))
(in-package :ahan-whun-shugoi.cosmos.nudist)
