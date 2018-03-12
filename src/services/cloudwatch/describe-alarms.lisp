(in-package :ahan-whun-shugoi)

;; '(:|MetricName| "CPUUtilization"
;;   :|ActionsEnabled| T
;;   :|OKActions| NIL
;;   :|InsufficientDataActions| NIL
;;   :|StateReason| "Threshold Crossed: 1 datapoint [79.625 (23/01/18 16:49:00)] was not greater than or equal to the threshold (80.0)."
;;   :|Statistic| "Average"
;;   :|Dimensions| ((:|Value| "run-passport-production" :|Name| "DBInstanceIdentifier"))
;;   :|AlarmName| "awsrds-run-passport-production-High-CPU-"
;;   :|Threshold| 80.0
;;   :|StateValue| "OK"
;;   :|Period| 300
;;   :|StateReasonData| "{\"version\":\"1.0\",\"queryDate\":\"2018-01-23T16:54:19.097+0000\",\"startDate\":\"2018-01-23T16:49:00.000+0000\",\"statistic\":\"Average\",\"period\":300,\"recentDatapoints\":[79.625],\"threshold\":80.0}"
;;   :|Namespace| "AWS/RDS"
;;   :|AlarmActions| ("arn:aws:sns:ap-northeast-1:224455897222:glpgs-rbp-developers")
;;   :|ComparisonOperator| "GreaterThanOrEqualToThreshold"
;;   :|AlarmConfigurationUpdatedTimestamp| "2017-12-25T02:58:27.704Z"
;;   :|StateUpdatedTimestamp| "2018-01-23T16:54:19.114Z"
;;   :|AlarmArn| "arn:aws:cloudwatch:ap-northeast-1:224455897222:alarm:awsrds-run-passport-production-High-CPU-"
;;   :|EvaluationPeriods| 1)

(defun plist2metric-alarm (plist)
  (make-instance 'metric-alarm
                 :metric-name                           (getf plist :|MetricName|)
                 :actions-enabled                       (getf plist :|ActionsEnabled|)
                 :ok-actions                            (getf plist :|OKActions|)
                 :insufficient-data-actions             (getf plist :|InsufficientDataActions|)
                 :state-reason                          (getf plist :|StateReason|)
                 :statistic                             (getf plist :|Statistic|)
                 :dimensions                            (make-dimensions plist)
                 :alarm-name                            (getf plist :|AlarmName|)
                 :threshold                             (getf plist :|Threshold|)
                 :state-value                           (getf plist :|StateValue|)
                 :period                                (getf plist :|Period|)
                 :state-reason-data                     (getf plist :|StateReasonData|)
                 :namespace                             (getf plist :|Namespace|)
                 :alarm-actions                         (getf plist :|AlarmActions|)
                 :comparison-operator                   (getf plist :|ComparisonOperator|)
                 :alarm-configuration-updated-timestamp (getf plist :|AlarmConfigurationUpdatedTimestamp|)
                 :state-updated-timestamp               (getf plist :|StateUpdatedTimestamp|)
                 :alarm-arn                             (getf plist :|AlarmArn|)
                 :evaluation-periods                    (getf plist :|EvaluationPeriods|)))

(defun plists2metric-alarm (plist)
  (mapcar #'plist2metric-alarm
          (getf plist :|MetricAlarms|)))
