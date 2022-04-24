package main

import (
	"fmt"
	"os"
	"reflect"
	"strconv"
)

type ParserFunc struct {
	data       map[string]interface{}
	currentKey string
}

func (p *ParserFunc) pushKey(key string) {
	p.data[key] = nil
	p.currentKey = key
}

func (p *ParserFunc) pushString(text string) {
	p.data[p.currentKey] = text
}

func (p *ParserFunc) pushInt(text string) {
	n, _ := strconv.Atoi(text)
	p.data[p.currentKey] = n
}

func (p *ParserFunc) pushBool(text string) {
	b, _ := strconv.ParseBool(text)
	p.data[p.currentKey] = b
}

func main() {
	b, err := os.ReadFile("sample.conf")
	if err != nil {
		panic(err)
	}

	pf := ParserFunc{
		data: make(map[string]interface{}),
	}
	p := &Parser{
		Buffer:     string(b),
		ParserFunc: pf,
	}
	if err := p.Init(); err != nil {
		panic(err)
	}
	if err := p.Parse(); err != nil {
		panic(err)
	}
	p.Execute()
	for k, v := range p.ParserFunc.data {
		fmt.Printf("key = %s, value = %v, type = %s\n", k, v, reflect.TypeOf(v))
	}
}
