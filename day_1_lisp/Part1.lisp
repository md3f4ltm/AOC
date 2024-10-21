(ql:quickload "cl-ppcre")

(defun collect-lines (filename)
  "Read all lines from the file and print them."
  (with-open-file (in filename)
    (loop for line = (read-line in nil)
          while line
          collect line)))

;;Print the lines of the file

(defun print-lines (filename)
  "Print all lines from the file."
  (dolist (line (collect-lines filename))
    (format t "~A~%" line)))
(print-lines "1.txt")

(defun first-and-last-digit (line)
  "Extract the first and last digits from a string."
  (let* ((digits (remove-if-not #'digit-char-p line)))
    (if (and digits (> (length digits) 0))
        (list (char digits 0) (char digits (1- (length digits))))  ;; First and last digit
        nil)))

(defun print-first-and-last-digits (filename)
  "Print the first and last digits for each line in the file and calculate their sum."
  (let ((total-sum 0))  ; Initialize the sum variable
    (dolist (line (collect-lines filename))
      (let ((digits (first-and-last-digit line)))
        (if digits
            (let* ((first-digit (first digits))
                   (last-digit (second digits))
                   (concatenated (concatenate 'string (list first-digit last-digit)))  ; Concatenate digits
                   (concatenated-int (parse-integer concatenated)))  ; Convert to integer
              (setf total-sum (+ total-sum concatenated-int))  ; Add to the total sum
              ;; Print the first and last digits
              (format t "Line: ~a -> First digit: ~a, Last digit: ~a, Concatenated: ~a~%" 
                      line first-digit last-digit concatenated))
            ;; If no digits found, print this message
            (format t "Line: ~a -> No digits found.~%" line))))
    ;; Print the total sum after processing all lines
    (format t "Total sum of all concatenated digits: ~d~%" total-sum)))

(defun process-file (filename)
  "Lê um arquivo e converte cada linha usando a função convert-to-digits."
  (with-open-file (in filename)
    (let ((total-sum 0)))
    (loop for line = (read-line in nil)  ;; Lê cada linha do arquivo
          while line do
            (format t "A linha convertida é: ~a~%" (convert-to-digits line)))))

(defparameter *word-to-digit*
  '(("one" . "1")
    ("two" . "2")
    ("three" . "3")
    ("four" . "4")
    ("five" . "5")
    ("six" . "6")
    ("seven" . "7")
    ("eight" . "8")
    ("nine" . "9")))

(defun spelled-out-digit (word)
  "Retorna a representação em dígito para uma palavra ou nil se não encontrado."
  (cdr (assoc word *word-to-digit* :test #'string=)))

(defun convert-to-digits (input)
  "Converte palavras escritas em dígitos e mantém os números existentes."
  (let ((result "")   ;; String resultante
        (length (length input)))
    (loop for i from 0 below length do
      (let ((char (char input i)))
        ;; Se o caractere for um dígito, adicione ao resultado
        (if (digit-char-p char)
            (setf result (concatenate 'string result (string char)))
            ;; Caso contrário, verifique se é uma palavra escrita
            (dolist (word (mapcar #'car *word-to-digit*))
              (let ((word-length (length word)))
                ;; Verifique se a palavra está presente
                (when (and (<= (+ i word-length) length) ;; Verifique limites
                           (string= word (subseq input i (+ i word-length))))
                  (setf result (concatenate 'string result (spelled-out-digit word)))
                  (setf i (+ i word-length -2)))))))) ; Avançar o índice
    result))

(defun process-file (filename)
  "Lê um arquivo, converte cada linha usando a função convert-to-digits e soma os resultados dos dígitos."
  (with-open-file (in filename)
    (let ((total-sum 0))  ; Inicializa a variável de soma total
      (loop for line = (read-line in nil)  ;; Lê cada linha do arquivo
            while line do
              (let ((converted-line (convert-to-digits line)))
                (format t "A linha convertida é: ~a~%" converted-line)
                (let ((digits (first-and-last-digit converted-line)))
                  (if digits
                      (let* ((first-digit (first digits))
                             (last-digit (second digits))
                             (concatenated (concatenate 'string (list first-digit last-digit)))  ; Concatena dígitos
                             (concatenated-int (parse-integer concatenated)))  ; Converte para inteiro
                        (setf total-sum (+ total-sum concatenated-int))  ; Adiciona à soma total
                        ;; Imprime os dígitos
                        (format t "Linha: ~a -> Primeiro dígito: ~a, Último dígito: ~a, Concatenado: ~a~%"
                                converted-line first-digit last-digit concatenated))
                      ;; Se nenhum dígito for encontrado, imprime esta mensagem
                      (format t "Linha: ~a -> Nenhum dígito encontrado.~%" converted-line)))))
      ;; Imprime a soma total após processar todas as linhas
      (format t "Soma total de todos os dígitos concatenados: ~d~%" total-sum))))

(process-file "1.txt")
                                        ;(print-first-and-last-digits "1.txt")
(print (convert-to-digits "6oneight"))  ;; Esperado: "68"
(print (convert-to-digits "on1eight"))  ;; Esperado: "18"
