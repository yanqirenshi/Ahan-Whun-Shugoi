(in-package :cl-user)
(defpackage ahan-whun-shugoi-beach.util.lock
  (:nicknames :aws.beach.util.lock)
  (:use :cl)
  (:export #:collect)
  (:export #:subcommand-default-lock-p))
(in-package :ahan-whun-shugoi-beach.util.lock)

(defun get-subcommand-code-header-token (subcommand-code)
  (let* ((name (symbol-name subcommand-code))
         (pos (position #\- name)))
    (if (null pos)
        name
        (subseq name 0 pos))))

(defun find-lock-target-prefix (subcommand-code-list)
  "*commands-prefix* を作成するための作業用オペレータ。
subcommand の先頭の一覧を返す。"
  (format t "~{~a~%~}"
          (sort (remove-duplicates
                 (mapcar #'get-subcommand-code-header-token subcommand-code-list)
                 :test 'equal)
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
    :??? ("DISCOVER" "EXPORT" "HEAD" "MONITOR" "OPT" "PACKAGE" "POLL" "PREVIEW" "REPORT" "RETRIEVE"
          "SCAN" "SHOW" "TAG" "VIEW" "WEBSITE")
    :active ("ACKNOWLEDGE" "COUNT" "DESCRIBE" "DOWNLOAD" "GET" "LIST" "LOOKUP" "LS" "QUERY" "READ" "SEARCH"
             "SELECT" "FILTER"))
  "2018-03-15 (木) に yanqirenshi が憶測で作成")

(defun subcommand-default-lock-p (subcommand-code)
  (let ((header-token (get-subcommand-code-header-token subcommand-code)))
    (if (find header-token (getf *commands-prefix* :active) :test 'equal)
        nil t)))
