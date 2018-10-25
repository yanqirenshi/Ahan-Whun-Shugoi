(in-package :cl-user)
(defpackage ahan-whun-shugoi-api.controller
  (:nicknames :aws-api.controller)
  (:use #:cl)
  (:import-from :alexandria
                #:when-let)
  (:import-from :aws.beach.db
                #:*graph*)
  (:export #:get-aws
           #:get-command-at-%id
           #:get-subcommand-at-%id
           #:get-option-at-%id
           #:find-aws-options
           #:find-aws-commands
           #:find-command-subcommands
           #:find-subcommand-options)
  (:export #:get-command
           #:update-node-display
           #:update-node-location
           #:find-commands
           #:find-commands-at-displayed
           #:get-subcommand
           #:find-subcommands
           #:find-subcommands-at-displayed
           #:get-option
           #:find-options-at-displayed)
  (:export #:get-finder)
  (:export #:make-response-aws
           #:make-response-command
           #:make-response-subcommand
           #:make-response-option))
(in-package :ahan-whun-shugoi-api.controller)
