(ns deresute
  (:require [net.cgrand.enlive-html :as html]
            [clojure.data.csv :as csv]
            [clojure.java.io :as io]
            [clojure.string :as str]))

(def deresute-url "https://imascg-slstage-wiki.gamerch.com/%E3%82%A2%E3%82%A4%E3%83%89%E3%83%AB%E4%B8%80%E8%A6%A7#content_1_2")
(def htmlall (html/html-resource (java.net.URL. deresute-url)))
(def header (html/select htmlall [:table :thead]))
(def body (html/select htmlall [:table :tbody]))

(defn map-content [elem]
  (if (map? elem)
    (-> elem :content first map-content)
    elem))

(def cols
  (-> header
      first
      :content
      first
      :content
      (->> (map :content)
           (remove nil?)
           (map first)
           (map map-content))
      (conj "タイプ")))

(defn profile [elem]
  (let [content (:content elem)]
    (flatten (list
              (-> content first :content first)
              (-> content second :content first :content first)
              (-> content
                  (nthrest 2)
                  (->> (map #(-> % :content first))
                       (map map-content)))))))

(def rows
  (-> body
      (nth 4)
      :content
      (->>
       (filter map?)
       (map profile)
       (remove #(empty? (second %))))))

(def csv-body (cons cols rows))

(with-open [w (io/writer "deresute.csv")]
  (csv/write-csv w csv-body))

; CSVのヘッダをハッシュマップのキーに変換
(def map-profile (->> rows
                      (map #(zipmap cols %))))

(defn hash-map-apply [v f]
  (hash-map (key v) (-> v val f)))

(defn hash-map-count [v]
  (hash-map-apply v count))

(println "属性ごとのアイドルの人数")
(defn count-of-type [v]
  (->> v
       (group-by #(get % "タイプ"))
       (map hash-map-count)))
(println (count-of-type map-profile))

(println "CVがついているアイドルとそうでないアイドルの人数")
(defn count-of-having-cv [v]
  (->> v
       (map #(assoc %
                    :has-cv (if (not= "-" (get % "CV"))
                              "CVあり"
                              "CVなし")))
       (group-by :has-cv)
       (map hash-map-count)))
(println (count-of-having-cv map-profile))

(defn sort-idols-by-age [idols]
  (->> idols
       (sort-by #(get % "年齢"))
       (map #(hash-map :name (get % "名前")
                       :age (get % "年齢")))))

(defn idol-age [idols f]
  (-> idols
      val
      sort-idols-by-age
      f))

(println "属性ごとの最年少、最年長のアイドル")
(defn min-max-of-type [v]
  (->> v
       (group-by #(get % "タイプ"))
       (map #(hash-map (key %) {:min (idol-age % first)
                                :max (idol-age % last)}))))
(println (min-max-of-type map-profile))

(defn birthday-month [idol]
  (-> idol
      (get "誕生")
      (str/split #"/")
      first))

(println "誕生日の月で集計")
(defn count-of-birthday-month [v]
  (sort-by first (->> v
                      (group-by birthday-month)
                      (map hash-map-count))))
(println (count-of-birthday-month map-profile))

