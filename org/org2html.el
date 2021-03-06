#!/usr/bin/emacs --batch --script
;; Author: amoblin <amoblin@gmail.com>
;; File Name: org2html.el
;; Create Time: 2013-12-09 17:25
;; This file is created from ~Marboo/media/file_init/default.init.el
;; 本文件由 ~Marboo/media/file_init/default.init.el　复制而来

(defun is-option (str)
  ;; return true if string looks like a command line option
  (string-equal (substring str 0 1) "-"))

(defun get-option (args opt &optional default)
  ;; Return the value of "opt" from "args"; if there is no value for
  ;; "opt" return "default" if provided, otherwise raise an error.
  (or (or (gethash opt args) default)
      (error (format "Error: option -%s is required" opt))))

(defun replace-all (from-str to-str)
  ;; replace all occurrences of from-str with to-str
  (progn
    (beginning-of-buffer)
    (while (search-forward from-str nil t)
      (replace-match to-str nil t))))

;; allows arbitrary command line arguments
(defun do-nothing () t)
(setq command-line-functions '(do-nothing))

;; store option, value pairs in hash-map `args`
(defvar args (make-hash-table :test 'equal))

;; process command-line-args
(setq clargs command-line-args)
(while clargs
  (setq opt (car clargs))
  (setq val (car (cdr clargs)))
  (if (and (is-option opt) (not (is-option val)))
      (puthash (substring opt 1 nil) val args))
  (setq clargs (cdr clargs)))

(setq infile (get-option args "infile"))
(setq outfile (get-option args "outfile"))

(setq infile-temp (make-temp-name ".org2html-"))
;(copy-file infile infile-temp t) ;; copy in orgfile
;(find-file infile-temp)
(find-file infile)


;(message "Exporting file:%s to HTML" infile)

;(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")))

;(require 'package)
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/org-20140331/"))

;(require 'org)
;(require 'org-macro)
;(require 'ox)
;(package-initialize)

(org-mode)
(message (version))
(message (org-version))

;; 7.9.3
;(setq optional nil
;      to-buffer "*org-html-export*"
;      body-only t)

;(org-export-as-html 3 optional to-buffer body-only)
(call-interactively 'org-export-as-html)
;(org-export-as-html)

;; >= 8.0.0
;(org-html-export-as-html)
;(org-html-export-as-html nil nil nil nil)
;(org-html-export-as-html nil nil nil t)
;(call-interactively 'org-html-export-as-html)

;(unless (version-list-< (version-to-list (org-version)) '(8 0 0))
;  (org-html-export-as-html nil nil nil nil))

;(write-file outfile)

;; References:
;;
;; https://github.com/steshaw/shelly/blob/master/bin/org2html
;; https://github.com/nhoffman/org-export/blob/master/org2html.el
