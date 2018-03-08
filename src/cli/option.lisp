(in-package :cl-user)
(defpackage ahan-whun-shugoi.cli.option
  (:nicknames :aws.cli.option)
  (:use :cl :aws.scraping)
  (:export #:opt2cmd))
(in-package :ahan-whun-shugoi.cli.option)


(defun get-option-values (options)
  (let ((first-keyword-position (position-if (lambda (v) (keywordp v)) options)))
    (if (null first-keyword-position)
        options
        (subseq options 0 first-keyword-position))))

(defun assert-option-values (option-table-values option-values)
  (assert (= (length option-table-values)
             (length option-values))))

(defun get-master-option (master option-code)
  (when master
    (let ((option (car master)))
      (if (eq option-code (aws.scraping::code option))
          option
          (get-master-option (cdr master) option-code)))))

(defun %opt2cmd (options master)
  (when options
    (let* ((option-code (car options))
           (option-master (get-master-option master option-code)))
      (assert (keywordp option-code)
              (option-code) "option-code ist not keyword. option-code= ~S" option-code)
      (assert option-master
              (option-code)
              "Cannot find master ~S." option-code)
      (let ((option-values (get-option-values (cdr options))))
        (concatenate 'string
                     (if (eq :test option-code)
                         ""
                         (format nil " ~(~a~) ~{\"~a\"~}" option-code option-values))
                     (%opt2cmd (subseq options (+ 1 (length option-values))) master))))))

(defun opt2cmd (options &key master)
  (if (null options)
      ""
      (%opt2cmd options master)))
