(in-package :ahan-whun-shugoi.scraping)

;;;
;;; finder conditions
;;;
(defun is-a (tag)
  (eq :a (pt-name tag)))

(defun is-div (tag)
  (eq :div (pt-name tag)))

(defun class-is-section (tag)
  (find "section" (pt-classes tag) :test 'equal))

(defun class-is-reference (tag)
  (find "reference" (pt-classes tag) :test 'equal))

(defun class-is-internal (tag)
  (find "internal" (pt-classes tag) :test 'equal))

(defun id-is (tag id)
  (let ((attr (pt-attrs tag)))
    (string= id (getf attr :id))))

(defun id-is-description (tag)
  (let ((attr (pt-attrs tag)))
    (string= "description" (getf attr :id))))

(defun id-is-synopsis (tag)
  (id-is tag "synopsis"))

(defun id-is-options (tag)
  (id-is tag "options"))

(defun id-is-available-services (tag)
  (id-is tag "available-services"))

(defun find-description (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-description)))

(defun find-synopsis (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-synopsis)))

(defun find-options (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-options)))

(defun find-available-services (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-available-services)))
