(in-package :ahan-whun-shugoi-api.controller)

(defclass subcommand (aws.beach::subcommand)
  ((children-display :accessor children-display  :initarg :children-display  :initform nil))
  (:documentation ""))

(defun subcommand2subcommand (subcommand_in)
  (let ((subcommand_out (make-instance 'subcommand)))
    (setf (slot-value subcommand_out 'up:%id)                  (slot-value subcommand_in 'up:%id))
    (setf (slot-value subcommand_out 'aws.beach::code)         (slot-value subcommand_in 'aws.beach::code))
    (setf (slot-value subcommand_out 'aws.beach::description)  (slot-value subcommand_in 'aws.beach::description))
    (setf (slot-value subcommand_out 'aws.beach::uri)          (slot-value subcommand_in 'aws.beach::uri))
    (setf (slot-value subcommand_out 'aws.beach::location)     (slot-value subcommand_in 'aws.beach::location))
    (setf (slot-value subcommand_out 'aws.beach::display)      (slot-value subcommand_in 'aws.beach::display))
    (setf (slot-value subcommand_out 'aws.beach::stroke)       (slot-value subcommand_in 'aws.beach::stroke))
    (setf (slot-value subcommand_out 'children-display)        (mapcar #'aws.beach::option2response-display
                                                                    (find-subcommand-options subcommand_in)))
    subcommand_out))


(defmethod jojo:%to-json ((obj subcommand))
  (jojo:with-object
    (jojo:write-key-value "_id"              (slot-value obj 'up:%id))
    (jojo:write-key-value "code"             (slot-value obj 'aws.beach::code))
    (jojo:write-key-value "name"             (slot-value obj 'aws.beach::code))
    (jojo:write-key-value "description"      (slot-value obj 'aws.beach::description))
    (jojo:write-key-value "uri"              (slot-value obj 'aws.beach::uri))
    (jojo:write-key-value "location"         (slot-value obj 'aws.beach::location))
    (jojo:write-key-value "display"          (let ((v (slot-value obj 'aws.beach::display)))
                                               (or v :false)))
    (jojo:write-key-value "stroke"           (slot-value obj 'aws.beach::stroke))
    (jojo:write-key-value "children_display" (slot-value obj 'children-display))
    (jojo:write-key-value "_class"           "SUBCOMMAND")))


(defun make-response-subcommand (subcommand)
  (list :subcommand subcommand
        :options (mapcar #'aws.beach::option2response-display (find-subcommand-options subcommand))
        :parent-relationships (shinra:find-r-edge *graph* 'aws.beach:r-command2subcommands :to subcommand)))

(defun get-subcommand (&key %id)
  (get-vertex-at-%id 'aws.beach::subcommand %id))

(defun get-subcommand-at-%id (%id)
  (let ((subcommand (get-vertex-at-%id 'aws.beach::subcommand %id)))
    (list :subcommand subcommand
          :options (find-subcommand-options subcommand))))

(defun find-subcommand-options (subcommand)
  (shinra:find-r-vertex *graph* 'aws.beach::r-subcommand2options :from subcommand))

(defun find-subcommands ()
  (let ((nodes (shinra:find-vertex *graph* 'aws.beach::subcommand)))
    (list :nodes nodes
          ;; TODO: きったねぇなぁ。
          :relationships (list :nodes (apply #'nconc (mapcar #'(lambda (node)
                                                                 (shinra:find-r-vertex *graph*
                                                                                       'aws.beach:r-subcommand2options
                                                                                       :from node))
                                                             nodes))
                               :edges (apply #'nconc (mapcar #'(lambda (node)
                                                                 (shinra:find-r-edge *graph*
                                                                                     'aws.beach:r-subcommand2options
                                                                                     :from node))
                                                             nodes))))))

(defun find-subcommands-at-displayed ()
  ;; くせぇ!! このコード。
  (let ((commands (find-commands))
        (nodes nil)
        (edges nil))
    (dolist (command commands)
      (let ((r-list (shinra:find-r *graph* 'aws.beach:r-command2subcommands
                                   :from command
                                   :vertex-class 'aws.beach::subcommand)))
        (dolist (r r-list)
          (let ((node (getf r :vertex))
                (edge (getf r :edge)))
            (when (slot-value node 'aws.beach::display)
              (push (subcommand2subcommand node) nodes)
              (push edge edges))))))
    (list :nodes nodes :edges edges)))

(defun to-parent-edge-class (to-class)
  (cond ((eq to-class 'aws.beach:command) 'aws.beach:r-aws2commands)
        ((eq to-class 'aws.beach::subcommand) 'aws.beach:r-command2subcommands)
        ((eq to-class 'aws.beach::option) 'aws.beach:r-subcommand2options)
        (t (error "むーん"))))

(defun update-node-display (node value)
  (let* ((class (class-name (class-of node)))
         (edge-class (to-parent-edge-class class))
         (relashonship (shinra:find-r *graph* edge-class :to node)))
    (up:execute-transaction
     (up:tx-change-object-slots *graph* class (up:%id node)
                                `((aws.beach:display ,value))))
    (list :node node
          :parent (first (mapcar #'(lambda (r)
                                     (list :node (getf r :vertex)
                                           :edge (getf r :edge)))
                                 relashonship)))))

(defun update-subcommand-display (command value)
  (unless command (caveman2:throw-code 404))
  (update-node-display command value))
