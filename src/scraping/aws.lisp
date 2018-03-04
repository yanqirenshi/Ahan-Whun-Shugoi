(in-package :ahan-whun-shugoi.scraping)

(defun find-aws-services (html)
  (find-tag html
            #'is-a
            #'class-is-reference
            #'class-is-internal))

(defun make-aws (html)
  (declare (ignore html))
  (or (car (shinra:find-vertex *graph* 'aws))
      (execute-transaction
       (tx-make-vertex *graph*
                       'aws
                       `((code "aws")
                         ;; (description ,(find-description-tag html))
                         ;; (synopsis    ,(find-synopsis-tag html))
                         ;; (options     ,(find-options-tag html))
                         )))))

(defun find-aws (&key (uri (root-uri)))
  (let ((html (html2pt uri)))
    (values (make-aws html)
            (mapcar #'a-tag2service-plist
                    (find-aws-services (find-available-services-tag html))))))

(defun split-sequence-at (seq count)
  (when seq
    (if (< (length seq) count)
        (list seq)
        (cons (subseq seq 0 count)
              (split-sequence-at (subseq seq count) count)))))

;; (setf *kernel* (make-kernel 4))
;; (defun collect (&key (uri (root-uri)))
;;   (multiple-value-bind (aws services)
;;       (find-aws :uri uri)
;;     (let ((sp (split-sequence-at services 34)))
;;       (plet ((a (find-services aws (first sp)))
;;                        (b (find-services aws (second sp)))
;;                        (c (find-services aws (third sp)))
;;                        (d (find-services aws (fourth sp))))
;;         (nconc a b c d)))))

(defun collect (&key (uri (root-uri)))
  (multiple-value-bind (aws services)
      (find-aws :uri uri)
    (find-services aws services)))
