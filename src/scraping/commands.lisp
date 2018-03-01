(in-package :ahan-whun-shugoi.scraping)

(defun merge-command-uri (tag uri)
  (let ((uri (quri:uri uri)))
    (setf (quri:uri-path uri)
          (namestring
           (merge-pathnames (getf (pt-attrs tag) :href)
                            (quri:uri-path uri))))
    uri))

(defun a-tag2command-plist (tag uri)
  (list :code (pt-attrs (first (pt-children tag)))
        :uri (merge-command-uri tag uri)))


(defun get-command-html (uri &key (sleep-time 1))
  (let ((html (html2pt uri)))
    (sleep sleep-time)
    html))

(defclass command ()
  ((description :accessor description :initarg :description :initform nil)
   (synopsis    :accessor synopsis    :initarg :synopsis    :initform nil)
   (examples    :accessor examples    :initarg :examples    :initform nil)
   (output      :accessor output      :initarg :output      :initform nil)))

(defun make-command (html)
  (when html
    (make-instance 'command
                   :description (find-description-tag html)
                   :synopsis    (find-synopsis-tag html)
                   :examples    (find-examples-tag html)
                   :output      (find-output-tag html))))

(defun find-command-options (html)
  (find-options-tag html))

(defun find-commands (aws service commands)
  (dolist (command commands)
    (let* ((uri (getf command :uri))
           (html (get-command-html uri)))
      (find-options aws
                    service
                    (make-command html)
                    (find-command-options html)))))
