(in-package :cl-user)
(defpackage ahan-whun-shugoi-api.controller
  (:nicknames :aws-api.controller)
  (:use :cl)
  (:import-from #:ahan-whun-shugoi-api.config
                #:config)
  (:export #:page-root))
(in-package :ahan-whun-shugoi-api.controller)

(defun find-edges-at (graph edge-class to-vertexs)
  (apply #'append
         (mapcar #'(lambda (option)
                     (shinra:find-r-edge graph
                                         edge-class
                                         :to option))
                 to-vertexs)))

(defun page-root (graph)
  (let* ((aws    (car (shinra:find-vertex graph 'aws.beach::aws)))
         (commands    (shinra:find-vertex graph 'aws.beach::command))
         (subcoomands (shinra:find-vertex graph 'aws.beach::subcommand))
         (options     (shinra:find-vertex graph 'aws.beach::option)))
    (list :vertex (list :aws aws
                        :commands commands
                        :subcoomands subcoomands
                        :options options)
          :edge (append (find-edges-at graph 'aws.beach::r-subcommand2options  options)
                        (find-edges-at graph 'aws.beach::r-command2subcommands subcoomands)
                        (find-edges-at graph 'aws.beach::r-aws2commands        commands)))))
