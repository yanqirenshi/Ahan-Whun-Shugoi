(ql:quickload :ahan-whun-shugoi-api)

(defpackage ahan-whun-shugoi-api.app
  (:use :cl)
  (:import-from #:lack.builder
                #:builder)
  (:import-from #:ppcre
                #:scan
                #:regex-replace)
  (:import-from #:ahan-whun-shugoi-api.router
                #:*route*)
  (:import-from #:ahan-whun-shugoi-api.api-v1
                #:*api-v1*)
  (:import-from #:ahan-whun-shugoi-api.beach
                #:*api-beach*)
  (:import-from #:ahan-whun-shugoi-api.config
                #:config))
(in-package :ahan-whun-shugoi-api.app)

(builder
 :accesslog
 (if (config :log :error :directory)
     `(:backtrace
       :output ,(config :log :error :directory))
     nil)
 :session
 :validation
 (:mount "/beach" *api-beach*)
 *api-v1*)
