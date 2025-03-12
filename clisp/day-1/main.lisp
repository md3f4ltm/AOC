(defun read-input-file (filename)
  (with-open-file (in filename)
    (let ((contents (make-string (file-length in))))
      (read-sequence contents in)contents)))

(print(read-input-file "input.txt"))

(defun calculate-final-floor (instructions)
  (let ((current-floor 0))
    (loop for char across instructions
          do (case char
               (#\( (incf current-floor))
               (#\) (decf current-floor))))
    current-floor))

(defun find-basement-pos (instructions)
  (let (( current-floor 0))
    (loop for char across instructions
          for position from 1
          do (case char
               (#\( (incf current-floor))
               (#\) (decf current-floor)))
          when (< current-floor 0)
            return position)))

(defun main ()
  (let* ((input (read-input-file "input.txt"))
         (final-floor (calculate-final-floor input))
         (position (find-basement-pos input)))
    (print final-floor)
    (print position)))
(main)
