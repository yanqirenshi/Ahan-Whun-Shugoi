(in-package :ahan-whun-shugoi.scraping)

(defun find-options (aws service command options)
  (list aws service command options))

(defun get-x-html-options ()
  (find-options-tag
   (html2pt "https://docs.aws.amazon.com/ja_jp/cli/latest/reference/acm/add-tags-to-certificate.html")))

(defun find-options-option-name (option-tag)
  (let ((span-tag (car (find-tag option-tag #'is-span))))
    (multiple-value-bind (ret arr)
        (cl-ppcre:scan-to-strings "^(--.*)$"
                                  (pt-attrs (first (pt-children span-tag))))
      (when ret (aref arr 0)))))

(defun find-option-value-type (tag)
  (when (and tag (second (pt-children tag)))
    (let ((attr (pt-attrs (second (pt-children tag)))))
      (when (stringp attr)
        (multiple-value-bind (ret arr)
            (cl-ppcre:scan-to-strings "^\\s+\\((.*)\\)[\\s\\S]*$" attr)
            (when ret (aref arr 0)))))))

(defun eq-tag-attr-is-separator-bar (tag)
  (let ((attrs (pt-attrs tag)))
    (and (stringp attrs)
         (string= "|" (trim attrs)))))

(defun find-option-value-type-tag (option-tag)
  (first
   (find-tag option-tag
             #'is-pcdata
             #'(lambda (tag)
                 (let ((attrs (pt-attrs tag)))
                   (and (stringp attrs)
                        (cl-ppcre:scan-to-strings "^\\s+\\((.*)\\)[\\s\\S]*$" attrs)))))))

(defun %find-option-name-tags (option-tag-children)
  "option タグ直下のタグから option 名のタグを抽出する。"
  (let ((child (first option-tag-children))
        (next-child (second option-tag-children)))
    (when (and option-tag-children
               (eq :tt (pt-name child)))
      (if (not (and next-child
                    (eq-tag-attr-is-separator-bar next-child)))
          (list child)
          (cons child
                (%find-option-name-tags (cddr option-tag-children)))))))

(defun find-option-name-tags (option-tag)
  (when option-tag
    (%find-option-name-tags (pt-children option-tag))))

(defun find-option-tags (tag)
  (find-tag tag
            #'is-p
            #'(lambda (tag)
                (let* ((children (pt-children tag))
                       (first-child (first children))
                       (second-child (second children)))
                  (and first-child
                       second-child
                       (eq :tt (pt-name first-child)))))))

(defun option-tag2plist (option-tag)
  (let ((name (find-options-option-name option-tag)))
    (let ((value-type (find-option-value-type option-tag)))
      (list :name name :type value-type))))

(defun make-option-data (option-tag value-type-tag)
  (mapcar #'(lambda (option-name-tag)
              (list :code (pt-attrs (car (find-tag (car (find-tag option-name-tag #'is-span))
                                                 #'(lambda (tag) (eq :pcdata (pt-name tag))))))
                    :value-type (pt-attrs value-type-tag)))
          (find-option-name-tags option-tag)))

(defun prse-options (options-tag)
  (let ((value-type-tag (find-option-value-type-tag options-tag)))
    (apply #'append
           (mapcar #'(lambda (option-tag)
                       (make-option-data option-tag value-type-tag))
                   (find-option-tags options-tag)))))

#|
(mapcar #'option-tag2plist
        (find-option-tags (get-x-html-options)))
|#
