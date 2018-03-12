(in-package :ahan-whun-shugoi.scraping)

(defun cleanup-options (options)
  (remove-if #'(lambda (tag)
                 (or (and (stringp (pt-attrs tag))
                          (string= "" (trim (pt-attrs tag))))
                     (eq :h2 (pt-name tag))))
             options))

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
        (values (aref arr 0)
                (first (split-str-token (aref arr 1) #\Space))))))

(defun %prse-synopsis-parse-option-make (str require)
  (multiple-value-bind (name attrs)
      (%prse-synopsis-split-option str)
    (list :code name :attributes attrs :require require)))

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
