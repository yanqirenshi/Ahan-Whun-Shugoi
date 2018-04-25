(in-package :ahan-whun-shugoi.cosmos.nudist)

(defun set-value-ignore (plist key)
  (declare (ignore plist key)))

(defun set-value-simple (plist indicator)
  (getf plist indicator))

(defun set-value-tags2alist (plist indicator)
  (tags2alist (getf plist indicator)))

(defun set-value-tags2plist (plist indicator)
  (tags2plists (getf plist indicator)))

(defun set-value-plist2plist (plist indicator)
  (plist2plist (getf plist indicator)))
