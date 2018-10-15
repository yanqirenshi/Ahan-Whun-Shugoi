(in-package :ahan-whun-shugoi-api.controller)

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
          :relashonships (mapcar #'(lambda (r)
                                     (list :node (getf r :vertex)
                                           :edge (getf r :edge)))
                                 relashonship))))

(defun update-subcommand-display (command value)
  (unless command (caveman2:throw-code 404))
  (update-node-display command value))
