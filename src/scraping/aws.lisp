(in-package :ahan-whun-shugoi.scraping)

(defun html2pt (uri)
  (chtml:parse (dex:get uri) (chtml:make-pt-builder)))

(defun pt-classes (tag)
  (let ((classes (getf (pt-attrs tag) :class)))
    (when classes
      (split-sequence:split-sequence #\Space classes))))

(defun find-tag-target-tag-p (tag conds)
  (if (not conds)
      t
      (when (funcall (car conds) tag)
        (find-tag-target-tag-p tag (cdr conds)))))

(defun find-tag (tag &rest conds)
  (if (find-tag-target-tag-p tag conds)
      (list tag)
      (let ((out nil))
        (dolist (child (pt-children tag))
          (when-let ((ret (apply #'find-tag child conds)))
            (setf out (nconc out ret))))
        out)))


;;;
;;; top page (aws command)
;;;
(defun find-root (&key (uri "https://docs.aws.amazon.com/ja_jp/cli/latest/reference/index.html"))
  (find-tag (html2pt uri)
            (lambda (tag)
              (eq :a (pt-name tag)))
            (lambda (tag)
              (let ((classes (pt-classes tag)))
                (and (find "reference" classes :test 'equal)
                     (find "internal"  classes :test 'equal))))))
