(in-package :aws.beach)

;;;
;;; html
;;;
(defun a-tag2command-plist (a-tag)
  (list :code (pt-attrs (first (pt-children a-tag)))
        :uri (make-aws-cli-uri :command (pt-attrs a-tag))))

(defun get-command-html (uri &key (sleep-time *get-uri-interval-time*))
  (let ((html (uri2pt uri)))
    (sleep sleep-time)
    html))

(defun find-command-subcommand-tags (html command-uri)
  (let ((section (car (find-tag html
                                #'is-div
                                #'id-is-available-subcommands))))
    (mapcar #'(lambda (tag)
                (a-tag2subcommand-plist tag command-uri))
            (find-tag section
                      #'is-a
                      #'class-is-reference
                      #'class-is-internal))))

;;;
;;; DB(shinra)
;;;
(defun find-commands ()
  (find-vertex *graph* 'command))

(defun get-command (&key %id code (graph *graph*))
  (cond (%id (shinra:get-vertex-at graph 'command :%id %id))
        (code (car (find-vertex graph 'command
                                :slot 'code
                                :value code)))))

(defun find-command-subcommands (command)
  (shinra:find-r-vertex *graph*
                        'r-command2subcommands
                        :from command))

(defun get-command-subcommand (command subcommand-code &key (graph *graph*))
  (when (and command subcommand-code)
    (find-if #'(lambda (cmd)
                 (eq subcommand-code (code cmd)))
             (find-r-vertex graph 'r-command2subcommands
                            :from command
                            :edge-type :r
                            :vertex-class 'subcommand))))

(defun tx-make-r-aws-command (graph aws command)
  "Vertex:AWS と Vertex:Command の Edge を作成する。"
  (let ((class 'r-aws2commands))
    (or (get-r graph class :from aws command :r)
        (tx-make-edge graph class aws command :r))))

(defun command-slot-values (code html uri)
  `((code        ,code)
    (description ,(pt2html (find-description-tag html)))
    (uri         ,uri)))

(defun %tx-make-command (graph html uri)
  "取得した HTML を元に Vertex:Command を作成する。
既に存在する場合は全項目の内容を上書きする。"
  (let* ((code (ensure-keyword (get-code-from-h1-tag html)))
         (command (get-command :code code :graph graph))
         (slot-values (command-slot-values code html uri)))
    (if (not command)
        (tx-make-vertex graph 'command slot-values)
        (up:tx-change-object-slots graph 'command (up:%id command) slot-values))))

(defun tx-make-command (graph aws html uri)
  "Vertex:Command を作成し、Vertex:AWS との Edge を作成する。"
  (let ((command (%tx-make-command graph html uri)))
    (tx-make-r-aws-command graph aws command)
    command))

(defun make-command (aws html uri)
  (up:execute-transaction
   (tx-make-command *graph* aws html uri)))

;;;
;;; FIND-COMMAND
;;;
(defun find-command (aws commands-plists)
  (dolist (command commands-plists)
    (let* ((uri (getf command :uri))
           (html (get-command-html uri)))
      (unless (string= "wait" (getf command :code))
        (find-subcommands (make-command aws html uri)
                          (find-command-subcommand-tags html uri))))))
