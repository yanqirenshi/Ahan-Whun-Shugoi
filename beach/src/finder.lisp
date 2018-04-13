(in-package :aws-beach)

(defun get-finder (&key code (graph *graph*))
  (car (shinra:find-vertex graph 'finder :slot 'code :value code)))

(defun find-finder (&key (graph *graph*))
  (shinra:find-vertex graph 'finder))

(defun %tx-make-finder (graph code)
  (assert (keywordp code)
          (code) "Code is not keyworde symbol. code=~a (~a)" code (type-of code))
  (assert (not (get-finder :code code :graph graph))
          (code) "Aledy exists finder. code=~a" code)
  (tx-make-vertex graph 'finder
                  `((code ,code))))

(defun ensure-finder (graph code)
  (or (get-finder :code code :graph graph)
      (up:execute-transaction
       (%tx-make-finder graph code))))


;;;;;
;;;;; start graph fook
;;;;;
(setf aws-beach.db:*fook-graph-start-after*
      #'(lambda ()
          (ensure-finder *graph* :default)
          (ensure-finder *graph* :finder-1)
          (ensure-finder *graph* :finder-2)
          (ensure-finder *graph* :finder-3)))
