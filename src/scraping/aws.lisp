(in-package :ahan-whun-shugoi.scraping)

(defclass aws ()
  ((description :accessor description
                :initarg :description
                :initform nil)
   (synopsis :accessor synopsis
             :initarg :synopsis
             :initform nil)
   (options :accessor options
            :initarg :options
            :initform nil)))

(defun find-aws-services (html)
  (find-tag html
            #'is-a
            #'class-is-reference
            #'class-is-internal))

(defun find-aws (&key (uri (root-uri)))
  (let ((html (html2pt uri)))
    (values (make-instance 'aws
                           :description (find-description html)
                           :synopsis    (find-synopsis html)
                           :options     (find-options html))
            (mapcar #'a-tag2service
                    (find-aws-services (find-available-services html))))))

(defun collect (&key (uri (root-uri)))
  (multiple-value-bind (aws services)
      (find-aws :uri uri)
    (find-services aws services)))
