(ns matrix-reader.core
  (:require [clojure.string :as str]))

(defn file-to-matrix [file-path]
  "Reads a file and returns a 2D vector (matrix) of characters."
  (let [content (slurp file-path)                                ;; Read the entire file as a string
        lines (str/split-lines content)]                         ;; Split into lines
    (vec (map #(vec %) lines))))                                 ;; Convert each line to a vector of characters and return a vector of vectors

(defn print-matrix [matrix]
  "Prints a matrix of characters."
  (doseq [row matrix]                                           ;; Iterate over each row
    (doseq [char row]                                          ;; Iterate over each character in the row
      (print char))                                            ;; Print character without quotes
    (println)))                                                ;; Move to the next line after each row

;; Example usage
(def matrix (file-to-matrix "input.txt"))                    ;; Replace "input.txt" with your file path
(print-matrix matrix)
