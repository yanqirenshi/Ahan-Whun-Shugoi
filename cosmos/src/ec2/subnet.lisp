(in-package :aws.cosmos)

;;;;; AWS> (aws :ec2 :describe-subnets)
;;;;; Command⇒ aws ec2 describe-subnets
(defvar *sample-ec2-describe-subnets*
  '(:|Subnets|
    ((:|AssignIpv6AddressOnCreation| NIL
      :|CidrBlock| ""
      :|SubnetId| ""
      :|MapPublicIpOnLaunch| T
      :|State| ""
      :|VpcId| ""
      :|Ipv6CidrBlockAssociationSet| NIL
      :|DefaultForAz| T
      :|AvailableIpAddressCount| 4091
      :|AvailabilityZone| ""))))

(defvar *columns_ec2_describe-subnets*
  '((:code :|AssignIpv6AddressOnCreation| :slot AssignIpv6AddressOnCreation :set-value set-value-simple)
    (:code :|CidrBlock|                   :slot CidrBlock                   :set-value set-value-simple)
    (:code :|SubnetId|                    :slot SubnetId                    :set-value set-value-simple)
    (:code :|MapPublicIpOnLaunch|         :slot MapPublicIpOnLaunch         :set-value set-value-simple)
    (:code :|State|                       :slot State                       :set-value set-value-simple)
    (:code :|VpcId|                       :slot VpcId                       :set-value set-value-simple)
    (:code :|Ipv6CidrBlockAssociationSet| :slot Ipv6CidrBlockAssociationSet :set-value set-value-simple)
    (:code :|DefaultForAz|                :slot DefaultForAz                :set-value set-value-simple)
    (:code :|AvailableIpAddressCount|     :slot AvailableIpAddressCount     :set-value set-value-simple)
    (:code :|AvailabilityZone|            :slot AvailabilityZone            :set-value set-value-simple)))
