(in-package :ahan-whun-shugoi.scraping)

;;;
;;; synopsis
;;;
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
    (list :name name :attrs attrs :require require)))

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
;;; find-commands
;;;
(defun merge-command-uri (tag uri)
  (let ((uri (quri:uri uri)))
    (setf (quri:uri-path uri)
          (namestring
           (merge-pathnames (getf (pt-attrs tag) :href)
                            (quri:uri-path uri))))
    uri))

(defun a-tag2command-plist (tag uri)
  (list :code (pt-attrs (first (pt-children tag)))
        :uri (merge-command-uri tag uri)))


(defun get-command-html (uri &key (sleep-time 1))
  (let ((html (html2pt uri)))
    (sleep sleep-time)
    html))

(defun html2service-code (html)
  (let* ((h1 (car (find-tag html #'is-h1)))
         (children (pt-children h1)))
    (pt-attrs (first children))))


(defclass command (shinra:shin)
  ((code        :accessor code        :initarg :code        :initform nil)
   (description :accessor description :initarg :description :initform nil)
   (synopsis    :accessor synopsis    :initarg :synopsis    :initform nil)
   (examples    :accessor examples    :initarg :examples    :initform nil)
   (output      :accessor output      :initarg :output      :initform nil)))

(defun make-command (html)
  (when html
    ;; (make-instance 'command
    ;;                :description (find-description-tag html)
    ;;                :synopsis    (prse-synopsis (find-synopsis-tag html))
    ;;                :examples    (find-examples-tag html)
    ;;                :output      (find-output-tag html))
    (up:execute-transaction
     (shinra:tx-make-vertex *graph*
                            'command
                            `((code ,(html2service-code html))
                              (description ,(find-description-tag html))
                              (synopsis    ,(prse-synopsis (find-synopsis-tag html)))
                              (examples    ,(find-examples-tag html))
                              (output      ,(find-output-tag html)))))))

(defun find-command-options (html)
  (find-options-tag html))

(defun find-commands (aws service commands)
  (dolist (command commands)
    (let* ((uri (getf command :uri))
           (html (get-command-html uri)))
      (unless (string= "wait" (getf command :code))
        (find-options aws
                      service
                      (make-command html)
                      (find-command-options html))))))
