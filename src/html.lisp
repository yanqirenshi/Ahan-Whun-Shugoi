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
           #:find-tag))
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
