(in-package :cl-user)
(defpackage ahan-whun-shugoi-beach.util
  (:nicknames :aws-beach.util)
  (:use #:cl)
  (:import-from :split-sequence
                #:split-sequence)
  (:import-from :aws-beach.db
                #:*graph*)
  (:import-from :shinra
                #:find-vertex)
  (:export #:split-str-token
           #:trim
           #:str2keyword
           #:ensure-keyword))
(in-package :ahan-whun-shugoi-beach.util)


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
;;; plist 2 data
;;;
;;; lock
;; (defun find-lock-target-prefix ()
;;   "*commands-prefix* を作成するための作業用オペレータ。
;; subcommand の先頭の一覧を返す。"
;;   (format t "~{~a~%~}"
;;           (sort (remove-duplicates
;;                  (mapcar #'(lambda (subcommand)
;;                              (let* ((name (symbol-name (code subcommand)))
;;                                     (pos (position #\- name)))
;;                                (subseq name 0 pos)))
;;                          (find-vertex *graph* 'subcommand)) :test 'equal)
;;                 #'string<)))

;; (defvar *commands-prefix*
;;   '(:lock ("ABORT" "ACCEPT" "ACTIVATE" "ADD" "ADMIN" "ALLOCATE" "APPLY" "APPROVE" "ARCHIVE" "ASSIGN"
;;            "ASSOCIATE" "ASSUME" "ATTACH" "AUTHORIZE" "BATCH" "BUILD" "BULK" "BUNDLE" "CANCEL" "CHANGE"
;;            "CHECK" "CLEAR" "CLONE" "CLOSE" "COMPARE" "COMPLETE" "COMPOSE" "CONFIGURE" "CONFIRM" "CONNECT"
;;            "CONTINUE" "COPY" "CP" "CREATE" "CREDENTIAL" "DECODE" "DECREASE" "DEFINE" "DELETE" "DELIVER"
;;            "DEPLOY" "DEPRECATE" "DEREGISTER" "DETACH" "DETECT" "DISABLE" "DISASSOCIATE" "DOMAIN" "DEACTIVATE"
;;            "DECLINE" "DECRYPT" "ENABLE" "ENCRYPT" "ENTER" "ESTIMATE" "EVALUATE" "EXECUTE" "EXIT" "EXPIRE"
;;            "FAILOVER" "FLUSH" "FORGET" "FORGOT" "GENERATE" "GLOBAL" "GRANT" "IMPORT" "INCREASE" "INDEX"
;;            "INITIALIZE" "INITIATE" "INSTALL" "INVALIDATE" "INVITE" "INVOKE" "IS" "LEAVE" "MB" "MERGE"
;;            "METER" "MODIFY" "MOVE" "MV" "NOTIFY" "OPEN" "PEER" "POST" "PREDICT" "PRESIGN" "PROMOTE"
;;            "PROVISION" "PUBLISH" "PURCHASE" "PURGE" "PUSH" "PUT" "RB" "RE" "REBOOT" "REBUILD"
;;            "RECEIVE" "RECOGNIZE" "RECORD" "REFRESH" "REGISTER" "REJECT" "RELEASE" "RELOAD" "REMOVE"
;;            "RENEW" "REORDER" "REPLACE" "REQUEST" "RESEND" "RESET" "RESOLVE" "RESPOND" "RESTART" "RESTORE"
;;            "RESUME" "RESYNC" "RETIRE" "RETRY" "REVOKE" "RM" "ROTATE" "RUN" "SCHEDULE" "SEND" "SET" "SHUTDOWN"
;;            "SIGN" "SIGNAL" "SIMULATE" "SKIP" "SOCKS" "SPLIT" "SSH" "START" "STOP" "SUBMIT" "SUBSCRIBE"
;;            "SUGGEST" "SUSPEND" "SWAP" "SYNC" "SYNTHESIZE" "TERMINATE" "TEST" "TRANSFER" "TRANSLATE" "UNARCHIVE"
;;            "UNASSIGN" "UNINSTALL" "UNLINK" "UNMONITOR" "UNPEER" "UNSUBSCRIBE" "UNTAG" "UPDATE" "UPGRADE"
;;            "UPLOAD" "VALIDATE" "VERIFY")
;;     :??? ("DISCOVER" "EXPORT" "FILTER" "HEAD" "MONITOR" "OPT" "PACKAGE" "POLL" "PREVIEW" "REPORT" "RETRIEVE"
;;           "SCAN" "SHOW" "TAG" "VIEW" "WEBSITE")
;;     :active ("ACKNOWLEDGE" "COUNT" "DESCRIBE" "DOWNLOAD" "GET" "LIST" "LOOKUP" "LS" "QUERY" "READ" "SEARCH"
;;              "SELECT")))
