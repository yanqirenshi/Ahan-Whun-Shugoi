(in-package :aws.cosmos)

(defun str2timestamp (str)
  "TODO: まとめよう。 util に。"
  (when str
    (local-time:parse-timestring str)))

(defun state-reason-data2plist (str)
  (let ((plist (jojo:parse str)))
    (list :threshold (getf plist :|threshold|)
          :recent-datapoints (getf plist :|recentDatapoints|)
          :period (getf plist :|period|)
          :statistic (getf plist :|statistic|)
          :start-date (str2timestamp (getf plist :|startDate|))
          :query-date (str2timestamp (getf plist :|queryDate|))
          :version (getf plist :|version|))))

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
                 :state-reason-data                     (state-reason-data2plist (getf plist :|StateReasonData|))
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
