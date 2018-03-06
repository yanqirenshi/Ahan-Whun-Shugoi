(in-package :ahan-whun-shugoi)

(defvar *commands*
  `((:s3 ,(cmds-s3))
    (:ec2 ,(cmds-ec2))
    (:logs ,(cmds-logs))
    (:iam ,(cmds-iam))))

(defun assert-command (service command)
  (assert (list service command)))
