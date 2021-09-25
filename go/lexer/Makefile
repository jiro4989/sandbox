.PHONY: build
build: lc1/lc1 lc2/lc2 lc3/lc3

.PHONY: setup
setup:
	GO111MODULE=off go get golang.org/x/tools/cmd/goyacc
	GO111MODULE=off go get github.com/blynn/nex

lc1/lc1:
	cd $(@D) && make

lc2/lc2:
	cd $(@D) && make

lc3/lc3:
	cd $(@D) && make
