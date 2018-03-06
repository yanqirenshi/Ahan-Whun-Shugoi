(in-package :ahan-whun-shugoi)

(defun options-table ()
  '((:--profile 'string)
    (:--log-group-name 'string)
    (:--log-stream-name 'string)
    (:--filter-pattern 'string)
    (:--start-time 'long)
    (:--end-time  'long)
    (:test 'boolean)))

(defun get-option-values (options)
  (let ((first-keyword-position (position-if (lambda (v) (keywordp v)) options)))
    (if (null first-keyword-position)
        options
        (subseq options 0 first-keyword-position))))

(defun assert-option-values (option-table-values option-values)
  (assert (= (length option-table-values)
             (length option-values))))

(defun opt2cmd (options &key (options-table (options-table)))
  (when options
    (let* ((option (car options))
           (option-table (assoc option options-table)))
      (assert (keywordp option))
      (assert option-table)
      (let ((option-table-values (cdr option-table))
            (option-values (get-option-values (cdr options))))
        (assert-option-values option-table-values option-values)
        (concatenate 'string
                     (if (eq :test option)
                         ""
                         (format nil "~(~a~) ~{\"~a\" ~}" option option-values))
                     (opt2cmd (subseq options (+ 1 (length option-values)))))))))
