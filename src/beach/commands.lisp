(in-package :aws.beach)

;;;
;;; html
;;;
(defun a-tag2command-plist (tag)
  (list :code (pt-attrs (first (pt-children tag)))
        :uri (getf (pt-attrs tag) :href)))

(defun make-command-uri (command)
  (aws-uri (getf command :uri)))

(defun get-command-html (uri &key (sleep-time 1))
  (let ((html (uri2pt uri)))
    (sleep sleep-time)
    html))

(defun find-command-subcommands (html uri)
  (let ((section (car (find-tag html
                                #'is-div
                                #'id-is-available-subcommands))))
    (mapcar #'(lambda (tag)
                (a-tag2subcommand-plist tag uri))
            (find-tag section
                      #'is-a
                      #'class-is-reference
                      #'class-is-internal))))

;;;
;;; DB(shinra)
;;;
(defun get-command (&key code (graph *graph*))
  (when code
    (car (find-vertex graph 'command
                      :slot 'code
                      :value code))))

(defun get-command-subcommand (command subcommand-code &key (graph *graph*))
  (when (and command subcommand-code)
    (find-if #'(lambda (cmd)
                 (eq subcommand-code (code cmd)))
             (find-r-vertex graph 'r-command2subcommands
                            :from command
                            :edge-type :r
                            :vertex-class 'subcommand))))

(defun tx-update-command-by-html (graph command html)
  (declare (ignore html graph))
  command)

(defun tx-make-r-aws-command (graph aws command)
  (let ((class 'r-aws2commands))
    (or (get-r graph class :from aws command :r)
        (make-edge graph class aws command :r))))

(defun tx-html2command (graph uri html)
  (let* ((code (ensure-keyword (get-code-from-h1-tag html)))
         (command (get-command :code code :graph graph)))
    (if command
        (tx-update-command-by-html graph command html)
        (progn
          (tx-make-vertex graph 'command
                          `((code ,code)
                            (description ,(pt2html (find-description-tag html)))
                            (uri ,uri)))))))

(defun tx-make-command (graph aws html uri)
  (let ((command (tx-html2command graph uri html)))
    (tx-make-r-aws-command graph aws command)
    command))

(defun make-command (aws html uri)
  (up:execute-transaction
   (tx-make-command *graph* aws html uri)))

;;;
;;; FIND-COMMAND
;;;
(defun find-command (aws commands)
  (dolist (command commands)
    (let* ((uri (make-command-uri command))
           (html (get-command-html uri))
           (command (make-command aws html uri)))
      (unless (string= "wait" (code command))
        (find-subcommands aws
                          command
                          (find-command-subcommands html uri))))))
