(defpackage :matrix-reader
  (:use :cl)
  (:export :file-to-matrix :print-matrix :simbolo?))

(in-package :matrix-reader)

(defun read-file (file-path)
  "Reads the contents of a file and returns a list of strings."
  (with-open-file (stream file-path)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

(defun split-string (str &key (delimiter #\Newline))
  "Splits a string STR by the given delimiter, defaulting to newline."
  (loop with start = 0
        for pos = (position delimiter str :start start)
        collect (subseq str start pos)
        while pos
        do (setf start (1+ pos))))

(defun file-to-matrix (file-path)
  "Reads a file and returns a list of lists of characters."
  (mapcar (lambda (line) (map 'vector 'identity line)) (read-file file-path)))

(defun print-matrix (matrix)
  "Prints a matrix of characters."
  (loop for row in matrix
        do (loop for char in row
                 do (write char))
        (terpri))) ;; Move to the next line after each row

(defun simbolo? (x)
  "Checks if character X is a symbol (not a letter, digit, whitespace, or period)."
  (and (characterp x) 
       (not (alpha-char-p x))       ;; Not a letter
       (not (digit-char-p x))       ;; Not a digit
       (not (char= x #\Space))      ;; Not whitespace
       (not (char= x #\.))))         ;; Not a period

;; Example usage
(defun main ()
  (let ((matrix (file-to-matrix "input.txt"))) ;; Change the file name as needed
    (print-matrix matrix)
    (format t "~a" (simbolo? #\.))))             ;; Check if '.' is a symbol

;; To run the main function
(main)
