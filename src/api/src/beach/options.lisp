(in-package :ahan-whun-shugoi-api.controller)

(defun make-response-option (option)
  (list :option option
        :parent-relationships (shinra:find-r-edge *graph* 'aws.beach::r-subcommand2options :to option)))

(defun get-option-at-%id (%id)
  (get-vertex-at-%id 'aws.beach::option %id))

(defun get-option (&key %id)
  (when %id
    (get-vertex-at-%id 'aws.beach::option %id)))

(defun find-options-at-displayed ()
  ;; なんかくせぇ!! このコード。
  (let ((nodes nil)
        (edges nil))
    (dolist (option (aws.beach::find-option :graph *graph*))
      (when (slot-value option 'aws.beach::display)
        (let ((r-list (shinra:find-r-edge *graph* 'aws.beach:r-subcommand2options
                                          :to option
                                          :vertex-class 'aws.beach::subcommand)))
          (dolist (r r-list)
            (let ((node option)
                  (edge r))
              (push node nodes)
              (push edge edges))))))
    (list :nodes nodes :edges edges)))
