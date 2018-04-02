(in-package :ahan-whun-shugoi-api.controller)

(defun get-finder (&key code)
  (car (shinra:find-vertex *graph*
                           'aws-beach::finder
                           :slot 'aws-beach::code
                           :value code)))

(defun update-finder-look-at (finder look-at)
  (print look-at)
  (up:execute-transaction
   (up:tx-change-object-slots *graph*
                              (class-name (class-of finder))
                              (up:%id finder)
                              `((aws-beach::look-at ,look-at))))
  finder)

(defun update-finder-scale (finder scale)
  (up:execute-transaction
   (up:tx-change-object-slots *graph*
                              (class-name (class-of finder))
                              (up:%id finder)
                              `((aws-beach::scale ,scale))))
  finder)
