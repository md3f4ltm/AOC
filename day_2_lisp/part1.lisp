;; Ensure you have the necessary libraries
(ql:quickload :cl-ppcre)
(ql:quickload :split-sequence)
(ql:quickload :str)

;; Max 12 red, 13 green, 14 blue
;; reads a file and returns a list of lines
(defparameter *input* "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")

(defun read-file (filename)
  "-> (list of lines from the file)"
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

(defun extract-game-id (game-token)
  "-> game number (integer)"
  (let* ((split (str:split " " game-token))
         (id-with-colon (cadr split)))
    (subseq id-with-colon 0 (position #\: id-with-colon)))) 

(defun game-sets (line)
  "-> (list of game sets)"
  (let* ((pos (search ":" line)))
    (let* ((cleaned-line (subseq line (+ pos 2)))
           (game-sets (split-sequence:split-sequence #\; cleaned-line)))
      game-sets)))

(print (game-sets *input*))

(defun game-sets-part (game-set)
  "-> (list of parts of game set)"
  (let ((game-set-parts (str:split "," game-set)))
    (mapcar #'(lambda (part) (str:trim part))
            game-set-parts)))

(print (game-sets-part "3 red, 4 green, 5 blue"))

(defun parse-quantity-color (part)
  "-> (list (quantity integer) (color symbol))"
  (let* ((split (split-sequence:split-sequence #\space part))
         (quantity (parse-integer (first split)))
         (color (intern (string-downcase (second split)))))
    (format t "quantity: ~a, color: ~a~%" quantity color)
    (list quantity color)))

(print (parse-quantity-color "3 red"))

(defun set-possible (list1)
  "-> T if list1 is a subset of '(12 13 14), otherwise NIL"
  (let ((list2 '(12 13 14)))
    (notany #'> list1 list2)))

(print "Next debug step")

(defun assign-color-quantity (lst)
  "-> (list (red integer) (green integer) (blue integer))"
  (defparameter blue 0)
  (defparameter red 0)
  (defparameter green 0)
  (destructuring-bind (quantity color) lst
    (cond
      ((eql color '|blue|) (setf blue quantity))
      ((eql color '|red|) (setf red quantity))
      ((eql color '|green|) (setf green quantity))
      (t (error "Unknown color: ~a" color))))
  (list red green blue))

(defun add-game-possible-part1 (lines)
  "-> total sum of possible game IDs (integer)"
  (let ((total-sum 0))
    (loop for line in lines do
      (let* ((game-id (parse-integer (extract-game-id line)))
             (game-sets (game-sets line))
             (all-sets-possible t))
        (print (first game-sets))
        (print (format nil "GAME ID:~a" game-id))
        (dolist (game-set game-sets)
          (let ((set-parts (game-sets-part game-set)))
            (dolist (part set-parts)
              (let ((color-quantity (assign-color-quantity (parse-quantity-color part))))
                (unless (set-possible color-quantity)
                  (setf all-sets-possible nil))))))
        (when all-sets-possible
          (incf total-sum game-id))))
    total-sum))

(defun power-of-cubes (lines)
  "-> total sum of products of minimum colors (integer)"
  (let ((total-sum 0))
    (loop for line in lines do
      (let* ((min-colors (list 1 1 1))
             (game-sets (game-sets line)))
        (dolist (game-set game-sets)
          (let ((set-parts (game-sets-part game-set)))
            (dolist (part set-parts)
              (let ((color-quantity (assign-color-quantity (parse-quantity-color part))))
                (loop for i from 0 to 2 do
                  (when (> (nth i color-quantity) (nth i min-colors))
                    (setf (nth i min-colors) (nth i color-quantity))))))))
        (let ((product (* (nth 0 min-colors)
                          (nth 1 min-colors)
                          (nth 2 min-colors))))
          (incf total-sum product))))
    total-sum))

(print (set-possible '(12 14 14))) ;; This will return F
(print (format nil "Part 1:~a" (add-game-possible-part1 (read-file "input.txt"))))
(print (format nil "Part 2:~a" (power-of-cubes (read-file "input.txt"))))
