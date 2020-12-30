(defn corner [text]
  (->> (range 1 (inc (count text)))
       (map #(take % text))
       (map #(apply str %))))

(defn middle-pad [text maxl]
  (/ (- maxl (count text)) 2))

(defn right-pad [text maxl]
  (- maxl (count text)))

(defn pad-text [text maxl pad-fn]
  (let [diff (pad-fn text maxl)]
    (str (->> (repeat diff "　")
              (apply str))
         text)))

(defn middle [lines]
  (let [maxl (count (apply max-key count lines))]
    (->> lines
         (map #(pad-text % maxl middle-pad)))))

(defn right [lines]
  (let [maxl (count (apply max-key count lines))]
    (->> lines
         (map #(pad-text % maxl right-pad)))))

(def text  "新年あけましておめでとうございます")

(doseq [line (corner text)]
  (println line))

(doseq [line (middle (doall (corner text)))]
  (println line))

(doseq [line (right (doall (corner text)))]
  (println line))

; $ clojure ascii_triangle.clj
;
; 新
; 新年
; 新年あ
; 新年あけ
; 新年あけま
; 新年あけまし
; 新年あけまして
; 新年あけましてお
; 新年あけましておめ
; 新年あけましておめで
; 新年あけましておめでと
; 新年あけましておめでとう
; 新年あけましておめでとうご
; 新年あけましておめでとうござ
; 新年あけましておめでとうござい
; 新年あけましておめでとうございま
; 新年あけましておめでとうございます
; 　　　　　　　　新
; 　　　　　　　新年
; 　　　　　　　新年あ
; 　　　　　　新年あけ
; 　　　　　　新年あけま
; 　　　　　新年あけまし
; 　　　　　新年あけまして
; 　　　　新年あけましてお
; 　　　　新年あけましておめ
; 　　　新年あけましておめで
; 　　　新年あけましておめでと
; 　　新年あけましておめでとう
; 　　新年あけましておめでとうご
; 　新年あけましておめでとうござ
; 　新年あけましておめでとうござい
; 新年あけましておめでとうございま
; 新年あけましておめでとうございます
; 　　　　　　　　　　　　　　　　新
; 　　　　　　　　　　　　　　　新年
; 　　　　　　　　　　　　　　新年あ
; 　　　　　　　　　　　　　新年あけ
; 　　　　　　　　　　　　新年あけま
; 　　　　　　　　　　　新年あけまし
; 　　　　　　　　　　新年あけまして
; 　　　　　　　　　新年あけましてお
; 　　　　　　　　新年あけましておめ
; 　　　　　　　新年あけましておめで
; 　　　　　　新年あけましておめでと
; 　　　　　新年あけましておめでとう
; 　　　　新年あけましておめでとうご
; 　　　新年あけましておめでとうござ
; 　　新年あけましておめでとうござい
; 　新年あけましておめでとうございま
; 新年あけましておめでとうございます
