(in-package :ahan-whun-shugoi.scraping)

(defun find-synopsis-pre-contents (tag)
  "synopsis-tag から contents を抽出する。"
  (let ((pre-tag (car (cleanup-options
                       (find-tag tag #'is-pre)))))
    (trim (pt-attrs (car (pt-children pre-tag))))))

(defun %prse-synopsis-split-option (str)
  (multiple-value-bind (ret arr)
      (scan-to-strings "^(--.+)\\s+(.*)$" str)
    (if (null ret)
        (values str nil)
        (values (aref arr 0) (split-str-token (aref arr 1) #\Space)))))

(defun %prse-synopsis-parse-option-make (str require)
  (multiple-value-bind (name attrs)
      (%prse-synopsis-split-option str)
    (list :code name :attrs attrs :require require)))

(defun %prse-synopsis-parse-option (str require)
  (if (not (find #\| str))
      (list (%prse-synopsis-parse-option-make str require))
      (mapcar #'(lambda (str)
                  (%prse-synopsis-parse-option-make str require))
              (split-str-token str #\|))))

(defun %prse-synopsis-line (line)
  "synopsis-tag の contents を一行に対しての処理。"
  (multiple-value-bind (ret arr)
      (scan-to-strings "^\\[(.*)\\]$" line)
    (if (null ret)
        ;; 必須オプション
        (%prse-synopsis-parse-option line t)
        ;; not 必須オプション
        (%prse-synopsis-parse-option (aref arr 0) nil))))

(defun %prse-synopsis (synopsis)
  "synopsis-tag の contents を一行づつ確認し、オプションのリストに変換する。"
  (when synopsis
    (let ((line (%prse-synopsis-line (car synopsis))))
      (append line (%prse-synopsis (cdr synopsis))))))

(defun prse-synopsis (synopsis-tag)
  "synopsis-tag(pt) から option の一覧を抽出する。"
  (%prse-synopsis
   (cdr (split-sequence #\Newline
                        (find-synopsis-pre-contents synopsis-tag)))))

;;;
;;;
;;;
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

(defun find-option-tags (tag)
  (find-tag tag
            #'is-p
            #'(lambda (tag)
                (let* ((children (pt-children tag))
                       (first-child (first children))
                       (second-child (second children)))
                  (and first-child
                       second-child
                       (eq :tt (pt-name first-child))
                       (eq :pcdata (pt-name second-child)))))))

(defun option-tag2plist (option-tag)
  (let ((name (find-options-option-name option-tag)))
    (let ((value-type (find-option-value-type option-tag)))
      (list :name name :type value-type))))

#|
(mapcar #'option-tag2plist
        (find-option-tags (get-x-html-options)))
|#
