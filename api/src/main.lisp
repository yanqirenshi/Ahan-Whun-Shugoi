(in-package :cl-user)
(defpackage ahan-whun-shugoi-api
  (:nicknames :aws.api)
  (:use :cl)
  (:import-from #:ahan-whun-shugoi-api.config
                #:config)
  (:import-from #:clack
                #:clackup)
  (:export #:start
           #:stop))
(in-package :ahan-whun-shugoi-api)

(defvar *appfile-path*
  (asdf:system-relative-pathname :ahan-whun-shugoi-api #P"src/app.lisp"))

(defvar *handler* nil)

(defun start (&rest args &key
                           (server (config :http :server :type))
                           (port (config :http :server :port))
                           debug &allow-other-keys)
  (declare (ignore debug))
  (unless server (error "(config :http :server :type) is nil"))
  (unless port (error "(config :http :server :port) is nil"))
  (when *handler*
    (restart-case (error "Server is already running.")
      (restart-server ()
        :report "Restart the server"
        (stop))))
  (setf *handler*
        (apply #'clackup *appfile-path* :server server :port port args)))

(defun stop ()
  (prog1
      (clack:stop *handler*)
    (setf *handler* nil)))
