(in-package #:cl-user)
(defpackage #:noloop.conf-test
  (:use #:common-lisp)
  (:nicknames #:conf-test)
  (:import-from #:conf
                #:init-conf
                #:set-conf-directory
                #:get-conf-directory
                #:set-conf-file
                #:get-conf-file
                #:get-conf-full-path
                #:replace-conf))
(in-package #:noloop.conf-test)

;; Simple Test Runner
(defun run ()
  (let ((results '()))
    (conf::save-file "/tmp/conf-test.conf" "(:field-1 \"value1\" 
:field-2 \"value2\")")
    (format t "Test set-conf-directory and get-conf-directory: ~a~%"
            (push (test-set-conf-directory) results))
    (format t "Test set-conf-file and get-conf-file: ~a~%"
            (push (test-set-conf-file) results))
    (format t "Test get-conf-full-path: ~a~%"
            (push (test-get-conf-full-path) results))
    (format t "Test load-conf-file-for-hash-table: ~a~%"
            (push (test-load-conf-file-for-hash-table) results))
    (format t "~%Test save-conf-file: ~a~%"
            (push (test-save-conf-file) results))
    (delete-file "/tmp/conf-test.conf")
    (format t "Test result: ~a" (every #'(lambda (el) (equal t el)) results))))

(defun test-set-conf-directory ()
  (let ((conf (init-conf "~/.conf/" "some.conf")))
    (set-conf-directory conf "/tmp/")
    (and (string= "/tmp/" (get-conf-directory conf)))))

(defun test-set-conf-file ()
  (let ((conf (init-conf "~/.conf/" "some.conf")))
    (set-conf-file conf "conf-test.conf")
    (and (string= "conf-test.conf" (get-conf-file conf)))))

(defun test-get-conf-full-path ()
  (let ((conf (init-conf "~/.conf/" "some.conf")))
    (set-conf-directory conf "/tmp/")
    (set-conf-file conf "conf-test.conf")
    (and (string= "/tmp/conf-test.conf" (get-conf-full-path conf)))))

;;; I do not know how to test the "replace-conf" function 
;;; because it requires user interaction when using "read-line", 
;;; so I will simply test the built-in functions that make it up.

(defun test-load-conf-file-for-hash-table ()
  (let ((conf (init-conf "~/.conf/" "some.conf"))
        (expected-hash (make-hash-table)))
    (set-conf-directory conf "/tmp/")
    (set-conf-file conf "conf-test.conf")
    (setf (gethash :field-1 expected-hash) "value1"
          (gethash :field-2 expected-hash) "value2")
    (and (equalp expected-hash (conf::load-conf-file-for-hash-table conf)))))

(defun test-save-conf-file ()
  (let ((conf (init-conf "~/.conf/" "some.conf"))
        (expected-hash (make-hash-table)))
    (set-conf-directory conf "/tmp/")
    (set-conf-file conf "conf-test.conf")
    (setf (gethash :field-1 expected-hash) "value1"
          (gethash :field-2 expected-hash) "value2")
    (conf::save-conf-file conf expected-hash)
    (and (equalp expected-hash (conf::load-conf-file-for-hash-table conf)))))
