(in-package :ahan-whun-shugoi.scraping)

(defun a-tag2service-plist (tag)
  (list :code (pt-attrs (first (pt-children tag)))
        :uri (getf (pt-attrs tag) :href)))

(defun make-service-uri (services)
  (aws-uri (getf services :uri)))

(defun get-service-html (uri &key (sleep-time 1))
  (let ((html (html2pt uri)))
    (sleep sleep-time)
    html))

(defun html2service-code (html)
  (let* ((h1 (car (find-tag html #'is-h1)))
         (children (pt-children h1)))
    (pt-attrs (first children))))

(defun html2service (uri html)
  (make-instance 'service
                 :code (html2service-code html)
                 :description (find-description-tag html)
                 :uri uri))

(defun make-service (aws html uri)
  (let ((service (html2service uri html)))
    (list "make-r" aws service)
    service))

(defun find-service-commands (html uri)
  (let ((section (car (find-tag html
                                #'is-div
                                #'id-is-available-commands))))
    (mapcar #'(lambda (tag)
                (a-tag2command-plist tag uri))
            (find-tag section
                      #'is-a
                      #'class-is-reference
                      #'class-is-internal))))

(defun find-services (aws services)
  (dolist (service services)
    (let* ((uri (make-service-uri service))
           (html (get-service-html uri))
           (service (make-service aws html uri)))
      (print (code service))
      (unless (string= "wait" (code service))
        (find-commands aws
                       service
                       (find-service-commands html uri))))))
