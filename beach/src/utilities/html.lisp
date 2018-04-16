(in-package :cl-user)
(defpackage ahan-whun-shugoi-beach.util.html
  (:nicknames :aws.beach.util.html)
  (:use #:cl
        #:closure-html-adapter
        #:aws.beach.util)
  (:import-from :chtml
                #:pt-attrs
                #:pt-children)
  (:export #:class-is-section
           #:class-is-reference
           #:class-is-internal
           #:id-is-description
           #:id-is-synopsis
           #:id-is-options
           #:id-is-examples
           #:id-is-output
           #:id-is-available-services
           #:id-is-available-subcommands
           #:find-description-tag
           #:find-synopsis-tag
           #:find-options-tag
           #:find-available-services-tag
           #:find-available-service-tags
           #:find-examples-tag
           #:find-output-tag
           #:get-code-from-h1-tag))
(in-package :ahan-whun-shugoi-beach.util.html)

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

(defun class-is-toctree-l1 (tag)
  (let ((attr (pt-attrs tag)))
    (string= "toctree-l1" (getf attr :class))))

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

(defun find-available-service-tags (html)
  (find-tag (find-available-services-tag html)
            #'is-li
            #'class-is-toctree-l1))


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
