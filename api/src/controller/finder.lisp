(in-package :ahan-whun-shugoi-api.controller)

(defun get-finder (&key code)
  (aws.beach:get-finder :code code))

(defun update-finder-look-at (finder look-at)
  (up:execute-transaction
   (up:tx-change-object-slots *graph*
                              (class-name (class-of finder))
                              (up:%id finder)
                              `((aws.beach::look-at ,look-at))))
  finder)

(defun update-finder-scale (finder scale)
  (up:execute-transaction
   (up:tx-change-object-slots *graph*
                              (class-name (class-of finder))
                              (up:%id finder)
                              `((aws.beach::scale ,scale))))
  finder)
