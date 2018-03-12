(in-package :ahan-whun-shugoi.scraping)

;;;
;;; html
;;;
(defun merge-subcommand-uri (tag uri)
  (let ((uri (quri:uri uri)))
    (setf (quri:uri-path uri)
          (namestring
           (merge-pathnames (getf (pt-attrs tag) :href)
                            (quri:uri-path uri))))
    uri))

(defun a-tag2subcommand-plist (tag uri)
  (list :code (pt-attrs (first (pt-children tag)))
        :uri (merge-subcommand-uri tag uri)))


(defun get-subcommand-html (uri &key (sleep-time 1))
  (let ((html (html2pt uri)))
    (sleep sleep-time)
    html))

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
          (cons (list :code        (ensure-keyword (getf options-data :code))
                      :value-types (getf options-data :value-types)
                      :attributes  (getf synopsis-data :attributes)
                      :require     (getf synopsis-data :require))
                (%merge-synopsis&options (cdr code-list) synopsis options))))))

(defun merge-synopsis&options (synopsis options)
  (%merge-synopsis&options (make-code-lsit synopsis options)
                           synopsis
                           options))
;;;
;;; DB(shinra)
;;;
(defun get-subcommand (&key code (graph *graph*))
  (when code
    (car (find-vertex graph 'subcommand
                      :slot 'code
                      :value code))))

(defun find-subcommand-options (subcommand &key (graph *graph*))
  (when subcommand
    (shinra:find-r-vertex graph 'r-subcommand2options
                          :from subcommand
                          :edge-type :r
                          :vertex-class 'option)))

(defun tx-update-subcommand (graph subcommand html)
  (declare (ignore graph html))
  subcommand)


(defun %tx-make-subcommand (graph html &key uri)
  (when html
    (let* ((code (get-code-from-h1-tag html))
           (subcommand (get-subcommand :graph graph :code code)))
      (if subcommand
          (tx-update-subcommand graph subcommand html)
          (tx-make-vertex graph
                          'subcommand
                          `((code ,code)
                            (uri ,uri)))))))

(defun tx-make-r-command-subcommand (graph command subcommand)
  (let ((class 'r-command2subcommands))
    (or (shinra:get-r graph class :from command subcommand :r)
        (shinra:tx-make-edge graph class command subcommand :r))))

(defun tx-make-subcommand (graph command subcommand-html)
  (let ((subcommand (%tx-make-subcommand graph subcommand-html)))
    (tx-make-r-command-subcommand graph command subcommand)
    subcommand))

(defun make-subcommand (command subcommand-html)
  (up:execute-transaction
   (tx-make-subcommand *graph* command subcommand-html)))

;;;
;;; find-subcommands
;;;
(defun warn-unmutch-options (subcommand synopsis options)
  (warn "~2a = ~2a ⇒ ~a : ~a~%"
        (length synopsis)
        (length options)
        (= (length synopsis) (length options))
        (code subcommand)))

(defun find-subcommands (aws command subcommands)
  (declare (ignore aws))
  (dolist (subcommand subcommands)
    (let* ((uri (getf subcommand :uri))
           (html (get-subcommand-html uri)))
      (unless (string= "wait" (getf subcommand :code))
        (let ((subcommand  (make-subcommand command html))
              (synopsis (prse-synopsis (find-synopsis-tag html)))
              (options  (prse-options (find-options-tag html))))
          (if (= (length synopsis) (length options))
              (add-options subcommand
                           (merge-synopsis&options synopsis options))
              (warn-unmutch-options subcommand synopsis options)))))))
