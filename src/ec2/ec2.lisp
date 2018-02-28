(in-package :ahan-whun-shugoi)

(defun aws-ec2 (&rest option)
  (remove-if-not #'consp
                 (first (json:decode-json-from-string (apply #'aws :ec2 option)))))

(defclass ec2-instance ()
  ((instance-id :accessor instance-id
                :initarg :instance-id)
   (name :accessor name
         :initarg :name)
   (public-dns-name  :accessor public-dns-name
                     :initarg :public-dns-name )
   (public-ip-address :accessor public-ip-address
                      :initarg :public-ip-address)
   (private-ip-address :accessor private-ip-address
                       :initarg :private-ip-address)
   (key-name :accessor key-name
             :initarg :key-name)
   (state :accessor state
          :initarg :state)
   (contents :accessor contents
             :initarg :contents)))

(defun instance-at (plist)
  (second (assoc :*INSTANCES plist)))

(defun tag-at (instance)
  (cdr (assoc :*TAGS instance)))

(defun instance-id-at (instance)
  (cdr (assoc :*INSTANCE-ID instance)))

(defun name-at (instance)
  (cdr
   (assoc :*VALUE
          (find-if #'(lambda (data)
                       (string= (cdr (assoc :*KEY data)) "Name"))
                   (tag-at instance)))))

(defun public-dns-name-at (instance)
  (cdr (assoc :*public-dns-name instance)))

(defun public-ip-address-at (instance)
  (cdr (assoc :*public-ip-address instance)))

(defun private-ip-address-at (instance)
  (cdr (assoc :*private-ip-address instance)))

(defun key-name-at (instance)
  (cdr (assoc :*key-name instance)))

(defun state-at (instance)
  (cdr (assoc :*state instance)))

(defun plist2ec2-instance (plist)
  (let ((instance (instance-at plist)))
    (make-instance 'ec2-instance
                   :instance-id (instance-id-at instance)
                   :name (name-at instance)
                   :public-dns-name (public-dns-name-at instance)
                   :public-ip-address (public-ip-address-at instance)
                   :private-ip-address (private-ip-address-at instance)
                   :key-name (key-name-at instance)
                   :state (state-at instance)
                   :contents instance)))

(defun print-instance-1line (instance)
  (format t
          "| ~a | ~20a | ~15a | ~20a | ~a ~%"
          (instance-id instance)
          (name instance)
          (public-ip-address instance)
          (key-name instance)
          (cdr (assoc :*name (state instance)))))

(defmacro sort-instances (fuction instances)
  `(sort ,instances #'(lambda (a b) (string< (,fuction a) (,fuction b)))))

(defun print-all-instances (&key (instances (mapcar #'plist2ec2-instance (aws-ec2 "describe-instances"))))
  (dolist (instance (sort-instances name instances))
    (print-instance-1line instance)))

;; '(:|OwnerId| "..."
;;   :|Groups| NIL
;;   :|ReservationId| "..."
;;   :|Instances| ((:|AmiLaunchIndex| {integer}
;;                  :|Tags| ((:|Key| "..." :|Value| "..."))
;;                  :|VirtualizationType| "..."
;;                  :|RootDeviceName| "..."
;;                  :|RootDeviceType| "..."
;;                  :|Architecture| "..."
;;                  :|BlockDeviceMappings| ((:|Ebs| (:|AttachTime| "..."
;;                                                   :|VolumeId| "..."
;;                                                   :|DeleteOnTermination| {boolean}
;;                                                   :|Status| "...")
;;                                           :|DeviceName| "..."))
;;                  :|Hypervisor| "..."
;;                  :|Placement| (:|AvailabilityZone| "..."
;;                                :|GroupName| "..."
;;                                :|Tenancy| "...")
;;                  :|SourceDestCheck| {boolean}
;;                  :|NetworkInterfaces| ((:|PrivateIpAddress| "..."
;;                                         :|OwnerId| "..."
;;                                         :|Ipv6Addresses| NIL
;;                                         :|Groups| ((:|GroupId| "..."
;;                                                      :|GroupName| "..."))
;;                                         :|Attachment| (:|AttachTime| "..."
;;                                                        :|AttachmentId| "..."
;;                                                        :|DeleteOnTermination| {boolean}
;;                                                        :|DeviceIndex| {integer}
;;                                                        :|Status| "...")
;;                                         :|SubnetId| "..."
;;                                         :|PrivateIpAddresses| ((:|PrivateIpAddress| "..."
;;                                                                  :|Primary| {boolean}))
;;                                         :|NetworkInterfaceId| "..."
;;                                         :|Description| "..."
;;                                         :|VpcId| "..."
;;                                         :|SourceDestCheck| {boolean}
;;                                         :|MacAddress| "..."
;;                                         :|Status| "..."))
;;                  :|InstanceType| "..."
;;                  :|SubnetId| "..."
;;                  :|ClientToken| "..."
;;                  :|SecurityGroups| ((:|GroupId| "..."
;;                                      :|GroupName| "..."))
;;                  :|KeyName| "..."
;;                  :|PrivateDnsName| "..."
;;                  :|ImageId| "..."
;;                  :|EnaSupport| {boolean}
;;                  :|InstanceId| "..."
;;                  :|StateTransitionReason| "..."
;;                  :|VpcId| "..."
;;                  :|ProductCodes| NIL
;;                  :|PrivateIpAddress| "..."
;;                  :|LaunchTime| "..."
;;                  :|EbsOptimized| {boolean}
;;                  :|State| (:|Name| "..." :|Code| {integer})
;;                  :|PublicDnsName| "..."
;;                  :|Monitoring| (:|State| "..."))))
