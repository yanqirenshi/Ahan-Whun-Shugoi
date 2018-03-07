(in-package :ahan-whun-shugoi.scraping)

(defun find-aws-services (html)
  (find-tag html
            #'is-a
            #'class-is-reference
            #'class-is-internal))

;;;
;;; DB(shinra)
;;;
(defun get-aws (&key (code :aws))
  (car (shinra:find-vertex *graph* 'aws :slot 'code :value code)))

(defun %tx-make-aws (graph html)
  (declare (ignore html))
  (tx-make-vertex graph
                  'aws
                  `((code :aws)
                    ;; (description ,(find-description-tag html))
                    ;; (synopsis    ,(find-synopsis-tag html))
                    )))

(defun tx-make-r-aws-option (graph aws option)
  (shinra:tx-make-edge graph 'r-aws2options aws option :r))

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

(defun find-aws-options (&key (aws (get-aws)) (graph aws.db::*graph*))
  (when aws
    (shinra:find-r-vertex graph 'r-aws2options
                          :from aws
                          :edge-type :r
                          :vertex-class 'option)))

(defun find-aws (&key (uri (root-uri)))
  (let ((html (html2pt uri)))
    (values (make-aws html)
            (mapcar #'a-tag2service-plist
                    (find-aws-services (find-available-services-tag html))))))

;;;
;;; ???
;;;
(defun split-sequence-at (seq count)
  (when seq
    (if (< (length seq) count)
        (list seq)
        (cons (subseq seq 0 count)
              (split-sequence-at (subseq seq count) count)))))

;;;
;;; collect
;;;
(defun collect (&key (uri (root-uri)))
  (multiple-value-bind (aws services)
      (find-aws :uri uri)
    (find-services aws services)))
