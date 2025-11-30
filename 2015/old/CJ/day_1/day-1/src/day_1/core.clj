(ns day-1.core
  (:require [clojure.java.io :as io]))

;; Read file and store lines
(defn read-file-lines []
  (slurp (io/reader (io/resource "input.txt"))))

(defn count-floor [lines]
  (reduce (fn [floor char]
            (cond (= char \() (inc floor)
                  (= char \)) (dec floor)
                  :else floor))
          0 lines))

(defn first-negative-floor [input]
  (loop [remaining input
         floor 0
         index 0]
    (cond (empty? remaining) nil
          (neg? floor) index
          :else
          (let [char (first remaining)
                new-floor (cond (= char \() (inc floor)
                                (= char \)) (dec floor)
                                :else floor)]
            (recur (rest remaining) new-floor (inc index))))))

(defn -main []
  (let [floor (-> (read-file-lines) count-floor)
        index (-> (read-file-lines) first-negative-floor)]
    (println (str "Floor: " floor)
             (println (str "Index: " index)))))
