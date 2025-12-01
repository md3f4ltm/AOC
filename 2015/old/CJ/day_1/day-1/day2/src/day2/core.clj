(ns day2.core
  (:require [clojure.java.io :as io])
  (:require [clojure.string :as str]))

(defn read-file-lines [filepath]
  (with-open [rdr (io/reader filepath)]
    (doall (line-seq rdr))))

(defn parse-dimensions [dim-str]
  (map #(Integer/parseInt %) (str/split dim-str #"x")))

(defn calculate-area [dim]
  (let [[l w h] dim
        lw (* l w)
        wh (* w h)
        hl (* h l)
        sm (min lw wh hl)
        area (+ (* 2 lw) (* 2 wh) (* 2 hl) sm)]
    area))

(defn calculate-ribbon [dim]
  (let [list dim
        smallest-two (take 2 (sort list))
        ribbom (+ (* 2 (first smallest-two)) (* 2 (second smallest-two)))
        bow (reduce * list)
        total (+ ribbom bow)]
    (println smallest-two ribbom bow)
    total))

(defn -main []
  (let [lines (read-file-lines "resources/input.txt")
        dimensions (map parse-dimensions lines)
        areas (map calculate-area dimensions)]
    (println "Part 1:" (reduce + areas))
    (let [ribbons (map calculate-ribbon dimensions)]
      (println "Part 2:" (reduce + ribbons)))))

