(in-package :cl-user)
(defpackage ahan-whun-shugoi.util.html
  (:nicknames :aws.util.html)
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
           #:uri2pt
           #:pt2html
           #:pt-classes
           #:find-tag-target-tag-p
           #:find-tag
           ;;
           #:is-p
           #:is-a
           #:is-span
           #:is-div
           #:is-h1
           #:is-pre
           #:is-pcdata
           #:id-is
           #:class-is))
(in-package :ahan-whun-shugoi.util.html)


(defun html2pt (html)
  (chtml:parse html (chtml:make-pt-builder)))

(defun uri2pt (uri)
  (html2pt (dex:get uri)))

(defun pt2html (pt)
  (chtml:serialize-pt pt (chtml:make-string-sink)))

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

(defun is-p (tag)
  (eq :p (pt-name tag)))

(defun is-span (tag)
  (eq :span (pt-name tag)))

(defun is-div (tag)
  (eq :div (pt-name tag)))

(defun is-h1 (tag)
  (eq :h1 (pt-name tag)))

(defun is-pre (tag)
  (eq :pre (pt-name tag)))

(defun is-pcdata (tag)
  (eq :pcdata (pt-name tag)))

(defun id-is (id tag)
  (let ((attr (pt-attrs tag)))
    (string= id (getf attr :id))))

(defun class-is (class tag)
  (find class (pt-classes tag) :test 'equal))
