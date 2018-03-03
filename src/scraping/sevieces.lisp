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

(defun get-service (&key code)
  (car (shinra:find-vertex *graph* 'service
                            :slot 'code
                            :value code)))

(defun update-service-by-html (server html)
  (declare (ignore html))
  server)

(defun html2service (uri html)
  (let ((service (get-service :code (html2service-code html))))
    (if service
        (update-service-by-html service html)
        (execute-transaction
         (shinra:tx-make-vertex *graph* 'service
                                `((code ,(html2service-code html))
                                  (uri ,uri)))))))

(defun make-r-aws-service (aws service)
  (or (get-r *graph* 'r-services :from aws service :r)
      (execute-transaction
       (make-edge *graph* 'r-services
                  aws service
                  :r))))

(defun make-service (aws html uri)
  (let ((service (html2service uri html)))
    (make-r-aws-service aws service)
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
      (unless (string= "wait" (code service))
        (find-commands aws
                       service
                       (find-service-commands html uri))))))
