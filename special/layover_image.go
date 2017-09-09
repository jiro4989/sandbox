package main

import (
	"fmt"
	// "github.com/oliamb/cutter"
	// "flag"
	"image"
	"image/draw"
	"image/png"
	"io/ioutil"
	"os"
	"path"
	"path/filepath"
	"strings"
	"time"
)

func getImage(imgPath string) image.Image {
	fmt.Println("getImage", imgPath)
	file, err := os.Open(imgPath)
	defer file.Close()
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	img, _, err := image.Decode(file)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	return img
}

func saveImage(fileName string, img image.Image) {
	fmt.Println("saveImage")
	out, err := os.Create(fileName)
	defer out.Close()
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	err = png.Encode(out, img)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func readFilePaths(dirPath string) []string {
	fmt.Println("readFilePaths : ", dirPath)

	files, err := ioutil.ReadDir(dirPath)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	// 絶対パスのリストを取得する
	filePaths := make([]string, 0)
	for _, file := range files {
		if strings.ToLower(path.Ext(file.Name())) == ".png" {
			fullpath := filepath.Join(dirPath, file.Name())
			filePaths = append(filePaths, fullpath)
		}
	}

	return filePaths
}

func createImage(out *image.RGBA, images ...*image.Image) {
	for _, img := range images {
		draw.Draw(out, imgRect, img, startPt, drawOver)
	}
}

func main() {
	fmt.Println("start:", time.Now())

	homeDir := os.Getenv("HOME")

	eyeDir := homeDir + "/Pictures/tmp/eye"
	eyebrowDir := homeDir + "/Pictures/tmp/eyebrow"
	mouseDir := homeDir + "/Pictures/tmp/mouse"

	dirs := make([]string, 0)
	dirs = append(dirs, eyeDir)
	dirs = append(dirs, eyebrowDir)
	dirs = append(dirs, mouseDir)

	fmt.Println(dirs)

	imageFilePaths := make([][]string, 0)
	for _, d := range dirs {
		paths := readFilePaths(d)
		imageFilePaths = append(imageFilePaths, paths)
	}

	fmt.Println(imageFilePaths)

	images := make([][]image.Image, 0)
	for _, paths := range imageFilePaths {
		imgs := make([]image.Image, 0)
		for _, p := range paths {
			imgs = append(imgs, getImage(p))
		}
		images = append(images, imgs)
	}

	for _, imgs := range images {
	}

	return

	// infile := flag.String("in-file", "", "入力画像ファイルのパスは必須です。")
	// outfile := flag.String("out-file", "", "出力画像ファイルのパスは必須です。")
	// flag.Parse()

	// img := getImage(*infile)
	// saveImage(*outfile, img)

	// 画像の読み込み
	baseImage := getImage("./img/red_large.png")
	middleImage := getImage("./img/orange_mid.png")
	topImage := getImage("./img/green_min.png")

	startPt := image.Pt(0, 0)

	// 画像を重ねて描画
	// 1. 書き込み用の画像を生成
	outRect := image.Rectangle{startPt, baseImage.Bounds().Size()}
	out := image.NewRGBA(outRect)

	// 2. 元の画像を書く
	src := image.Rectangle{startPt, baseImage.Bounds().Size()}
	draw.Draw(out, src, baseImage, startPt, draw.Src)

	// 3. 画像を重ねる
	over := image.Rectangle{startPt, middleImage.Bounds().Size()}
	draw.Draw(out, over, middleImage, startPt, draw.Over)

	// 4. 画像を重ねる
	over2 := image.Rectangle{startPt, topImage.Bounds().Size()}
	draw.Draw(out, over2, topImage, startPt, draw.Over)

	// 保存
	saveImage("./out/test2.png", out)

	fmt.Println("end:", time.Now())
}
