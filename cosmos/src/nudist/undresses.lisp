(in-package :ahan-whun-shugoi.cosmos.nudist)

(defun undress (plist dress)
  (let* ((mode (getf dress :mode))
         (value (getf dress :indicator))
         (operator (getf dress :operator)))
    (cond ((eq :single mode)
           (getf plist value))
          ((eq :multiple mode)
           (mapcar #'(lambda (x) (getf x value)) plist))
          ((eq :apply mode)
           (apply operator plist)))))

(defun undresses (plist dresses)
  (if (null dresses)
      plist
      (undresses (undress plist (car dresses))
                (cdr dresses))))
