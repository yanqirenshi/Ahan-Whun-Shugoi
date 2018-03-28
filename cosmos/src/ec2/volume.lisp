(in-package :aws.cosmos)

;;;;; AWS> (aws :ec2 :describe-volumes)
;;;;; Command⇒ aws ec2 describe-volumes"
(defvar *sample-ec2_describe-volumes*
  '(:|Volumes|
    ((:|Size| 20
      :|CreateTime| ""
      :|SnapshotId| ""
      :|Iops| 100
      :|State| ""
      :|VolumeId| ""
      :|VolumeType| ""
      :|Encrypted| NIL
      :|Attachments| ((:|Device| ""
                       :|DeleteOnTermination| T
                       :|State| ""
                       :|VolumeId| ""
                       :|InstanceId| ""
                       :|AttachTime| ""))
      :|AvailabilityZone| ""))))

(defvar *columns_ec2_volume*
  '((:code :|Size| :slot Size :set-value set-value-simple)
    (:code :|CreateTime| :slot CreateTime :set-value set-value-simple)
    (:code :|SnapshotId| :slot SnapshotId :set-value set-value-simple)
    (:code :|Iops| :slot Iops :set-value set-value-simple)
    (:code :|State| :slot State :set-value set-value-simple)
    (:code :|VolumeId| :slot VolumeId :set-value set-value-simple)
    (:code :|VolumeType| :slot VolumeType :set-value set-value-simple)
    (:code :|Encrypted| :slot Encrypted :set-value set-value-simple)
    (:code :|AvailabilityZone| :slot AvailabilityZone :set-value set-value-simple)
    (:code :|Attachments| :slot nil :set-value set-value-ignore)))
