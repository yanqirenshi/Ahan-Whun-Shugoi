(in-package :ahan-whun-shugoi)

;;;;; AWS> (aws :ec2 :describe-regions)
;;;;; Command⇒ aws ec2 describe-regions
(defvar *sample-ec2_describe-regions*
  '(:|Regions|
    ((:|RegionName| "ap-south-1"
      :|Endpoint| "ec2.ap-south-1.amazonaws.com"))))

(defvar *columns_ec2_region*
  '((:code |RegionName| :slot RegionName :set-value set-value-simple)
    (:code |Endpoint| :slot Endpoint :set-value set-value-simple)))
