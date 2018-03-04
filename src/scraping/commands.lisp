(in-package :ahan-whun-shugoi.scraping)

;;;
;;; find-commands
;;;
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

(defun html2service-code (html)
  (let* ((h1 (car (find-tag html #'is-h1)))
         (children (pt-children h1)))
    (pt-attrs (first children))))

(defun get-command (&key code)
  (shinra:find-vertex *graph* 'command
                      :slot 'code
                      :value code))

(defun update-command (command html)
  (declare (ignore html))
  command)

(defun make-command (html &key uri)
  (when html
    (let* ((code (html2service-code html))
           (command (car (get-command :code code))))
      (if command
          (update-command command html)
          (execute-transaction
           (tx-make-vertex *graph*
                           'command
                           `((code ,code)
                             ;; (description ,(find-description-tag html))
                             ;; (synopsis    ,(prse-synopsis (find-synopsis-tag html)))
                             ;; (examples    ,(find-examples-tag html))
                             ;; (output      ,(find-output-tag html))
                             (uri ,uri)
                             )))))))

(defun find-command-options (html)
  (find-options-tag html))

(defun make-r-service-command (service command)
  (or (shinra:get-r *graph* 'r-commands :from service command :r)
      (execute-transaction
       (shinra:tx-make-edge *graph* 'r-commands
                            service command :r))))

(defun find-commands (aws service commands)
  (declare (ignore aws))
  (dolist (command commands)
    (let* ((uri (getf command :uri))
           (html (get-command-html uri)))
      (unless (string= "wait" (getf command :code))
        (let ((command (make-command html :uri uri))
              (synopsis (prse-synopsis (find-synopsis-tag html)))
              (options (mapcar #'option-tag2plist
                               (find-option-tags (find-options-tag html)))))
          (make-r-service-command service command)
          ;; (format t "~a: ~a = ~a ⇒ ~a~%" (code command) (length synopsis) (length options)
          ;;         (= (length synopsis) (length options)))
          (unless (= (length synopsis) (length options))
            (push (list :command command :synopsis synopsis :options options)
                  *tmp*)))))))

;; create-profile

;; synopsis をパース
;; options をパース
;; synopsis を元に options から値の型を取得する。
;; options を make する。
