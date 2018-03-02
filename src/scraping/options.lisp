(in-package :ahan-whun-shugoi.scraping)

(defun find-options (aws service command options)
  (list aws service command options))

;;;
;;; options
;;;
;;;
#|
options タグから option を抽出しようと試みるも、ちょっと面倒そうだったので synopsis からに宗旨替え。
ただし、値の型はこちらにしか持っていないので、それば別途取得しようと思う。
両方必要そう。
|#
(defun find-ec2-options ()
  (cleanup-options
   (pt-children (find-options-tag (html2pt "https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html")))))

(defun cleanup-options (options)
  (remove-if #'(lambda (tag)
                 (or (and (stringp (pt-attrs tag))
                          (string= "" (trim (pt-attrs tag))))
                     (eq :h2 (pt-name tag))))
             options))

(defun tag-children-names (tag &key (sort :asc))
  (let ((result (mapcar #'pt-name (pt-children tag))))
    (if (not sort)
        result
        (sort result
              #'(lambda (a b)
                  (string< (princ-to-string a)
                           (princ-to-string b)))))))

(defun eq-tag-children-name (tag names)
  (flet ((sort-list (list)
           (sort list
                 #'(lambda (a b)
                     (string< (princ-to-string a)
                              (princ-to-string b))))))
    (equal (sort-list (tag-children-names tag))
           (sort-list names))))

(defun option-header-tag-p (tag)
  (and (eq :p (pt-name tag))
       (eq-tag-children-name tag '(:PCDATA :TT))))

(defun parse-options (options)
  (let ((header nil)
        (detail nil)
        (out nil))
    (dolist (option options)
      (if (not (option-header-tag-p option))
          (push option detail)
          (progn
            (push (list :header header :detail detail) out)
            (setf header nil)
            (setf detail nil)
            (setf header option) out)))
    out))
