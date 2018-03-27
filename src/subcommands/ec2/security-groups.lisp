(in-package :ahan-whun-shugoi)

;;;;; AWS> (aws :ec2 :describe-security-groups)
;;;;; Command⇒ aws ec2 describe-security-groups
(defvar *sample-ec2_describe-security-groups*
  '(:|SecurityGroups|
    ((:|GroupId| ""
      :|OwnerId| ""
      :|VpcId| ""
      :|GroupName| ""
      :|IpPermissions| ((:|Ipv6Ranges| NIL
                         :|UserIdGroupPairs| ((:|GroupId| "" :|UserId| ""))
                         :|IpProtocol| ""
                         :|ToPort| 80
                         :|IpRanges| ((:|CidrIp| ""))
                         :|FromPort| 80
                         :|PrefixListIds| NIL)
                        (:|Ipv6Ranges| NIL
                         :|UserIdGroupPairs| NIL
                         :|IpRanges| ((:|CidrIp| "") (:|CidrIp| ""))
                         :|PrefixListIds| NIL
                         :|IpProtocol| "")
                        (:|Ipv6Ranges| NIL
                         :|UserIdGroupPairs| ((:|GroupId| "" :|UserId| ""))
                         :|IpProtocol| ""
                         :|ToPort| 22
                         :|IpRanges| NIL
                         :|FromPort| 22
                         :|PrefixListIds| NIL))
      :|Tags| ((:|Key| "" :|Value| ""))
      :|Description| ""
      :|IpPermissionsEgress| ((:|Ipv6Ranges| NIL
                               :|UserIdGroupPairs| NIL
                               :|IpRanges| ((:|CidrIp| ""))
                               :|PrefixListIds| NIL
                               :|IpProtocol| ""))))))

(defvar *columns_ec2_security-groups*
  '((:code :|GroupId| :slot GroupId :set-value set-value-simple)
    (:code :|OwnerId| :slot OwnerId :set-value set-value-simple)
    (:code :|VpcId| :slot VpcId :set-value set-value-simple)
    (:code :|GroupName| :slot GroupName :set-value set-value-simple)
    (:code :|Description| :slot Description :set-value set-value-simple)
    (:code :|Tags| :slot Tags :set-value set-value-tags2alist)
    ;; ignore
    (:code :|IpPermissions| :slot nil :set-value set-value-ignore)
    (:code :|IpPermissionsEgress| :slot nil :set-value set-value-ignore)))
