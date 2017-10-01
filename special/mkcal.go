/*
コマンドライン引数に日付を指定するとその日付の属するカレンダーのHTMLを生成する。
日付を指定しなければ、プログラムを実行した月のカレンダーを出力する。

参考:
1. ツェラーの公式 (今回は未使用)
   https://ja.wikipedia.org/wiki/%E3%83%84%E3%82%A7%E3%83%A9%E3%83%BC%E3%81%AE%E5%85%AC%E5%BC%8F
   公式: h = ( y + [y/4] - [y/100] + [y/400] + [(13m+8)/5] + d ) mod 7
    (y + y/4 - y/100 + y/400 + (13*m+8)/5 + d) % 7

2. Go言語 timeパッケージ
   https://golang.org/pkg/time/

3. Go言語で日付処理
   http://mattn.kaoriya.net/software/lang/go/20130620173712.htm

*/
package main

import (
	"fmt"
	"html/template"
	"log"
	"os"
	"strconv"
	"time"
)

func main() {
	// 引数で日付の指定があれば使う
	// 指定がなければ実行した月を使用
	args := os.Args
	date := time.Now()
	if 1 < len(args) {
		d, err := time.Parse("200601", args[1])
		if err != nil {
			log.Fatal(err)
		}
		date = d
	}

	// カレンダーの週リストの取得
	weeks := MonthDates(date)

	// カレンダーを生成
	c := calendar{
		weeks: make([][]dateProp, 0, len(weeks)),
	}
	c.appendHeader()
	c.appendWeeks(&weeks)

	// カレンダーをHTML出力
	printCalendarHTML(date, c)
}

// カレンダーの週リストを返す。
func MonthDates(t time.Time) [][]time.Time {
	// カレンダー上の最初の日 (日曜日)を計算する。
	// ここでの最初の日とは、
	// 例えば2017/04のカレンダーでは、
	// 2017/04/01という意味ではなく、
	// 2017/03/26を意味する。
	diff := time.Sunday - t.Weekday()
	fd := t.AddDate(0, 0, int(diff))

	// 週リストの作成
	endm := int(t.Month()) + 1
	ws := make([][]time.Time, 0, 5)
	for {
		// 一週間リスト
		w := make([]time.Time, 7)
		for i := 0; i < 7; i++ {
			w[i] = fd
			fd = fd.AddDate(0, 0, 1)
		}

		// カレンダー上不要な週でないかを判定
		if endm <= int(w[0].Month()) {
			break
		}
		ws = append(ws, w)
	}
	return ws
}

// カレンダー型
type calendar struct {
	weeks [][]dateProp
}

// カレンダーの先頭に曜日ヘッダを追加
func (c *calendar) appendHeader() {
	h := make([]dateProp, 7)
	for i := 0; i < 7; i++ {
		h[i] = dateProp{
			DateClass:  "cal-header",
			DateString: dateMap[i].jp,
		}
	}
	c.weeks = append(c.weeks, h)
}

// カレンダーの日付を追加
func (c *calendar) appendWeeks(ws *[][]time.Time) {
	for _, w := range *ws {
		ds := make([]dateProp, 7)
		for j, date := range w {
			dt := dateMap[int(date.Weekday())]
			d := dateProp{
				DateClass:  dt.en,
				DateString: strconv.Itoa(date.Day()),
			}
			ds[j] = d
		}
		c.weeks = append(c.weeks, ds)
	}
}

// カレンダーを描画するためのすべてのプロパティ
type calProp struct {
	Caption string
	Weeks   [][]dateProp
}

// カレンダー上の日付マスあたりのプロパティ
type dateProp struct {
	DateClass  string
	DateString string
}

// 曜日辞書
type dayDict struct {
	jp string
	en string
}

// 曜日辞書マップ
var dateMap = map[int]dayDict{
	0: dayDict{jp: "日", en: "sun"},
	1: dayDict{jp: "月", en: "mon"},
	2: dayDict{jp: "火", en: "tue"},
	3: dayDict{jp: "水", en: "wed"},
	4: dayDict{jp: "木", en: "thu"},
	5: dayDict{jp: "金", en: "fri"},
	6: dayDict{jp: "土", en: "sat"},
}

// カレンダー文字列を標準出力する
func printCalendarHTML(t time.Time, c calendar) {
	const cal = `
<table>
	<caption>{{.Caption}}</caption>
	{{range .Weeks}}
	<tr>
		{{with .}}
		{{range .}}
		<td class="{{.DateClass}}">{{.DateString}}</td>
		{{end}}
		{{end}}
	</tr>
	{{end}}
</table>
`

	tmpl, err := template.New("new").Parse(cal)
	if err != nil {
		log.Fatal(err)
	}

	cd := calProp{
		Caption: fmt.Sprintf("%d/%d", t.Year(), int(t.Month())),
		Weeks:   c.weeks,
	}

	err = tmpl.Execute(os.Stdout, cd)
	if err != nil {
		log.Fatal(err)
	}
}
