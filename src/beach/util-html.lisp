(in-package :aws.beach)

(defun class-is-section (tag)
  (class-is "section" tag))

(defun class-is-reference (tag)
  (class-is "reference" tag))

(defun class-is-internal (tag)
  (class-is "internal" tag))

(defun id-is-description (tag)
  (let ((attr (pt-attrs tag)))
    (string= "description" (getf attr :id))))

(defun id-is-synopsis (tag)
  (id-is "synopsis" tag))

(defun id-is-options (tag)
  (id-is "options" tag))

(defun id-is-examples (tag)
  (id-is "examples" tag))

(defun id-is-output (tag)
  (id-is "output" tag))

(defun id-is-available-services (tag)
  (id-is "available-services" tag))

(defun id-is-available-subcommands (tag)
  (id-is "available-commands" tag))

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

(defun get-code-from-h1-tag (html)
  (let* ((h1 (car (find-tag html #'is-h1)))
         (children (pt-children h1)))
    (str2keyword (pt-attrs (first children)))))
