(in-package :cl-user)
(defpackage ahan-whun-shugoi.scraping
  (:nicknames :aws)
  (:use :cl)
  (:export #:start
           #:stop
           #:graph-data-stor
           ;; s3
           #:name))
(in-package :ahan-whun-shugoi.scraping)

(defun html2list (uri)
  (chtml:parse (dex:get uri) (chtml:make-lhtml-builder)))

(defun tag-p (o)
  (and (listp o)
       (keywordp (car o))))

(defun tag-name (tag)
  (assert  (tag-p tag))
  (first tag))

(defun tag-attrs (tag)
  (assert  (tag-p tag))
  (second tag))

(defun tag-contents (tag)
  (assert  (tag-p tag))
  (cddr tag))

(defun tag-classes (tag)
  (assert  (tag-p tag))
  (let ((classes (assoc :CLASS (tag-attrs tag))))
    (when classes
      (split-sequence:split-sequence #\Space (second classes)))))

(defun find-tag (tag)
  "
 ex) (find-tag (html2list "https://docs.aws.amazon.com/ja_jp/cli/latest/reference/index.html#options"))
"
  (when (and tag (tag-p tag))
    (let ((classes (tag-classes tag))
          (contents (tag-contents tag)))
      (if (and (find "toctree-wrapper" classes :test 'equal)
               (find "compound" classes :test 'equal))
          (print tag)
          (dolist (child-tag contents)
            (xxx child-tag))))))
