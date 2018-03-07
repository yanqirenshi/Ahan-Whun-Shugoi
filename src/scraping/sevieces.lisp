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
(defun get-service (&key code (graph *graph*))
  (when code
    (car (shinra:find-vertex graph 'service
                             :slot 'code
                             :value code))))

(defun get-service-command (service command-code &key (graph *graph*))
  (when (and service command-code)
    (find-if #'(lambda (cmd)
                 (eq command-code (code cmd)))
             (shinra:find-r-vertex graph 'r-services2commands
                                   :from service
                                   :edge-type :r
                                   :vertex-class 'command))))

(defun tx-update-service-by-html (graph server html)
  (declare (ignore html graph))
  server)

(defun tx-make-r-aws-service (graph aws service)
  (let ((class 'r-aws2services))
    (or (get-r graph class :from aws service :r)
        (make-edge graph class aws service :r))))

(defun tx-html2service (graph uri html)
  (let* ((code (ensure-keyword (get-code-from-h1-tag html)))
         (service (get-service :code code :graph graph)))
    (if service
        (tx-update-service-by-html graph service html)
        (progn
          (shinra:tx-make-vertex graph 'service
                                 `((code ,code)
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
