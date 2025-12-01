(defun parse-dim (line)
  (mapcar #'parse-integer (uiop:split-string line :separator "x")))


(defun surface-area (dimensions)
  (let* ((l(first dimensions))
         (w (second dimensions))
         (h(third dimensions))
         (lw (* l w))
         (wh (* w h))
         (hl (* h l))
         (sm (min lw wh hl)))
    (+ (* 2 wh)(* 2 lw)(* 2 hl) sm)))

(print (surface-area (parse-dim "2x3x4")))

(defun ribbon (dimensions)
  (let* ((l(first dimensions))
         (w (second dimensions))
         (h(third dimensions)))
    (min (+ (* 2 l) (* 2 w))
         (+ (* 2 w) (* 2 h))
         (+ (* 2 h)(* 2 l)))))

(defun volume (dimensions)
  (apply #'* dimensions))

(defun ribbon-needed (dimensions)
  (+ (ribbon dimensions) (volume dimensions)))

(defun solve-puzzle (file-path)
  (with-open-file (stream file-path)
    (let((total-paper 0)
         (total-ribbon 0))
      (loop for line = (read-line stream nil nil)
            while line
            for dimensions = (parse-dim line)
            do (incf total-paper (surface-area dimensions))
               (incf total-ribbon (ribbon-needed dimensions)))
      (print total-paper)
      (print total-ribbon))))

(solve-puzzle "input.txt")
