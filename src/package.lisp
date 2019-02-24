(defpackage #:noloop.conf
  (:use #:common-lisp)
  (:nicknames #:conf)
  (:import-from #:cl-fad
                #:merge-pathnames-as-file)
  (:export #:init-conf
           #:set-conf-directory
           #:get-conf-directory
           #:set-conf-file
           #:get-conf-file
           #:get-conf-full-path
           #:replace-conf
           #:get-conf-hash))
