(in-package :cl-user)
(defpackage ahan-whun-shugoi.scraping
  (:nicknames :aws.scraping)
  (:use :cl :ahan-whun-shugoi.html)
  (:export #:collect)
  (:import-from :split-sequence
                #:split-sequence)
  (:import-from :cl-ppcre
                #:scan-to-strings)
  (:import-from :lparallel
                #:plet
                #:*kernel*
                #:make-kernel)
  (:import-from :alexandria
                #:when-let)
  (:import-from :chtml
                #:pt-name
                #:pt-attrs
                #:pt-builder
                #:pt-children
                #:pt-parent)
  (:import-from :aws.db
                #:*graph*)
  (:import-from :up
                #:execute-transaction)
  (:import-from :shinra
                #:shin
                #:ra
                #:find-vertex
                #:tx-make-vertex
                #:get-r
                #:make-edge)
  (:export #:find-aws-options
           #:get-service
           #:get-service-command
           #:find-command-options
           #:get-command))
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
