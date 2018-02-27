(in-package :ahan-whun-shugoi.scraping)

(defun html2pt (uri)
  (chtml:parse (dex:get uri) (chtml:make-pt-builder)))

(defun pt-classes (tag)
  (let ((classes (getf (pt-attrs tag) :class)))
    (when classes
      (split-sequence:split-sequence #\Space classes))))

(defun find-tag-target-tag-p (tag conds)
  (if (not conds)
      t
      (when (funcall (car conds) tag)
        (find-tag-target-tag-p tag (cdr conds)))))

(defun find-tag (tag &rest conds)
  (if (find-tag-target-tag-p tag conds)
      (list tag)
      (let ((out nil))
        (dolist (child (pt-children tag))
          (when-let ((ret (apply #'find-tag child conds)))
            (setf out (nconc out ret))))
        out)))


;;;
;;; finder conditions
;;;
(defun is-div (tag)
  (eq :div (pt-name tag)))

(defun class-is-section (tag)
  (find "section" (pt-classes tag) :test 'equal))

(defun id-is (tag id)
  (let ((attr (pt-attrs tag)))
    (string= id (getf attr :id))))

(defun id-is-description (tag)
  (let ((attr (pt-attrs tag)))
    (string= "description" (getf attr :id))))

(defun id-is-synopsis (tag)
  (id-is tag "synopsis"))

(defun id-is-options (tag)
  (id-is tag "options"))

(defun id-is-available-services (tag)
  (id-is tag "available-services"))

(defun find-description (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-description)))

(defun find-synopsis (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-synopsis)))

(defun find-options (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-options)))

(defun find-available-services (html)
  (car (find-tag html
                 #'is-div
                 #'class-is-section
                 #'id-is-available-services)))
