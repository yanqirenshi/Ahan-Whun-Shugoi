(in-package :cl-user)
(defpackage ahan-whun-shugoi.scraping
  (:use :cl :ahan-whun-shugoi.html)
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

(defvar *uri-scheme* "https")
(defvar *uri-host* "docs.aws.amazon.com")
(defvar *uri-base-path* "/ja_jp/cli/latest/reference/")

(defun aws-uri (path)
  (quri:render-uri
   (quri:make-uri :scheme *uri-scheme*
                  :host *uri-host*
                  :path (format nil "~a" (merge-pathnames path *uri-base-path*)))))

(defun root-uri ()
  (aws-uri "index.html"))
