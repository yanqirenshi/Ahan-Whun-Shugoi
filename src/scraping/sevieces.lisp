(in-package :ahan-whun-shugoi.scraping)

;;;
;;; html
;;;
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

;;;
;;; DB(shinra)
;;;
(defun get-service (&key code)
  (car (shinra:find-vertex *graph* 'service
                           :slot 'code
                           :value code)))

(defun tx-update-service-by-html (graph server html)
  (declare (ignore html graph))
  server)

(defun tx-make-r-aws-service (graph aws service)
  (or (get-r graph 'r-services :from aws service :r)
      (make-edge graph 'r-services
                 aws service
                 :r)))

(defun tx-html2service (graph uri html)
  (let ((service (get-service :code (html2service-code html))))
    (if service
        (update-service-by-html service html)
        (progn
          (shinra:tx-make-vertex graph 'service
                                 `((code ,(html2service-code html))
                                   (uri ,uri)))))))

(defun tx-make-service (graph aws html uri)
  (let ((service (tx-html2service graph uri html)))
    (tx-make-r-aws-service graph aws service)
    service))

(defun make-service (aws html uri)
  (up:execute-transaction
   (tx-make-service *graph* aws html uri)))

;;;
;;; FIND-SERVICES
;;;
(defun find-services (aws services)
  (dolist (service services)
    (let* ((uri (make-service-uri service))
           (html (get-service-html uri))
           (service (make-service aws html uri)))
      (unless (string= "wait" (code service))
        (find-commands aws
                       service
                       (find-service-commands html uri))))))
