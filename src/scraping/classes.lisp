(in-package :ahan-whun-shugoi.scraping)

;;;
;;; class
;;;
(defclass aws (shin)
  (description synopsis))

;; aws --> services
;;     --> options
(defclass services (shin) (description))

;; service --> commands
;;         --> options
(defclass command (shin)
  (description synopsis examples output))

(defclass option (shin)
  (description))

(defclass r-services (ra) ())
(defclass r-commands (ra) ())
(defclass r-options (ra) ())
