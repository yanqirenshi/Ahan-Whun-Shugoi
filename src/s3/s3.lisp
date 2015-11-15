(in-package :ahan-whun-sgoi)

;; ex) (aws :s3 "ls")

;;;
;;; s3-root-bucket
;;;
(defun s3-root-bucket-line-p (line)
  "2015-07-29 09:07:41 eb-native-ad-log"
  (multiple-value-bind (ret arr)
      (cl-ppcre:scan-to-strings "^(\\d+-\\d+-\\d+\\s+\\d+:\\d+:\\d+)\\s+(.*)$" line)
    (when ret arr)))

(defun arr2s3-root-bucket (arr &key (graph *graph*))
  (when arr
    (shinra:make-vertex graph 's3-root-bucket
                        `((name ,(aref arr 1))
                          (timestamp ,(aref arr 0))))))

;;;
;;; s3-branch-bucket
;;;
(defun s3-branch-bucket-line-p (line)
  "                           PRE resources/"
  (multiple-value-bind (ret arr)
      (cl-ppcre:scan-to-strings "^\\s+PRE\\s+(.*)/$" line)
    (when ret arr)))

(defun arr2s3-branch-bucket (path arr &key (graph *graph*))
  (when arr
    (shinra:make-vertex graph 's3-branch-bucket
                        `((path ,path)
                          (name ,(aref arr 0))))))

;;;
;;; s3-file
;;;
(defun s3-file-line-p (line)
  "2015-07-15 12:49:26        521 2015196Ydn-production.zip"
  (multiple-value-bind (ret arr)
      (cl-ppcre:scan-to-strings "^(\\d+-\\d+-\\d+\\s+\\d+:\\d+:\\d+)\\s+(\\d+)\\s+(.*)$" line)
    (when ret arr)))

(defun arr2s3-file (path arr &key (graph *graph*))
  (when arr
    (shinra:make-vertex graph 's3-file
                        `((path ,path)
                          (name ,(aref arr 2))
                          (size ,(aref arr 1))
                          (timestamp ,(aref arr 0))))))

(defgeneric s3-file-p (value)
  (:method ((value s3-file)) t)
  (:method (value) nil))

;;;
;;; s3 graph
;;;
(defun make-s3-object-relationship-core (graph parent child)
  (values parent child
          (shinra:make-edge graph 's3-object-relationship parent child :r)))

(defgeneric make-s3-object-relationship (parent child &key graph)
  (:method ((parent s3-root-bucket) (child s3-branch-bucket) &key (graph *graph*))
    (make-s3-object-relationship-core graph parent child))
  (:method ((parent s3-branch-bucket) (child s3-branch-bucket) &key (graph *graph*))
    (make-s3-object-relationship-core graph parent child))
  (:method ((parent s3-root-bucket) (child s3-file) &key (graph *graph*))
    (make-s3-object-relationship-core graph parent child))
  (:method ((parent s3-branch-bucket) (child s3-file) &key (graph *graph*))
    (make-s3-object-relationship-core graph parent child))
  (:method (parent child &key (graph *graph*))
    (warn "Skip make-s3-object-relationship. p=~a, c=~a, g=~a" parent child graph)))


(defun make-s3-path-child (child &key (path-string nil) (graph *graph*))
  (let ((parent (first (shinra:find-r-vertex graph 's3-object-relationship :to child)))
        (current-path-string (concatenate 'string (name child) "/" path-string)))
    (if parent
        (make-s3-path-child parent
                            :path-string current-path-string
                            :graph graph)
        current-path-string)))

(defgeneric make-s3-path (s3-object)
  (:method ((s3-object s3-root-bucket))
    (format nil "s3://~a/" (name s3-object)))
  (:method ((s3-object s3-file))
    (format nil "s3://~a" (make-s3-path-child s3-object)))
  (:method ((s3-object s3-branch-bucket))
    (format nil "s3://~a" (make-s3-path-child s3-object))))

(defun add-s3-child-core (s3-object children)
  (when (and s3-object children)
    (dolist (child children)
      (make-s3-object-relationship s3-object child))
    (values children s3-object)))

(defgeneric add-s3-child (s3-object children)
  (:method ((s3-object s3-root-bucket) children)
    (add-s3-child-core s3-object children))
  (:method ((s3-object s3-branch-bucket) children)
    (add-s3-child-core s3-object children))
  (:method (s3-object children)
    (error "funck'n error. place=add-s3-child: s3-object=~a children=~a" s3-object children)))

(defun load-all-s3-objects (&optional parent)
  (let ((children (aws-s3-ls (or parent :root))))
    (dolist (child children)
      (when child
        (unless (s3-file-p child)
          (load-all-s3-objects child))))))

;;;
;;; s3
;;;
(defun line2s3-object (path l)
  (or (arr2s3-file path (s3-file-line-p l))
      (arr2s3-branch-bucket path (s3-branch-bucket-line-p l))
      (arr2s3-root-bucket (s3-root-bucket-line-p l))
      (warn "Faild parse s3 line. path=~a line=~a " path l)))

(defgeneric aws-s3-ls (path &key recursive page-size human-readable summarize)
  (:method ((path string) &key recursive page-size human-readable summarize)
    (declare (ignore recursive page-size human-readable summarize))
    (let ((args (concatenate 'string "ls " path)))
      (mapline #'(lambda (line) line) (aws :s3 args))))

  (:method ((keyword symbol) &key recursive page-size human-readable summarize)
    (unless (keywordp keyword) (eq keyword :root))
    (mapcar #'line2s3-object
            (aws-s3-ls ""
                       :recursive recursive
                       :page-size page-size
                       :human-readable human-readable
                       :summarize summarize)))
  (:method ((s3-object s3-object) &key recursive page-size human-readable summarize)
    (add-s3-child s3-object
                  (mapcar #'line2s3-object
                          (aws-s3-ls (make-s3-path s3-object)
                                     :recursive recursive
                                     :page-size page-size
                                     :human-readable human-readable
                                     :summarize summarize)))))

(defun make-s3-path(obj)
  (let ((path (path obj)))
    (concatenate 'string path (name obj))))

