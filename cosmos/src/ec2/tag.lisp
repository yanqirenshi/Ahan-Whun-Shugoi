(in-package :aws.cosmos)

;;;;; AWS> (aws :ec2 :describe-tags)
;;;;; Command⇒ aws ec2 describe-tags
(defvar *sample-ec2_describe-tags*
  '(:|Tags|
    ((:|Key| "Name"
      :|Value| "TATTA_PRODUCTION_SIDEKIQ02"
      :|ResourceId| "vol-0520547909d8301ac"
      :|ResourceType| "volume"))))

(defvar *columns_ec2_tags*
  '((:code :|Key| :slot Key :set-value set-value-simple)
    (:code :|Value| :slot Value :set-value set-value-simple)
    (:code :|ResourceId| :slot ResourceId :set-value set-value-simple)
    (:code :|ResourceType| :slot ResourceType :set-value set-value-simple)))
