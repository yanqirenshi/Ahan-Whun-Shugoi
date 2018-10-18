(in-package :ahan-whun-shugoi-api.controller)

(defclass command (aws.beach::command)
  ((children-display :accessor children-display  :initarg :children-display  :initform nil))
  (:documentation ""))

(defun command2command (command_in)
  (let ((command_out (make-instance 'command)))
    (setf (slot-value command_out 'up:%id)                  (slot-value command_in 'up:%id))
    (setf (slot-value command_out 'aws.beach::code)         (slot-value command_in 'aws.beach::code))
    (setf (slot-value command_out 'aws.beach::description)  (slot-value command_in 'aws.beach::description))
    (setf (slot-value command_out 'aws.beach::uri)          (slot-value command_in 'aws.beach::uri))
    (setf (slot-value command_out 'aws.beach::location)     (slot-value command_in 'aws.beach::location))
    (setf (slot-value command_out 'aws.beach::display)      (slot-value command_in 'aws.beach::display))
    (setf (slot-value command_out 'aws.beach::stroke)       (slot-value command_in 'aws.beach::stroke))
    (setf (slot-value command_out 'children-display)        (mapcar #'aws.beach::subcommand2response-display
                                                                    (find-command-subcommands command_in)))
    command_out))


(defmethod jojo:%to-json ((obj command))
  (jojo:with-object
    (jojo:write-key-value "_id"              (slot-value obj 'up:%id))
    (jojo:write-key-value "code"             (slot-value obj 'aws.beach::code))
    (jojo:write-key-value "name"             (slot-value obj 'aws.beach::code))
    (jojo:write-key-value "description"      (slot-value obj 'aws.beach::description))
    (jojo:write-key-value "uri"              (slot-value obj 'aws.beach::uri))
    (jojo:write-key-value "location"         (slot-value obj 'aws.beach::location))
    (jojo:write-key-value "display"          (let ((v (slot-value obj 'aws.beach::display))) (or v :false)))
    (jojo:write-key-value "stroke"           (slot-value obj 'aws.beach::stroke))
    (jojo:write-key-value "children_display" (slot-value obj 'children-display))
    (jojo:write-key-value "_class"           "COMMAND")))


(defun make-response-command (command)
  (let ((parent-relationship (car (shinra:find-r *graph* 'aws.beach:r-aws2commands :to command))))
    (list :command (command2command command)
          :parent (list :node (aws2aws (getf parent-relationship :vertex))
                        :edge (getf parent-relationship :edge)))))

(defun get-command (&key %id)
  (get-vertex-at-%id 'aws.beach:command %id))

(defun get-command-at-%id (%id)
  (let* ((command (get-vertex-at-%id 'aws.beach:command %id))
         (relationships (find-command-subcommands command)))
    (list :node command
          :relationships (list :nodes (getf relationships :nodes)
                               :edges (getf relationships :relationships)))))

(defun find-commands ()
  (shinra:find-vertex *graph* 'aws.beach:command))

(defun %find-commands-at-displayed (r-list &optional nodes edges)
  (let ((r (car r-list)))
    (if (null r)
        (list :nodes nodes :edges edges)
        (let ((node (getf r :vertex))
              (edge (getf r :edge)))
          (if (not (aws.beach::display node))
              (%find-commands-at-displayed (cdr r-list) nodes edges)
              (%find-commands-at-displayed (cdr r-list)
                                           (push (command2command node) nodes)
                                           (push edge edges)))))))

(defun find-commands-at-displayed ()
  (%find-commands-at-displayed (shinra:find-r *graph* 'aws.beach:r-aws2commands
                                              :from (get-aws)
                                              :vertex-class 'aws.beach:command)))

(defun find-command-subcommands (command)
  (shinra:find-r-vertex *graph* 'aws.beach:r-command2subcommands :from command))

(defun update-command-display (_id value)
  (let* ((command (get-command :%id _id))
         (relashonship (car (shinra:find-r *graph* 'aws.beach:r-aws2commands :to command))))
    (unless command (caveman2:throw-code 404))
    (up:execute-transaction
     (up:tx-change-object-slots *graph*
                                'aws.beach:command
                                _id
                                `((aws.beach:display ,value))))
    (list :node command
          :relashonship (list :node (getf relashonship :vertex)
                              :edge (getf relashonship :edge)))))

(defun update-node-location (node location)
  (up:execute-transaction
   (up:tx-change-object-slots *graph*
                              (class-name (class-of node))
                              (up:%id node)
                              `((aws.beach::location ,location))))
  node)
