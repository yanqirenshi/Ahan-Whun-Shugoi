(in-package :aws-beach)

;;;
;;; html
;;;
(defun a-tag2command-plist (tag)
  (list :code (pt-attrs (first (pt-children tag)))
        :uri (getf (pt-attrs tag) :href)))

(defun make-command-uri (command)
  (aws-uri (getf command :uri)))

(defun get-command-html (uri &key (sleep-time *get-uri-interval-time*))
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
  "取得した HTML を元に Vertex:Command の内容を更新する。"
  (declare (ignore html graph))
  (warn "tx-update-command-by-html がまだ実装されていません。")
  command)

(defun tx-make-r-aws-command (graph aws command)
  "Vertex:AWS と Vertex:Command の Edge を作成する。"
  (let ((class 'r-aws2commands))
    (or (get-r graph class :from aws command :r)
        (tx-make-edge graph class aws command :r))))

(defun tx-html2command (graph uri html)
  "取得した HTML を元に Vertex:Command を作成する。
既に存在する場合は全項目の内容を上書きする。"
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
  "Vertex:Command を作成し、Vertex:AWS との Edge を作成する。"
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
