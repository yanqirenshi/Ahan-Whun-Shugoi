(in-package :cl-user)
(defpackage ahan-whun-shugoi.scraping
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
  (remove-if #'(lambda (v)
                 (and (stringp v)
                      (string= "" (string-trim '(#\Space #\Tab #\Newline) v))))
             (cddr tag)))

(defun tag-classes (tag)
  (assert  (tag-p tag))
  (let ((classes (assoc :CLASS (tag-attrs tag))))
    (when classes
      (split-sequence:split-sequence #\Space (second classes)))))

(defun parent-page-p (tag)
  (let ((classes (tag-classes tag)))
    (and (find "toctree-wrapper" classes :test 'equal)
         (find "compound" classes :test 'equal))))

(defun find-tag (tag)
  "ex) (find-tag (html2list \"https://docs.aws.amazon.com/ja_jp/cli/latest/reference/index.html\"))"
  (when (and tag (tag-p tag))
    (let ((contents (tag-contents tag)))
      (if (parent-page-p tag)
          (list tag)
          (dolist (child-tag contents)
            (find-tag child-tag))))))
