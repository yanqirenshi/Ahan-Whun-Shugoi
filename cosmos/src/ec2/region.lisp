(in-package :aws.cosmos)

;;;;; AWS> (aws :ec2 :describe-regions)
;;;;; Command⇒ aws ec2 describe-regions
(defvar *sample-ec2_describe-regions*
  '(:|Regions|
    ((:|RegionName| ""
      :|Endpoint| ""))))

(defvar *columns_ec2_region*
  '((:code |RegionName| :slot RegionName :set-value set-value-simple)
    (:code |Endpoint| :slot Endpoint :set-value set-value-simple)))
