(in-package :aws.cosmos)

;; '(:|MetricName| "HealthyHostCount"
;;   :|Dimensions| ((:|Value| "targetgroup/AWB-Book-Routing-target-group/22503f9a99b7d0d2"
;;                   :|Name| "TargetGroup")
;;                  (:|Value| "app/External-Web-iwasaki/c98edf0ef95334ff"
;;                   :|Name| "LoadBalancer")
;;                  (:|Value| "ap-northeast-1b"
;;                   :|Name| "AvailabilityZone"))
;;   :|Namespace| "AWS/ApplicationELB")

(defun plist2metrics (plist)
  (make-instance 'metrics
                 :namespace (getf plist :|Namespace|)
                 :metric-name (getf plist :|MetricName|)
                 :dimensions (mapcar #'(lambda (dim)
                                         (list :name (getf dim :|Name|)
                                               :value (getf dim :|Value|)))
                                     (getf plist :|Dimensions|))))

(defun plists2metrics (plist)
  (mapcar #'plist2metrics
          (getf plist :|Metrics|)))
