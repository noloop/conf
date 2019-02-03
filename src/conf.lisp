(in-package #:noloop.conf)

#|
Configuration file example(my-file.conf):

(:author "Unknown"
:maintainer ":AUTHOR"
:license "UNLICENSED"
:version "0.0.0"
:git-service "github")
|#

(defun init-conf (directory file-name)
  (reverse (pairlis (list :conf-file-directory :conf-file-name)
                    (list directory file-name))))

(defun set-conf-directory (conf new-directory)
  (setf (cdr (assoc :conf-file-directory conf)) new-directory))

(defun get-conf-directory (conf)
  (cdr (assoc :conf-file-directory conf)))

(defun set-conf-file (conf new-file-name)
  (setf (cdr (assoc :conf-file-name conf)) new-file-name))

(defun get-conf-file (conf)
  (cdr (assoc :conf-file-name conf)))

(defun get-conf-full-path (conf)
  (concatenate 'string (get-conf-directory conf) (get-conf-file conf)))

(defun replace-conf (conf)
  (let ((new-conf (load-conf-file-for-hash-table conf)))
    (replace-conf-fields new-conf)
    (save-conf-file conf new-conf)))

(defun load-conf-file-for-hash-table (conf)
  (list-for-hash-table
   (load-file (get-conf-full-path conf))))


(defun replace-conf-fields (your-hash)
  (maphash #'(lambda (key value)
               (let ((input (read-field (string key) value)))
                 (cond ((string-not-equal "" input)
                        (setf (gethash key your-hash) input)))))
           your-hash))

(defun save-conf-file (conf conf-hash)
  (save-file (get-conf-full-path conf)
             (hash-table-for-string conf-hash)))

(defun read-field (field-name actual-value)
  (format t "~a?(actual ~a) " field-name actual-value)
  (read-line))

(defun list-for-hash-table (your-list)
  (do ((i 0 (+ 2 i))
       (new-list your-list (cddr new-list))
       (new-hash (make-hash-table)))
      ((<= (length your-list) i) new-hash)
    (let ((key (first new-list)) (value (second new-list)))
      (setf (gethash key new-hash) value))))

(defun hash-table-for-string (your-hash)
  (let ((stg "") (i 0))
    (maphash #'(lambda (key value)
                 (setf stg (concatenate 'string stg
                                        ":" (string key) " "
                                        "\"" (string value) "\" "
                                        (if (< i (- (hash-table-count your-hash) 1))
                                            '(#\newline))))
                 (incf i))
             your-hash)
    (concatenate 'string "(" (string-trim '(#\space) stg) ")")))

(defun save-file (file-name stg)
  (with-open-file (out file-name
                       :direction :output
                       :if-exists :supersede)
    (with-standard-io-syntax
      (format out "~a" stg)))
  (format t "~%File saved successfully."))

(defun load-file (file-name)
  (with-open-file (in file-name)
    (with-standard-io-syntax
      (read in))))
