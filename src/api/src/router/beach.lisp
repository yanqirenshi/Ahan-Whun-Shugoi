(in-package :cl-user)
(defpackage ahan-whun-shugoi-api.beach
  (:use #:cl
        #:caveman2
        #:lack.middleware.validation
        #:ahan-whun-shugoi-api.config
        #:ahan-whun-shugoi-api.render
        #:aws-api.controller)
  (:export #:*api-beach*))
(in-package :ahan-whun-shugoi-api.beach)

;;;;;
;;;;; Application
;;;;;
(defclass <router> (<app>) ())
(defvar *api-beach* (make-instance '<router>))
(clear-routing-rules *api-beach*)

(defun graph () aws.beach.db:*graph*)

;;;;;
;;;;; Routing rules
;;;;;
(defroute "/" ()
  (render-json (list 4 5 6)))

(defroute "/vertex/aws" ()
  (render-json (get-aws)))

(defroute "/vertex/commands" ()
  (render-json (find-commands)))

(defroute "/vertex/commands/:_id" (&key _id)
  (let ((_id (validation _id :integer :require t)))
    (render-json (get-command-at-%id _id))))

(defroute "/vertex/subcommands" ()
  (render-json (find-subcommands)))

(defroute "/vertex/subcommands/:_id" (&key _id)
  (let ((_id (validation _id :integer :require t)))
    (render-json (get-subcommand-at-%id _id))))


(defroute "/vertex/options/:_id" (&key _id)
  (let ((_id (validation _id :integer :require t)))
    (render-json (get-option-at-%id _id))))

(defroute "/aws" ()
  (render-json (get-aws)))

(defroute "/aws/options" ()
  (render-json (find-aws-options (get-aws))))

(defroute "/aws/commands" ()
  (render-json (find-aws-commands (get-aws))))

;;;;;
;;;;; FINDER
;;;;;
(defroute "/finders" ()
  (render-json (aws.beach:find-finder)))

(defroute ("/finders/:code/look-at" :method :POST) (&key code _parsed)
  (let* ((code (alexandria:make-keyword (validation code :string :require t)))
         (look-at (jojo:parse (caar _parsed)))
         (finder (or (aws-api.controller:get-finder :code code)
                     (throw-code 404))))
    (render-json
     (aws-api.controller::update-finder-look-at finder
                                                (list :x (getf look-at :|x|)
                                                      :y (getf look-at :|y|)
                                                      :z (getf look-at :|z|))))))

(defroute ("/finders/:code/scale" :method :POST) (&key code _parsed)
  (let* ((code (alexandria:make-keyword (validation code :string :require t)))
         (scale (getf (jojo:parse (caar _parsed)) :|scale|))
         (finder (or (aws-api.controller:get-finder :code code)
                     (throw-code 404))))
    (render-json
     (aws-api.controller::update-finder-scale finder scale))))


;;;;;
;;;;; COMMANDS
;;;;;
(defroute "/commands/:_id/subcommands" (&key _id)
  (let ((_id (validation _id :integer :require t)))
    (render-json (find-command-subcommands (get-command-at-%id _id)))))

(defroute "/commands/:_id/display/:value" (&key _id value)
  (let* ((_id (validation _id :integer :require t))
         (value (cond ((string= "false" value) nil)
                      ((string= "true" value) t)
                      (t (throw-code 401))))
         (command (get-command :%id _id)))
    (unless command (throw-code 404))
    (render-json (update-node-display command value))))

(defroute ("/commands/:_id/location" :method :POST) (&key _id _parsed)
  (let* ((_id (validation _id :integer :require t))
         (location (jojo:parse (caar _parsed)))
         (command (or (aws-api.controller:get-command :%id _id)
                      (throw-code 404))))
    (render-json
     (update-node-location command location))))

;;;;;
;;;;; SUBCOMMANDS
;;;;;
(defroute "/subcommands/:_id/options" (&key _id)
  (let ((_id (validation _id :integer :require t)))
    (render-json (find-subcommand-options (get-subcommand-at-%id _id)))))

(defroute "/subcommands/:_id/display/:value" (&key _id value)
  (let* ((_id (validation _id :integer :require t))
         (value (cond ((string= "false" value) nil)
                      ((string= "true" value) t)
                      (t (throw-code 401))))
         (subcommand (get-subcommand :%id _id)))
    (unless subcommand (throw-code 404))
    (render-json (update-node-display subcommand value))))

(defroute ("/subcommands/:_id/location" :method :POST) (&key _id _parsed)
  (let* ((_id (validation _id :integer :require t))
         (location (jojo:parse (caar _parsed)))
         (subcommand (or (aws-api.controller:get-subcommand :%id _id)
                         (throw-code 404))))
    (render-json
     (update-node-location subcommand location))))

;;;;;
;;;;; OPTONS
;;;;;
(defroute "/options/:_id/display/:value" (&key _id value)
  (let* ((_id (validation _id :integer :require t))
         (value (cond ((string= "false" value) nil)
                      ((string= "true" value) t)
                      (t (throw-code 401))))
         (option (get-option :%id _id)))
    (unless option (throw-code 404))
    (render-json (update-node-display option value))))

(defroute ("/options/:_id/location" :method :POST) (&key _id _parsed)
  (let* ((_id (validation _id :integer :require t))
         (location (jojo:parse (caar _parsed)))
         (option (or (get-option :%id _id)
                     (throw-code 404))))
    (render-json
     (update-node-location option location))))

;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <router>) (code (eql 404)))
  (declare (ignore app))
  "404")
