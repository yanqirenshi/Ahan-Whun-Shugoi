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

(defun tx-update-subcommand (graph subcommand html)
  (declare (ignore graph html))
  (warn "tx-update-subcommand がまだ実装されていません。")
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
                            (description ,(pt2html (find-description-tag html)))
                            (synopsis    ,(pt2html (find-synopsis-tag html)))
                            (uri ,uri)
                            (lock ,(subcommand-default-lock-p code))))))))

(defun tx-make-r-command-subcommand (graph command subcommand)
  (let ((class 'r-command2subcommands))
    (or (get-r graph class :from command subcommand :r)
        (tx-make-edge graph class command subcommand :r))))

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
(defun find-subcommands (aws command subcommands)
  (declare (ignore aws))
  (dolist (subcommand subcommands)
    (let* ((uri (getf subcommand :uri))
           (html (get-subcommand-html uri)))
      (unless (string= "wait" (getf subcommand :code))
        (let ((subcommand  (make-subcommand command html)))
          (add-options subcommand
                       (make-options-plist subcommand html)))))))
