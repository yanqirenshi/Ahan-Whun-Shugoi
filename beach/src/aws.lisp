(in-package :aws.beach)

;;;
;;; HTML
;;;
(defun find-aws-commands (html)
  (find-tag html
            #'is-a
            #'class-is-reference
            #'class-is-internal))

(defun parse-aws-service (tag)
  (let ((a-tag (first (pt-children tag))))
    (list :code (alexandria:make-keyword (string-upcase (pt-attrs (first (pt-children a-tag)))))
          :uri (getf (pt-attrs a-tag) :HREF))))

(defun parse-aws-services (html)
  (mapcar #'parse-aws-service
          (find-available-service-tags html)))

;;;
;;; DB(shinra)
;;;
(defun get-aws (&key (code :aws))
  (car (find-vertex *graph* 'aws :slot 'code :value code)))

(defun %tx-make-aws (graph html)
  (tx-make-vertex graph
                  'aws
                  `((code :aws)
                    (services    ,(parse-aws-services html))
                    (description ,(pt2html (find-description-tag html)))
                    (synopsis    ,(pt2html (find-synopsis-tag html))))))

(defun tx-make-r-aws-option (graph aws option)
  (tx-make-edge graph 'r-aws2options aws option :r))

(defun tx-add-aws-options (graph aws options)
  (when options
    (let ((option (tx-make-option graph (car options))))
      (tx-make-r-aws-option graph aws option)
      (tx-add-aws-options graph aws (cdr options)))))

(defun tx-make-aws (graph html)
  (let ((aws (%tx-make-aws graph html)))
    (tx-add-aws-options graph aws
                        (prse-options (find-options-tag html)))
    aws))

(defun make-aws (html)
  (or (get-aws)
      (execute-transaction
       (tx-make-aws *graph* html))))

(defun find-aws-options (aws &key (graph *graph*))
  (when aws
    (find-r-vertex graph 'r-aws2options
                   :from aws
                   :edge-type :r
                   :vertex-class 'option)))

(defun find-aws (&key (uri (make-aws-cli-uri :aws)))
  (let ((html (uri2pt uri)))
    (values (make-aws html)
            (mapcar #'a-tag2command-plist
                    (find-aws-commands (find-available-services-tag html))))))

;;;
;;; ???
;;;
(defun split-sequence-at (seq count)
  "これ、オプションを区切るやつじゃないかな。"
  (when seq
    (if (< (length seq) count)
        (list seq)
        (cons (subseq seq 0 count)
              (split-sequence-at (subseq seq count) count)))))

;;;
;;; collect
;;;
(defun collect-target-commands (commands target)
  (if (eq :all target)
      commands
      (let ((target-list (alexandria:ensure-list target)))
        (remove-if #'(lambda (rec)
                       (not (find (str2keyword (getf rec :code))
                                  target-list)))
                   commands))))

(defun under-the-paving-stone-the-beach (&key (target :all) (uri (make-aws-cli-uri :aws)) refresh)
  (when refresh (aws.beach.db:refresh))
  (multiple-value-bind (aws commands)
      (find-aws :uri uri)
    (find-command aws
                  (collect-target-commands commands target))))

(defvar *aws-beach-collect* nil)

(defun collect-thread (&key (target :all) (uri (make-aws-cli-uri :aws)) refresh)
  (setf *aws-beach-collect*
        (bordeaux-threads:make-thread
         #'(lambda ()
             (let ((start (now)))
               (under-the-paving-stone-the-beach :target target :uri uri :refresh refresh)
               (aws.beach.db:snapshot)
               (break "Finished collect!~%Start= ~a~%End  = ~a~%"
                      start (now))))
         :name "aws-beach-collect")))

(defun collect (&key (target :all) (uri (make-aws-cli-uri :aws)) refresh thread)
  (if thread
      (collect-thread :target target :uri uri :refresh refresh)
      (under-the-paving-stone-the-beach :target target :uri uri :refresh refresh)))
