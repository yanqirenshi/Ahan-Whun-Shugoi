(in-package :cl-user)
(defpackage ahan-whun-shugoi.html
  (:nicknames :aws.html)
  (:use :cl)
  (:import-from :alexandria
                #:when-let)
  (:import-from :chtml
                #:pt-name
                #:pt-attrs
                #:pt-builder
                #:pt-children
                #:pt-parent)
  (:export #:html2pt
           #:pt-classes
           #:find-tag-target-tag-p
           #:find-tag
           ;;
           #:is-a
           #:is-div
           #:is-h1
           #:id-is
           #:class-is))
(in-package :ahan-whun-shugoi.html)

(defun html2pt (uri)
  (chtml:parse (dex:get uri) (chtml:make-pt-builder)))

(defun pt-classes (tag)
  (let ((classes (getf (pt-attrs tag) :class)))
    (when classes
      (split-sequence:split-sequence #\Space classes))))

(defun find-tag-target-tag-p (tag conds)
  (if (not conds)
      t
      (when (funcall (car conds) tag)
        (find-tag-target-tag-p tag (cdr conds)))))

(defun find-tag (tag &rest conds)
  (if (find-tag-target-tag-p tag conds)
      (list tag)
      (let ((out nil))
        (dolist (child (pt-children tag))
          (when-let ((ret (apply #'find-tag child conds)))
            (setf out (nconc out ret))))
        out)))

(defun is-a (tag)
  (eq :a (pt-name tag)))

(defun is-div (tag)
  (eq :div (pt-name tag)))

(defun is-h1 (tag)
  (eq :h1 (pt-name tag)))

(defun id-is (id tag)
  (let ((attr (pt-attrs tag)))
    (string= id (getf attr :id))))

(defun class-is (class tag)
  (find class (pt-classes tag) :test 'equal))
