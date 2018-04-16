(in-package :aws.cosmos)


;;;
;;; User
;;;
(defclass log-user ()
  ((user-id :accessor user-id
            :initarg :user-id
            :initform nil)
   (user-name :accessor user-name
              :initarg :user-name
              :initform nil)
   (password-last-used :accessor password-last-used
                       :initarg :password-last-used
                       :initform nil)
   (create-date :accessor create-date
                :initarg :create-date
                :initform nil)
   (path :accessor path
         :initarg :path
         :initform nil)
   (arn :accessor arn
        :initarg :arn
        :initform nil)))

(defun plist2user (plist)
  (make-instance 'log-user
                 :user-id (getf plist :|UserId|)
                 :user-name (getf plist :|UserName|)
                 :password-last-used (getf plist :|PasswordLastUsed|)
                 :create-date (local-time:parse-timestring (getf plist :|CreateDate|))
                 :path (getf plist :|Path|)
                 :arn (getf plist :|arn|)))

(defun plist2users (plist)
  (when plist
    (assert (eq :|Users| (car plist)))
    (mapcar #'plist2user (cadr plist))))


;;;
;;; Roll
;;;
;; '(:|Arn| ""
;;   :|Path| ""
;;   :|RoleName| ""
;;   :|CreateDate| ""
;;   :|RoleId| ""
;;   :|AssumeRolePolicyDocument| (:|Statement| ((:|Principal| (:|Service| "")
;;                                               :|Effect| ""
;;                                               :|Action| ""))
;;                                :|Version| ""))
