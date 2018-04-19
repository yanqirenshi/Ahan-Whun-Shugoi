#|
This file is a part of ahan-whun-shugoi project.
Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

#|
Author: Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

(in-package :cl-user)
(defpackage ahan-whun-shugoi-asd
  (:use :cl :asdf))
(in-package :ahan-whun-shugoi-asd)

(defsystem ahan-whun-shugoi
  :version "0.1"
  :author "Satoshi Iwasaki"
  :license "MIT"
  :depends-on (:cl-ppcre
               :local-time
               :trivial-shell
               :split-sequence
               :jonathan
               :upanishad
               :shinrabanshou
               :closure-html
               :quri
               :dexador
               :lparallel
               :ahan-whun-shugoi.beach)
  :components ((:module "core"
                :serial t
                :components
                ((:module "db" :components ((:file "graph")))
                 (:module "cmd-builder" :components ((:file "config")
                                                     (:file "option")
                                                     (:file "command")))
                 (:module "helper" :components ((:file "help")))
                 (:file "package")
                 (:file "condition")
                 (:file "aws"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op ahan-whun-shugoi-test))))
