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

(defun get-command (&key code)
  (shinra:find-vertex *graph* 'command
                      :slot 'code
                      :value code))

(defun update-command (command html)
  (declare (ignore html))
  command)

(defun make-command (html &key uri)
  (when html
    (let* ((code (html2service-code html))
           (command (car (get-command :code code))))
      (if command
          (update-command command html)
          (execute-transaction
           (tx-make-vertex *graph*
                           'command
                           `((code ,code)
                             ;; (description ,(find-description-tag html))
                             ;; (synopsis    ,(prse-synopsis (find-synopsis-tag html)))
                             ;; (examples    ,(find-examples-tag html))
                             ;; (output      ,(find-output-tag html))
                             (uri ,uri)
                             )))))))

(defun find-command-options (html)
  (find-options-tag html))

(defun make-r-service-command (service command)
  (or (shinra:get-r *graph* 'r-commands :from service command :r)
      (execute-transaction
       (shinra:tx-make-edge *graph* 'r-commands
                            service command :r))))

(defun find-commands (aws service commands)
  (declare (ignore aws))
  (dolist (command commands)
    (let* ((uri (getf command :uri))
           (html (get-command-html uri)))
      (unless (string= "wait" (getf command :code))
        (let ((command (make-command html :uri uri)))
          (make-r-service-command service command))))))
