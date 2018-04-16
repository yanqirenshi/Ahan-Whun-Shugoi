(in-package :aws.cosmos)

;; '(:|metricFilters|
;;   ((:|logGroupName| ""
;;     :|filterPattern| ""
;;     :|creationTime| 1520213515002
;;     :|metricTransformations| ((:|metricName| ""
;;                                :|metricNamespace| ""
;;                                :|metricValue| ""))
;;    :|filterName| "")))

(defun plist2metric-filter (plist)
  (make-instance 'metric-filter
                 :filter-name (getf plist :|filterName|)
                 :filter-pattern (getf plist :|filterPattern|)
                 :metric-transformations (getf plist :|metricTransformations|) ;; TODO: どうしよう。。
                 :log-group-name (getf plist :|logGroupName|)
                 :creation-time (getf plist :|creationTime|)))

(defun plists2metric-filter (plists)
  (mapcar #'plist2metric-filter (getf plists :|metricFilters|)))
