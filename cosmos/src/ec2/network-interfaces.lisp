(in-package :aws.cosmos)

;;;;; AWS> (aws :ec2 :describe-network-interfaces)
;;;;; Command⇒ aws ec2 describe-network-interfacs
(defvar *sample-ec2_describe-network-interfaces*
  '(:|NetworkInterfaces|
    ((:|Association| (:|IpOwnerId| ""
                      :|AllocationId| ""
                      :|PublicDnsName| ""
                      :|AssociationId| ""
                      :|PublicIp| "")
      :|TagSet| NIL
      :|SubnetId| ""
      :|PrivateIpAddress| ""
      :|OwnerId| ""
      :|Ipv6Addresses| NIL
      :|Groups| NIL
      :|Attachment| (:|InstanceOwnerId| ""
                     :|AttachmentId| ""
                     :|DeleteOnTermination| NIL
                     :|DeviceIndex| 1
                     :|Status| "")
      :|InterfaceType| ""
      :|VpcId| ""
      :|RequesterId| ""
      :|RequesterManaged| T
      :|PrivateIpAddresses| ((:|Association| (:|IpOwnerId| ""
                                              :|AllocationId| ""
                                              :|PublicDnsName| ""
                                              :|AssociationId| ""
                                              :|PublicIp| "")
                              :|Primary| T
                              :|PrivateIpAddress| ""))
      :|NetworkInterfaceId| ""
      :|Description| ""
      :|AvailabilityZone| ""
      :|SourceDestCheck| NIL
      :|MacAddress| ""
      :|Status| ""))))

(defvar *columns_ec2_network-interfaces*
  '((:code :|TagSet| :slot TagSet :set-value set-value-simple)
    (:code :|SubnetId| :slot SubnetId :set-value set-value-simple)
    (:code :|PrivateIpAddress| :slot PrivateIpAddress :set-value set-value-simple)
    (:code :|OwnerId| :slot OwnerId :set-value set-value-simple)
    (:code :|Ipv6Addresses| :slot Ipv6Addresses :set-value set-value-simple)
    (:code :|Groups| :slot Groups :set-value set-value-simple)
    (:code :|InterfaceType| :slot InterfaceType :set-value set-value-simple)
    (:code :|VpcId| :slot VpcId :set-value set-value-simple)
    (:code :|RequesterId| :slot RequesterId :set-value set-value-simple)
    (:code :|RequesterManaged| :slot RequesterManaged :set-value set-value-simple)
    (:code :|NetworkInterfaceId| :slot NetworkInterfaceId :set-value set-value-simple)
    (:code :|Description| :slot Description :set-value set-value-simple)
    (:code :|AvailabilityZone| :slot AvailabilityZone :set-value set-value-simple)
    (:code :|SourceDestCheck| :slot SourceDestCheck :set-value set-value-simple)
    (:code :|MacAddress| :slot MacAddress :set-value set-value-simple)
    (:code :|Status| :slot Status :set-value set-value-simple)
    ;; ignore
    (:code :|Association| :slot nil :set-value set-value-ignore)
    (:code :|Attachment| :slot nil :set-value set-value-ignore)
    (:code :|PrivateIpAddresses| :slot nil :set-value set-value-ignore)))
