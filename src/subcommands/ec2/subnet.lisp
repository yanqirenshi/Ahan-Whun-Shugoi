(in-package :ahan-whun-shugoi)

;;;;; AWS> (aws :ec2 :describe-subnets)
;;;;; Command⇒ aws ec2 describe-subnets
(defvar *sample-ec2-describe-subnets*
  '(:|Subnets|
    ((:|AssignIpv6AddressOnCreation| NIL
      :|CidrBlock| "172.31.16.0/20"
      :|SubnetId| "subnet-9087f8e7"
      :|MapPublicIpOnLaunch| T
      :|State| "available"
      :|VpcId| "vpc-6036af05"
      :|Ipv6CidrBlockAssociationSet| NIL
      :|DefaultForAz| T
      :|AvailableIpAddressCount| 4091
      :|AvailabilityZone| "ap-northeast-1a"))))

(defvar *columns_ec2_describe-subnets*
  '((:code :|AssignIpv6AddressOnCreation| :slot AssignIpv6AddressOnCreation :set-value set-value-simple)
    (:code :|CidrBlock| :slot CidrBlock :set-value set-value-simple)
    (:code :|SubnetId| :slot SubnetId :set-value set-value-simple)
    (:code :|MapPublicIpOnLaunch| :slot MapPublicIpOnLaunch :set-value set-value-simple)
    (:code :|State| :slot State :set-value set-value-simple)
    (:code :|VpcId| :slot VpcId :set-value set-value-simple)
    (:code :|Ipv6CidrBlockAssociationSet| :slot Ipv6CidrBlockAssociationSet :set-value set-value-simple)
    (:code :|DefaultForAz| :slot DefaultForAz :set-value set-value-simple)
    (:code :|AvailableIpAddressCount| :slot AvailableIpAddressCount :set-value set-value-simple)
    (:code :|AvailabilityZone| :slot AvailabilityZone :set-value set-value-simple)))
