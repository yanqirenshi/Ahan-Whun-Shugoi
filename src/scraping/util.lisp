(in-package :ahan-whun-shugoi.scraping)

(defun is-a (tag)
  (eq :a (pt-name tag)))

(defun is-div (tag)
  (eq :div (pt-name tag)))

(defun is-h1 (tag)
  (eq :h1 (pt-name tag)))

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

(defun id-is-examples (tag)
  (id-is tag "examples"))

(defun id-is-output (tag)
  (id-is tag "output"))

(defun id-is-available-services (tag)
  (id-is tag "available-services"))

(defun id-is-available-commands (tag)
  (id-is tag "available-commands"))

(defun find-description-tag (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-description)))

(defun find-synopsis-tag (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-synopsis)))

(defun find-options-tag (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-options)))

(defun find-available-services-tag (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-available-services)))

(defun find-examples-tag (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-examples)))

(defun find-output-tag (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-output)))
