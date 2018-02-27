(in-package :cl-user)
(defpackage ahan-whun-shugoi.scraping
  (:use :cl)
  (:export #:start
           #:stop
           #:graph-data-stor
           ;; s3
           #:name)
  (:import-from :shinra
                #:shin
                #:ra)
  (:import-from :alexandria
                #:when-let)
  (:import-from :chtml
                #:pt-name
                #:pt-attrs
                #:pt-builder
                #:pt-children
                #:pt-parent))
(in-package :ahan-whun-shugoi.scraping)
