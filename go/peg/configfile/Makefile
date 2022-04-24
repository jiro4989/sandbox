configfile: grammer.peg.go
	go build

grammer.peg.go: grammer.peg
	peg grammer.peg

.PHONY: setup
setup: ## 開発時に使うツールをインストールする
	go install github.com/pointlander/peg@latest
