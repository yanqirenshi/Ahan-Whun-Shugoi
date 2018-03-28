(in-package :ahan-whun-shugoi)

;;;;; AWS> (aws :ec2 :describe-vpcs)
;;;;; Command⇒ aws ec2 describe-vpcs
(defvar *sample-ec2-describe-vpcs*
  '(:|Vpcs|
    ((:|IsDefault| NIL
      :|CidrBlock| ""
      :|DhcpOptionsId| ""
      :|State| ""
      :|CidrBlockAssociationSet| ((:|CidrBlockState| (:|State| "")
                                   :|CidrBlock| ""
                                   :|AssociationId| ""))
      :|Tags| ((:|Key| "" :|Value| ""))
      :|InstanceTenancy| ""
      :|VpcId| ""))))

(defvar *columns_ec2_address*
  '((:code :|IsDefault| :slot IsDefault :set-value set-value-simple)
    (:code :|CidrBlock| :slot CidrBlock :set-value set-value-simple)
    (:code :|DhcpOptionsId| :slot DhcpOptionsId :set-value set-value-simple)
    (:code :|State| :slot State :set-value set-value-simple)
    (:code :|InstanceTenancy| :slot InstanceTenancy :set-value set-value-simple)
    (:code :|VpcId| :slot VpcId :set-value set-value-simple)
    (:code :|Tags| :slot Tags :set-value set-value-tags2alist)
    (:code :|CidrBlockAssociationSet| :slot nil :set-value set-value-ignore)))
