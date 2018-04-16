(in-package :aws-beach)

;;;
;;; html
;;;
(defun a-tag2subcommand-plist (option-tag command-uri)
  (list :code (pt-attrs (first (pt-children option-tag)))
        :uri (make-aws-cli-uri :subcommand command-uri (pt-attrs option-tag))))


(defun get-subcommand-html (uri &key (sleep-time *get-uri-interval-time*))
  (let ((html (uri2pt uri)))
    (sleep sleep-time)
    html))

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
    (find-r-vertex graph 'r-subcommand2options
                   :from subcommand
                   :edge-type :r
                   :vertex-class 'option)))

(defun subcommand-key-values (html uri)
  (let ((code (get-code-from-h1-tag html)))
    `((code        ,code)
      (description ,(pt2html (find-description-tag html)))
      (synopsis    ,(pt2html (find-synopsis-tag html)))
      (uri         ,uri)
      (lock        ,(subcommand-default-lock-p code)))))

(defun get-command-subcommand (graph command subcommand-code)
  (find-if #'(lambda (subcommand)
               (eq (code subcommand) subcommand-code))
           (find-r-vertex graph 'r-command2subcommands :from command)))

(defun %tx-make-subcommand (graph command html &key uri)
  (when html
    (let* ((code (get-code-from-h1-tag html))
           (subcommand (get-command-subcommand command code :graph graph))
           (slot-values (subcommand-key-values html uri)))
      (if (not subcommand)
          (tx-make-vertex graph 'subcommand slot-values)
          (up:tx-change-object-slots graph 'subcommand (up:%id subcommand) slot-values)))))

(defun tx-make-r-command-subcommand (graph command subcommand)
  (let ((class 'r-command2subcommands))
    (values subcommand
            (or (get-r graph class :from command subcommand :r)
                (tx-make-edge graph class command subcommand :r)))))

(defun tx-make-subcommand (graph command subcommand-html uri)
  (let ((subcommand (%tx-make-subcommand graph command subcommand-html :uri uri)))
    (tx-make-r-command-subcommand graph command subcommand)
    subcommand))

(defun make-subcommand (command subcommand-html uri)
  (up:execute-transaction
   (tx-make-subcommand *graph* command subcommand-html uri)))

;;;
;;; find-subcommands
;;;
(defun find-subcommands (command subcommands)
  (dolist (subcommand subcommands)
    (unless (string= "wait" (getf subcommand :code))
      (let* ((uri (getf subcommand :uri))
             (html (get-subcommand-html uri)))
        (add-options (make-subcommand command html uri)
                     (make-options-plist html))))))

;;;
;;; lock
;;;
(defgeneric lock-p (obj)
  (:method ((obj subcommand))
    (lock obj)))
