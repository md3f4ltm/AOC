"day-3"

(defun part1 (directions)
  "Calculates the number of unique houses Santa visits in part1."
  (let ((visited (make-hash-table :test 'equal))
        (x 0)
        (y 0))
    (setf (gethash (list x y) visited) t)
    (loop for ch across directions do
       (case ch
         (#\^ (incf y))
         (#\v (decf y))
         (#\> (incf x))
         (#\< (decf x)))
       (setf (gethash (list x y) visited) t))
    (hash-table-count visited)))

(defun part2 (directions)
  "Calculates the number of unique houses visited in part2 with Santa and Robo-Santa."
  (let ((visited (make-hash-table :test 'equal))
        (santa-x 0) (santa-y 0)
        (robo-x 0) (robo-y 0))
    (setf (gethash (list 0 0) visited) t)
    (loop for ch across directions
          for i from 0 do
            (if (evenp i)  ; Santa moves on even indices
                (progn
                  (case ch
                    (#\^ (incf santa-y))
                    (#\v (decf santa-y))
                    (#\> (incf santa-x))
                    (#\< (decf santa-x)))
                  (setf (gethash (list santa-x santa-y) visited) t))
                (progn        ; Robo-Santa moves on odd indices
                  (case ch
                    (#\^ (incf robo-y))
                    (#\v (decf robo-y))
                    (#\> (incf robo-x))
                    (#\< (decf robo-x)))
                  (setf (gethash (list robo-x robo-y) visited) t))))
    (hash-table-count visited)))

(defun main ()
  "Reads input directions from 'input.txt', computes and prints both answers."
  (with-open-file (stream "input.txt" :direction :input)
    (let ((directions (read-line stream nil)))
      (format t "Part 1: ~A~%" (part1 directions))
      (format t "Part 2: ~A~%" (part2 directions)))))

;; To run the solution, call:
(main)
