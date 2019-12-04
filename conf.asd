;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(defsystem :conf
  :author "noloop <noloop@zoho.com>"
  :maintainer "noloop <noloop@zoho.com>"
  :license "GPLv3"
  :version "1.0.1"
  :homepage "https://github.com/noloop/conf"
  :bug-tracker "https://github.com/noloop/conf/issues"
  :source-control (:git "git@github.com:noloop/conf.git")
  :description "Simple configuration file manipulator for projects."
  :depends-on (:cl-fad)
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "conf" :depends-on ("package")))))
  :in-order-to ((test-op (test-op "conf/test"))))

(defsystem :conf/test
  :author "noloop <noloop@zoho.com>"
  :maintainer "noloop <noloop@zoho.com>"
  :license "GNU General Public License v3.0"
  :description "conf Test."
  :depends-on (:conf)
  :components ((:module "test"
                :components
                ((:file "conf-test"))))
  :perform (test-op (op system) (funcall (read-from-string "conf-test::run"))))
