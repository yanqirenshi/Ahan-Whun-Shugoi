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
               :cl-json ;; TODO: これいる？
               :local-time
               :trivial-shell
               :jonathan
               :upanishad
               :shinrabanshou
               :closure-html
               :quri
               :dexador)
  :components ((:module "src"
                :components
                ((:file "html")
                 (:module "scraping"
                  :components ((:file "package")
                               (:file "util")
                               (:file "classes")
                               (:file "sevieces")
                               (:file "aws")))
                 (:file "package")
                 (:module "graph"
                  :components ((:file "graph")))
                 (:module "ec2"
                  :components ((:file "cmds")
                               (:file "ec2")))
                 (:module "elb"
                  :components ((:file "elb")))
                 (:module "s3"
                  :components ((:file "class")
                               (:file "cmds")
                               (:file "s3" :depends-on ("class"))))
                 (:file "aws" :depends-on ("package")))))

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
