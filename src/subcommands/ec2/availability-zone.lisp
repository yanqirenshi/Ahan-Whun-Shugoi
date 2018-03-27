(in-package :ahan-whun-shugoi)

;;;;; AWS> (aws :ec2 :describe-availability-zones)
;;;;; Command⇒ aws ec2 describe-availability-zones
(defvar *sample-ec2_availability-zone*
  '(:|AvailabilityZones|
    ((:|RegionName| "ap-northeast-1"
      :|Messages| NIL
      :|ZoneName| "ap-northeast-1a"
      :|State| "available"))))

(defvar *columns_ec2_availability-zone*
  '((:code :|RegionName| :slot RegionName :set-value set-value-simple)
    (:code :|Messages| :slot Messages :set-value set-value-simple)
    (:code :|ZoneName| :slot ZoneName :set-value set-value-simple)
    (:code :|State| :slot State :set-value set-value-simple)))
