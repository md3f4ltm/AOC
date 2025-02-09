(ns day-3.core
  (:require [clojure.set :as set])
  (:require [clojure.java.io :as io]))

(defn read-input []
  (slurp (io/resource "input.txt")))

(defn move [pos dir]
  (let [[x y] pos]
    (case dir
      \^ [x (inc y)]
      \v [x (dec y)]
      \> [(inc x) y]
      \< [(dec x) y]
      pos)))

(defn houses [dirs]
  (let [start-pos [0 0]]
    (loop [current-pos start-pos
           visited #{start-pos}
           moves (seq dirs)]
      (if (empty? moves)
        (count visited)
        (let [new-pos (move current-pos (first moves))]
          (recur new-pos
                 (conj visited new-pos)
                 (rest moves)))))))
(def houses-robot [dirs []
                   (let [start-pos [0 0]
                         santa-pos start-pos
                         robot-pos start-pos]
                     (loop [current-pos start-pos
                            visited #{start-pos}
                            moves (seq dirs)]
                       (if (empty? moves)
                         (count visited)
                         (let [new-pos (move current-pos (first moves))]
                           (recur new-pos
                                  (conj visited new-pos)
                                  (rest moves))))))])

(defn -main []
  (-> (read-input)
      (houses)
      (str "\n")
      (print)))
