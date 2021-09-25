.PHONY: build
build: word_count/app reverse_polish_notation_calc/app

.PHONY: setup
setup:
	GO111MODULE=off go get golang.org/x/tools/cmd/goyacc
	GO111MODULE=off go get github.com/blynn/nex

word_count/app:
	cd $(@D) && make

reverse_polish_notation_calc/app:
	cd $(@D) && make

lc3/lc3:
	cd $(@D) && make
