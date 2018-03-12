(in-package :ahan-whun-shugoi.scraping)

;;;
;;; etc
;;;
(defun trim (v)
  (string-trim '(#\Space #\Tab #\Newline) v))

(defun split-str-token (str delimiter)
  (mapcar #'trim
          (split-sequence delimiter str)))

(defun str2keyword (str)
  (alexandria:make-keyword (string-upcase str)))

(defun ensure-keyword (v)
  (cond ((keywordp v) v)
        ((stringp v) (str2keyword v))
        (t (error v))))

;;;
;;; tag
;;;
(defun class-is-section (tag)
  (class-is "section" tag))

(defun class-is-reference (tag)
  (class-is "reference" tag))

(defun class-is-internal (tag)
  (class-is "internal" tag))

(defun id-is-description (tag)
  (let ((attr (pt-attrs tag)))
    (string= "description" (getf attr :id))))

(defun id-is-synopsis (tag)
  (id-is "synopsis" tag))

(defun id-is-options (tag)
  (id-is "options" tag))

(defun id-is-examples (tag)
  (id-is "examples" tag))

(defun id-is-output (tag)
  (id-is "output" tag))

(defun id-is-available-services (tag)
  (id-is "available-services" tag))

(defun id-is-available-subcommands (tag)
  (id-is "available-commands" tag))

(defun find-description-tag (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-description)))

(defun find-synopsis-tag (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-synopsis)))

(defun find-options-tag (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-options)))

(defun find-available-services-tag (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-available-services)))

(defun find-examples-tag (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-examples)))

(defun find-output-tag (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-output)))

(defun get-code-from-h1-tag (html)
  (let* ((h1 (car (find-tag html #'is-h1)))
         (children (pt-children h1)))
    (str2keyword (pt-attrs (first children)))))

;;;
;;; plist 2 data
;;;
(defun make-dimensions (plist)
  (mapcar #'(lambda (dim)
              (list :name (getf dim :|Name|)
                    :value (getf dim :|Value|)))
          (getf plist :|Dimensions|)))

(defun unix-time2timestamp (unix-time)
  (when unix-time
    (local-time:unix-to-timestamp (floor unix-time 10000))))

;;; lock
(defun find-lock-target-prefix ()
  "*commands-prefix* を作成するための作業用オペレータ。
subcommand の先頭の一覧を返す。"
  (format t "~{~a~%~}"
          (sort (remove-duplicates
                 (mapcar #'(lambda (subcommand)
                             (let* ((name (symbol-name (code subcommand)))
                                    (pos (position #\- name)))
                               (subseq name 0 pos)))
                         (find-vertex *graph* 'subcommand)) :test 'equal)
                #'string<)))

(defvar *commands-prefix*
  '(:lock ("ABORT" "ACCEPT" "ACTIVATE" "ADD" "ADMIN" "ALLOCATE" "APPLY" "APPROVE" "ARCHIVE" "ASSIGN"
           "ASSOCIATE" "ASSUME" "ATTACH" "AUTHORIZE" "BATCH" "BUILD" "BULK" "BUNDLE" "CANCEL" "CHANGE"
           "CHECK" "CLEAR" "CLONE" "CLOSE" "COMPARE" "COMPLETE" "COMPOSE" "CONFIGURE" "CONFIRM" "CONNECT"
           "CONTINUE" "COPY" "CP" "CREATE" "CREDENTIAL" "DECODE" "DECREASE" "DEFINE" "DELETE" "DELIVER"
           "DEPLOY" "DEPRECATE" "DEREGISTER" "DETACH" "DETECT" "DISABLE" "DISASSOCIATE" "DOMAIN" "DEACTIVATE"
           "DECLINE" "DECRYPT" "ENABLE" "ENCRYPT" "ENTER" "ESTIMATE" "EVALUATE" "EXECUTE" "EXIT" "EXPIRE"
           "FAILOVER" "FLUSH" "FORGET" "FORGOT" "GENERATE" "GLOBAL" "GRANT" "IMPORT" "INCREASE" "INDEX"
           "INITIALIZE" "INITIATE" "INSTALL" "INVALIDATE" "INVITE" "INVOKE" "IS" "LEAVE" "MB" "MERGE"
           "METER" "MODIFY" "MOVE" "MV" "NOTIFY" "OPEN" "PEER" "POST" "PREDICT" "PRESIGN" "PROMOTE"
           "PROVISION" "PUBLISH" "PURCHASE" "PURGE" "PUSH" "PUT" "RB" "RE" "REBOOT" "REBUILD"
           "RECEIVE" "RECOGNIZE" "RECORD" "REFRESH" "REGISTER" "REJECT" "RELEASE" "RELOAD" "REMOVE"
           "RENEW" "REORDER" "REPLACE" "REQUEST" "RESEND" "RESET" "RESOLVE" "RESPOND" "RESTART" "RESTORE"
           "RESUME" "RESYNC" "RETIRE" "RETRY" "REVOKE" "RM" "ROTATE" "RUN" "SCHEDULE" "SEND" "SET" "SHUTDOWN"
           "SIGN" "SIGNAL" "SIMULATE" "SKIP" "SOCKS" "SPLIT" "SSH" "START" "STOP" "SUBMIT" "SUBSCRIBE"
           "SUGGEST" "SUSPEND" "SWAP" "SYNC" "SYNTHESIZE" "TERMINATE" "TEST" "TRANSFER" "TRANSLATE" "UNARCHIVE"
           "UNASSIGN" "UNINSTALL" "UNLINK" "UNMONITOR" "UNPEER" "UNSUBSCRIBE" "UNTAG" "UPDATE" "UPGRADE"
           "UPLOAD" "VALIDATE" "VERIFY")
    :??? ("DISCOVER" "EXPORT" "FILTER" "HEAD" "MONITOR" "OPT" "PACKAGE" "POLL" "PREVIEW" "REPORT" "RETRIEVE"
          "SCAN" "SHOW" "TAG" "VIEW" "WEBSITE")
    :active ("ACKNOWLEDGE" "COUNT" "DESCRIBE" "DOWNLOAD" "GET" "LIST" "LOOKUP" "LS" "QUERY" "READ" "SEARCH"
             "SELECT")))
