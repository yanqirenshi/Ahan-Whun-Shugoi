(in-package :ahan-whun-shugoi)

(defun mapline (func text)
  (let ((out nil))
    (with-input-from-string (stream text)
      (do ((line (read-line stream nil 'eof)
                 (read-line stream nil 'eof)))
          ((eq line 'eof) out)
        (push (funcall func line) out)))))

(defun servicep (service)
  (find service '(:s3 :elb :ec2)))

(defun make-aws-command (service &rest option)
  (format nil "aws ~a ~a"
          (string-downcase (symbol-name service))
          (first option)))

(defun valudation-service (service)
  (unless (servicep service)
    (error "not supported service. service=~a" service)))

(defun aws (service &rest options)
  (valudation-service service)
  (let ((cmd (apply #'make-aws-command service options)))
    (print cmd)
    (multiple-value-bind (values output error-output exit-status)
        (trivial-shell:shell-command cmd)
      (declare (ignore output error-output exit-status))
      values)))


'(:s3 ((:cp (:--dryrun
             :--quiet
             :--include
             :--exclude
             :--acl
             :--follow-symlinks
             :--no-follow-symlinks
             :--no-guess-mime-type
             :--sse
             :--storage-class
             :--grants
             :--website-redirect
             :--content-type
             :--cache-control
             :--content-disposition
             :--content-encoding
             :--content-language
             :--expires
             :--source-region
             :--only-show-errors
             :--page-size
             :--metadata-directive
             :--expected-size
             :--recursive)) 
       (:ls (:--recursive :--page-size :--human-readable :--summarize) 
       (:mb)
        (:mv (:--dryrun
              :--quiet
              :--include
              :--exclude
              :--acl
              :--follow-symlinks
              :--no-follow-symlinks
              :--no-guess-mime-type
              :--sse
              :--storage-class
              :--grants
              :--website-redirect
              :--content-type
              :--cache-control
              :--content-disposition
              :--content-encoding
              :--content-language
              :--expires
              :--source-region
              :--only-show-errors
              :--page-size
              :--metadata-directive
              :--recursive) 
       (:rb (:--force)
        :rm (:--dryrun
             :--quiet
             :--recursive
             :--include
             :--exclude
             :--only-show-errors
             :--page-size)
        (:sync (:--dryrun
                :--quiet
                :--include
                :--exclude
                :--acl
                :--follow-symlinks 
                :--no-follow-symlinks
                :--no-guess-mime-type
                :--sse
                :--storage-class
                :--grants
                :--website-redirect
                :--content-type
                :--cache-control
                :--content-disposition
                :--content-encoding
                :--content-language
                :--expires
                :--source-region
                :--only-show-errors
                :--page-size
                :--size-only
                :--exact-timestamps
                :--delete)
         (:website (:--index-document
                    :--error-document))))))))
