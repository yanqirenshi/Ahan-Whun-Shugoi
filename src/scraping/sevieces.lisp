(in-package :ahan-whun-shugoi.scraping)

(defun a-tag2service (tag)
  (make-instance 'service
                 :code (pt-attrs (first (pt-children tag)))
                 :uri (getf (pt-attrs tag) :href)
                 :description nil))
