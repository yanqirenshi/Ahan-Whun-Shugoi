(in-package :aws.cosmos)

;;;;;
;;;;; ELB LOG
;;;;;
(defun parse-elb-log-other (other)
  (assert other)
  (let ((other-itmes (split-sequence:split-sequence #\Space (string-trim '(#\Space #\Tab #\Newline) other))))
    (list :timestamp (local-time:parse-timestring (nth 0 other-itmes))
          :elb (nth 1 other-itmes)
          :client-port (nth 2 other-itmes)
          :backend-port (nth 3 other-itmes)
          :request_processing_time (read-from-string (nth 4 other-itmes))
          :backend_processing_time (read-from-string (nth 5 other-itmes))
          :response_processing_time (read-from-string (nth 6 other-itmes))
          :elb_status_code (read-from-string (nth 7 other-itmes))
          :backend_status_code (read-from-string (nth 8 other-itmes))
          :received_bytes (read-from-string (nth 9 other-itmes))
          :sent_bytes (read-from-string (nth 10 other-itmes)))))

(defun parse-elb-log (log)
  (let* ((regex "^(.*)\"(.*)\"\\s+\"(.*)\"\\s+(\\S+)\\s+(\\S+)$"))
    (multiple-value-bind (ret arr)
        (cl-ppcre:scan-to-strings regex log)
      (if ret
          (append (parse-elb-log-other (aref arr 0))
                  (list :request (aref arr 1)
                        :user-agent (aref arr 2)
                        :ssl-cipher (aref arr 3)
                        :ssl-protocol (aref arr 4)))
          (error "ログじゃないんじゃない？")))))

(defun parse-greped-elb-log (greped-log)
  (let ((pos (position #\: greped-log)))
    (append (list :file (subseq greped-log 0 pos))
            (parse-elb-log (subseq greped-log (+ 1 pos))))))

(defun parse-greped-elb-log-file (pathname)
  (let ((logs nil))
    (with-open-file (s pathname)
      (do ((l (read-line s) (read-line s nil 'eof)))
          ((eq l 'eof) logs)
        (push (parse-greped-elb-log l) logs)))))

;; (defparameter *redirect*
;;   (append (parse-greped-elb-log-file #P"/Users/yanqirenshi/Desktop/elb-log/redirect-1006.log")
;;           (parse-greped-elb-log-file #P"/Users/yanqirenshi/Desktop/elb-log/redirect-1007.log")))
;;
;; (defparameter *impression*
;;   (parse-greped-elb-log-file #P"/Users/yanqirenshi/Desktop/elb-log/allocate_impression-1007.log"))


(defun sort-elb-logs (elb-logs &key (operator #'local-time:timestamp<))
  (sort elb-logs
        #'(lambda (a b) (funcall operator (getf a :TIMESTAMP) (getf b :TIMESTAMP)))))

(defun log2tsc (log)
  (format nil "~a~c~a~c~a~c~a~%"
          (local-time:format-timestring nil (getf log :TIMESTAMP) :format '(:year "/" :month "/" :day " " :hour ":" :min ":" :sec "." :msec))
          #\Tab
          (getf log :elb)
          #\Tab
          (getf log :CLIENT-PORT)
          #\Tab
          (getf log :BACKEND-PORT)))
