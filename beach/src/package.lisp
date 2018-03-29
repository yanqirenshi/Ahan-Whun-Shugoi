(defpackage ahan-whun-shugoi-beach
  (:nicknames :aws-beach)
  (:use #:cl
        #:aws-beach.util.html-common
        #:aws-beach.util
        #:aws-beach.util.html
        #:aws-beach.util.lock
        #:aws-beach.util.uri)
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
  (:import-from :aws-beach.db
                #:*graph*)
  (:import-from :up
                #:execute-transaction)
  (:import-from :shinra
                #:shin
                #:ra
                #:find-vertex
                #:find-r-vertex
                #:tx-make-vertex
                #:tx-make-edge
                #:get-r
                #:make-edge)
  (:export #:find-aws-options
           #:get-command
           #:get-command-subcommand
           #:find-subcommand-options
           #:collect)
  (:export #:command
           #:display
           #:r-aws2commands
           #:r-aws2options
           #:r-command2subcommands
           #:r-subcommand2options))
(in-package :ahan-whun-shugoi-beach)

(defvar *get-uri-interval-time* 1)
