(in-package :aws-beach)

(defun get-finder (&key code (graph *graph*))
  (car (shinra:find-vertex graph 'finder :slot 'code :value code)))

(defun %tx-make-finder (graph code)
  (assert (keywordp code)
          (code) "Code is not keyworde symbol. code=~a (~a)" code (type-of code))
  (assert (not (get-finder :code code :graph graph))
          (code) "Aledy exists finder. code=~a" code)
  (tx-make-vertex graph 'finder
                  `((code ,code))))

(defun ensure-finder (graph code)
  (or (get-finder :code code :graph graph)
      (%tx-make-finder graph code)))
