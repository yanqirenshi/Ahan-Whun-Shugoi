(in-package :aws-beach)
#|
各WEBページの Option セクションからコマンドのオプションを取得するコードです。

2018-03-15 (木) 時点で以下のサブコマンドは取得ロジックに問題があり取得出来ていません。
ロジックの修正が必要なので。。。そのうち。。。

<2018-04-09 (Mon)>
WARNING: 0  = 8  ⇒ NIL : CREATE-SUBSCRIPTION
WARNING: 0  = 8  ⇒ NIL : UPDATE-SUBSCRIPTION
WARNING: 0  = 1  ⇒ NIL : GET
WARNING: 0  = 2  ⇒ NIL : SET
WARNING: 31 = 34 ⇒ NIL : CREATE-CLUSTER
|#

(defun find-options-option-name (option-tag)
  "この関数は廃止予定です。
正規表現のところを他で利用するので残しています。"
  (let ((span-tag (car (find-tag option-tag #'is-span))))
    (multiple-value-bind (ret arr)
        (cl-ppcre:scan-to-strings "^(--.*)$"
                                  (pt-attrs (first (pt-children span-tag))))
      (when ret (aref arr 0)))))

(defun eq-tag-attr-is-separator-bar (tag)
  (let ((attrs (pt-attrs tag)))
    (and (stringp attrs)
         (string= "|" (trim attrs)))))

(defun option-value-type-tag-p (tag)
  (let ((attrs (pt-attrs tag)))
    (and (stringp attrs)
         (cl-ppcre:scan-to-strings "^\\s+\\((.*)\\)[\\s\\S]*$" attrs))))

(defun find-option-value-type-tag (option-tag)
  (first
   (find-tag option-tag
             #'is-pcdata
             #'option-value-type-tag-p)))

(defun find-option-value-type (option-tag)
  "https://docs.aws.amazon.com/cli/latest/reference/codecommit/credential-helper/index.html"
  (when-let ((option-value-type-tag (find-option-value-type-tag option-tag)))
    (let* ((attrs (pt-attrs option-value-type-tag)))
      (when (stringp attrs)
        (multiple-value-bind (ret arr)
            (cl-ppcre:scan-to-strings "^\\s+\\((.*)\\)[\\s\\S]*$" attrs)
          (when ret (aref arr 0)))))))

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
  "option-tag から option-name のタグを抽出する。"
  (when option-tag
    (%find-option-name-tags (pt-children option-tag))))

(defun find-options-p-tags (options-tag-children)
  "options-tag 直下の p タグを全て抽出する。"
  (when options-tag-children
    (let ((child-tag (car options-tag-children)))
      (if (not (eq :p (pt-name child-tag)))
          (find-options-p-tags (cdr options-tag-children))
          (cons child-tag
                (find-options-p-tags (cdr options-tag-children)))))))

(defun %find-option-tags (tag)
  "options-tag から全ての option-tag を抽出する。"
  (find-tag tag
            #'is-p
            #'(lambda (tag)
                (let* ((children (pt-children tag))
                       (first-child (first children))
                       (second-child (second children)))
                  (and first-child
                       second-child
                       (eq :tt (pt-name first-child)))))))

(defun find-option-tags (tags)
  (when tags
    (let ((option-tags (%find-option-tags (car tags))))
      (if (not option-tags)
          (find-option-tags (cdr tags))
          (nconc option-tags
                 (find-option-tags (cdr tags)))))))

(defun get-options-option-name-string (option-name-tag)
  "option-name-tag option-tag から option name の文字列を抽出する。"
  (pt-attrs (car (find-tag (car (find-tag option-name-tag #'is-span))
                           #'(lambda (tag)
                               (eq :pcdata (pt-name tag)))))))

(defun make-option-data (option-tag value-type)
  "option-tag value-type から (:code {string} :value-types {list}) のデータを作成する。"
  (mapcar #'(lambda (option-name-tag)
              (list :code        (get-options-option-name-string option-name-tag)
                    :value-types value-type))
          (find-option-name-tags option-tag)))

(defun prse-options (options-tag)
  "options-tag から全ての option に対しての情報を抽出する。
抽出したものは (:code {string} :value-types {list}) の形式で抽出する。"
  (let ((value-type (find-option-value-type options-tag)))
    (apply #'append
           (mapcar #'(lambda (option-tag)
                       (make-option-data option-tag value-type))
                   (find-option-tags (find-options-p-tags (pt-children options-tag)))))))
