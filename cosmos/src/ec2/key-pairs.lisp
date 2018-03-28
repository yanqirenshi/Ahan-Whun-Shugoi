(in-package :aws.cosmos)

;;;;; AWS> (aws :ec2 :describe-key-pairs")
;;;;; Command⇒ aws ec2 describe-key-pairs"
(defvar *sample-ec2_describe-key-pairs*
  '(:|KeyPairs|
    ((:|KeyFingerprint| ""
      :|KeyName|""))))

(defvar *columns_ec2_key-pairs*
  '((:code :|KeyFingerprint| :slot KeyFingerprint :set-value set-value-simple)
    (:code :|KeyName| :slot KeyName :set-value set-value-simple)))
