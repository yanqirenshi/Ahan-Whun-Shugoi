(in-package :aws.cosmos)

;; '(:|metricFilters|
;;   ((:|logGroupName| "/tatta-staging/web/nginx/access.log"
;;     :|filterPattern| "[remote, host, user, time, ms, request, code = 5**, size, referer, agent, forward]"
;;     :|creationTime| 1520213515002
;;     :|metricTransformations| ((:|metricName| "HTTP5xxErrors"
;;                                :|metricNamespace| "TATTA-Staging"
;;                                :|metricValue| "1"))
;;    :|filterName| "HTTP5xxErrors")))

(defun plist2metric-filter (plist)
  (make-instance 'metric-filter
                 :filter-name (getf plist :|filterName|)
                 :filter-pattern (getf plist :|filterPattern|)
                 :metric-transformations (getf plist :|metricTransformations|) ;; TODO: どうしよう。。
                 :log-group-name (getf plist :|logGroupName|)
                 :creation-time (getf plist :|creationTime|)))

(defun plists2metric-filter (plists)
  (mapcar #'plist2metric-filter (getf plists :|metricFilters|)))
