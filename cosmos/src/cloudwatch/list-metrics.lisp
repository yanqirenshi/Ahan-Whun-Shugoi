(in-package :aws.cosmos)

;; '(:|MetricName| ""
;;   :|Dimensions| ((:|Value| ""
;;                   :|Name| "TargetGroup")
;;                  (:|Value| ""
;;                   :|Name| "LoadBalancer")
;;                  (:|Value| ""
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
