(in-package :ahan-whun-shugoi)

;;;;; AWS> (aws :ec2 :describe-addresses :--profile "tatta-developer")
;;;;; Command⇒ aws ec2 describe-addresses --profile "tatta-developer"
(defvar *sample-ec2_describe-addresses*
  '(:|Addresses|
    ((:|PrivateIpAddress| ""
      :|AllocationId| ""
      :|PublicIp| ""
      :|AssociationId| ""
      :|NetworkInterfaceOwnerId| ""
      :|NetworkInterfaceId| ""
      :|Domain| ""))))

(defvar *columns-ec2-address*
  '((:code :|PrivateIpAddress| :slot PrivateIpAddress :set-value set-value-simple)
    (:code :|AllocationId| :slot AllocationId :set-value set-value-simple)
    (:code :|PublicIp| :slot PublicIp :set-value set-value-simple)
    (:code :|AssociationId| :slot AssociationId :set-value set-value-simple)
    (:code :|NetworkInterfaceOwnerId| :slot NetworkInterfaceOwnerId :set-value set-value-simple)
    (:code :|NetworkInterfaceId| :slot NetworkInterfaceId :set-value set-value-simple)
    (:code :|Domain| :slot Domain :set-value set-value-simple)))
