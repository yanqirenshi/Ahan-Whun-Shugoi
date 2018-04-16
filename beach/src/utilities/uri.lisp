(defpackage ahan-whun-shugoi-beach.util.uri
  (:nicknames :aws.beach.util.uri)
  (:use #:cl)
  (:import-from :quri
                #:uri
                #:uri-path
                #:render-uri)
  (:export #:make-aws-cli-uri))
(in-package :ahan-whun-shugoi-beach.util.uri)

(defvar *uri-scheme* "https")
(defvar *uri-host* "docs.aws.amazon.com")
(defvar *uri-base-path* "/ja_jp/cli/latest/reference/")

(defun %make-aws-cli-uri (path)
  (render-uri
   (quri:make-uri :scheme *uri-scheme*
                  :host *uri-host*
                  :path (format nil "~a" (merge-pathnames path *uri-base-path*)))))

(defun make-aws-uri ()
  (%make-aws-cli-uri "index.html"))

(defun make-command-uri (command-a-tag-attributes)
  (%make-aws-cli-uri (getf command-a-tag-attributes :href)))

(defun make-subcommand-uri (command-uri option-plist)
  (let ((uri (uri command-uri)))
    (setf (uri-path uri)
          (namestring
           (merge-pathnames (getf option-plist :href)
                            (quri:uri-path uri))))
    (render-uri uri)))

(defun make-option-uri () nil)

(defvar *make-uri-funcs*
  '((:aws . make-aws-uri)
    (:command . make-command-uri)
    (:subcommand . make-subcommand-uri)
    (:option . make-option-uri)))

(defun get-make-uri-func (type)
  (or (cdr (assoc type *make-uri-funcs*))
      (error "Not supported ~a" type)))

(defun make-aws-cli-uri (type &rest args)
  (apply (get-make-uri-func type) args))
