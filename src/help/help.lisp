(in-package :cl-user)
(defpackage ahan-whun-shugoi.help
  (:nicknames :aws.help)
  (:use #:cl)
  (:export #:print-aws-help
           #:print-command-help
           #:print-subcommand-help))
(in-package :ahan-whun-shugoi.help)

;;;
;;; util
;;;
(defun kyeword-sorter (a b)
  (string< (symbol-name a)
           (symbol-name b)))

(defun print-target (label target)
  (format t "~a: ~a~2%" label (aws-beach::CODE target)))

(defun print-elements (label elements)
  (format t " ~a ~%=============~%" label)
  (format t "~{- ~a~%~}~%"
          (sort (mapcar #'aws-beach::CODE elements)
                #'kyeword-sorter)))

(defun print-options (label elements)
  (format t " ~a ~%=============~%" label)
  (format t "~{ ~a~%~}~%"
          (sort (mapcar #'aws-beach::CODE elements)
                #'kyeword-sorter)))

;;;
;;; main
;;;
(defun print-aws-help ()
  (let* ((aws (aws-beach::get-aws))
         (commands (shinra:find-vertex aws-beach.db:*graph* 'aws-beach::command))
         (options (shinra:find-r-vertex aws-beach.db:*graph*
                                        'aws-beach:r-aws2options
                                        :from aws)))
    (print-target "Aws" aws)
    (print-elements "Commands" commands)
    (print-options "Options" options)
    (format t " Description ~%=============~%")
    (format t "~a~2%" (aws-beach::description aws))
    (format t " Url ~%=====~%")
    (format t "~a~2%" (aws-beach::uri aws))))

(defun print-command-help (command-code)
  (let* ((command (aws-beach:get-command :code command-code))
         (subcommands (shinra:find-r-vertex aws-beach.db:*graph*
                                            'aws-beach:r-command2subcommands
                                            :from command)))
    (assert command)
    (print-target "Command" command)
    (print-elements "Subcommands" subcommands)
    (format t " Description ~%=============~%")
    (format t "~a~2%" (aws-beach::description command))
    (format t " Url ~%=====~%")
    (format t "~a~2%" (aws-beach::uri command))))

(defun print-subcommand-help (subcommand-code)
  (let* ((subcommand (aws-beach::get-subcommand :code subcommand-code))
        (options (shinra:find-r-vertex aws-beach.db:*graph*
                                       'aws-beach:r-subcommand2options
                                       :from subcommand)))
    (assert subcommand)
    (print-target "Subcommand" subcommand)
    (print-options "Options" options)
    (format t " Description ~%=============~%")
    (format t "~a~2%" (aws-beach::description subcommand))
    (format t " Url ~%=====~%")
    (format t "~a~2%" (aws-beach::uri subcommand))))
