package main

import (
	"fmt"
	"math/big"
	"os"
	"strconv"
)

func fib(m int) *big.Int {
	x := big.NewInt(0)
	y := big.NewInt(1)
	for i := 1; i < m; i++ {
		tmp := big.NewInt(0)
		tmp.Add(x, y)
		x, y = y, tmp
	}
	return y
}

func main() {
	m, err := strconv.Atoi(os.Args[1])
	if err != nil {
		panic(err)
	}
	fmt.Println(fib(m))
}
