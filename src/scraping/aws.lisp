(in-package :ahan-whun-shugoi.scraping)

(defun a-tag2service (tag)
  (list :code (pt-attrs (first (pt-children tag)))
        :href (getf (pt-attrs tag) :href)))

(defun find-services (html)
  (find-tag html
            (lambda (tag)
              (eq :a (pt-name tag)))
            (lambda (tag)
              (let ((classes (pt-classes tag)))
                (and (find "reference" classes :test 'equal)
                     (find "internal"  classes :test 'equal))))))

(defun find-aws (&key (uri "https://docs.aws.amazon.com/ja_jp/cli/latest/reference/index.html"))
  (let ((html (html2pt uri)))
    (list :description (find-description html)
          :synopsis    (find-synopsis html)
          :options     (find-options html)
          :sevieces    (mapcar #'a-tag2service (find-services (find-available-services html))))))
