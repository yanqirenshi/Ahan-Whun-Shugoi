(in-package :ahan-whun-shugoi.scraping)

;;;
;;; html
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

(defun find-command-options (html)
  (find-options-tag html))

;;;
;;; merge-synopsis&options
;;;
(defun squeeze-code (plists)
  (when plists
    (let ((plist (car plists)))
      (cons (getf plist :code)
            (squeeze-code (cdr plists))))))

(defun make-code-lsit (synopsis options)
  (remove-duplicates (merge 'list
                            (squeeze-code synopsis)
                            (squeeze-code options)
                            #'string<)
                     :test 'equal))

(defun get-plist-rec-at-code (code plists)
  (find-if #'(lambda (plist)
               (string= code (getf plist :code)))
           plists))

(defun %merge-synopsis&options (code-list synopsis options)
  (when code-list
    (let* ((code (car code-list))
           (synopsis-data (get-plist-rec-at-code code synopsis))
           (options-data (get-plist-rec-at-code code options)))
      (if (not (and synopsis-data options-data))
          (%merge-synopsis&options (cdr code-list) synopsis options)
          (cons (list :code        (alexandria:make-keyword (string-upcase (getf options-data :code)))
                      :value-types (getf options-data :value-types)
                      :attrs       (getf synopsis-data :attrs)
                      :require     (getf synopsis-data :require))
                (%merge-synopsis&options (cdr code-list) synopsis options))))))


(defun merge-synopsis&options (synopsis options)
  (%merge-synopsis&options (make-code-lsit synopsis options)
                           synopsis
                           options))
;;;
;;; DB(shinra)
;;;
(defun get-command (graph &key code)
  (shinra:find-vertex graph 'command
                      :slot 'code
                      :value code))

(defun tx-update-command (graph command html)
  (declare (ignore graph html))
  command)


(defun %tx-make-command (graph html &key uri)
  (when html
    (let* ((code (html2service-code html))
           (command (car (get-command graph :code code))))
      (if command
          (tx-update-command graph command html)
          (tx-make-vertex graph
                          'command
                          `((code ,code)
                            (uri ,uri)))))))

(defun tx-make-r-service-command (graph service command)
  (or (shinra:get-r graph 'r-commands :from service command :r)
      (shinra:tx-make-edge graph 'r-commands
                           service command :r)))

(defun tx-make-command (graph service command-html)
  (let ((command (%tx-make-command graph command-html)))
    (tx-make-r-service-command graph service command)
    command))

(defun make-command (service command-html &key (graph *graph*))
  (up:execute-transaction
   (tx-make-command graph service command-html)))

;;;
;;; find-commands
;;;
(defun warn-unmutch-options (command synopsis options)
  (warn "~2a = ~2a ⇒ ~a : ~a~%"
        (length synopsis)
        (length options)
        (= (length synopsis) (length options))
        (code command)))

(defun find-commands (aws service commands)
  (declare (ignore aws))
  (dolist (command commands)
    (let* ((uri (getf command :uri))
           (html (get-command-html uri)))
      (unless (string= "wait" (getf command :code))
        (let ((command  (make-command service html))
              (synopsis (prse-synopsis (find-synopsis-tag html)))
              (options  (prse-options (find-options-tag html))))
          (if (= (length synopsis) (length options))
              (add-options command
                           (merge-synopsis&options synopsis options))
              (warn-unmutch-options command synopsis options)))))))
