;; Ensure you have the necessary libraries
(ql:quickload :cl-ppcre)
(ql:quickload :split-sequence)
(ql:quickload :str)


(defparameter *input* "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")

(defun extract-game-id (game-token)
  ;; INPUT: "Game 1"
  (cadr (str:split " " game-token)))
(extract-game-id (*input*))

(defun extract-games (games)
  ;; INPUT: "10 red, 7 green, 3 blue; 5 blue, 3 red, 10 green; 4 blue, 14 green, 7 red;"
  (str:split ";" games :omit-nulls t))
