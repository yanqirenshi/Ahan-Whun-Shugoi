(in-package :aws.beach)

(defparameter *html* (uri2pt "https://docs.aws.amazon.com/ja_jp/cli/latest/reference/logs/get-log-events.html"))

(defparameter *optputs-child-p-tag-types*
  `((:code :field
     :regex "^(.+)\\s+->\\s+\\((.*)\\)$"
     :to-list ,#'(lambda (arr)
                  (list :name (aref arr 0) :types (aref arr 1))))
    (:code :field
     :regex "^\\((.*)\\)$"
     :to-list ,#'(lambda (arr) (list :types (aref arr 0))))
    (:code :description
     :regex "^([\\s\\S])+$"
     :to-list ,#'(lambda (arr) (list :values (aref arr 0))))))

(defun optputs-child-p-tag-type (str &optional (types *optputs-child-p-tag-types*))
  (when types
    (let ((type (car types)))
      (multiple-value-bind (ret arr)
          (cl-ppcre:scan-to-strings (getf type :regex) str)
        (if ret
            (nconc (list :code (getf type :code))
                   (funcall (getf type :to-list) arr))
            (optputs-child-p-tag-type str (cdr types)))))))

(defun optputs-child-tag-type (tag)
  (let ((name (pt-name tag)))
    (cond ((eq :pcdata name) (list :code :garbage))
          ((eq :blockquote name) (list :code :children :children (pt-children tag)))
          ((eq :p name)
           (optputs-child-p-tag-type (pt-attrs (first (pt-children tag)))))
          ((eq :h2 name) (list :code :title)))))


(defun outputs-tag-elements (outputs-tag-children
                                  &optional (element '(:key nil :children nil :description nil)))
  (when outputs-tag-children
    (let ((child (optputs-child-tag-type (car outputs-tag-children))))
      (if (or (eq :GARBAGE (getf child :code))
              (eq :TITLE (getf child :code)))
          (outputs-tag-elements (cdr outputs-tag-children) element)
          (cons child
                (outputs-tag-elements (cdr outputs-tag-children) element))))))


(defun parse-outputs-tag (outputs-tag)
  (let ((elements (outputs-tag-element (pt-children outputs-tag))))
    elements))

;; to be continued:
;; (parse-outputs-tag (find-output-tag *html*))
