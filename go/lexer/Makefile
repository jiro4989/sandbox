.PHONY: setup
setup:
	GO111MODULE=off go get golang.org/x/tools/cmd/goyacc
	GO111MODULE=off go get github.com/blynn/nex

lc1:
	nex $@.nex
	go run $@.nn.go

lc2:
	nex $@.nex
	goyacc -o $@.tab.go $@.y
	go run $@.nn.go $@.tab.go
