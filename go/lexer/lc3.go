package main

import (
	"bufio"
	"io"
)

var keywords = map[string]int{
	"var": 1,
}

type Lexer struct {
	buf *bufio.Reader
}

func (l *Lexer) Scan() {
	b, err := l.buf.Peek(1)
	if err == io.EOF {
		// END
		return
	}

	ch := b[0]
	switch {
	case isDigit(ch):
	case isLetter(ch):
	case isQuote(ch):
	}
}

func isDigit(ch byte) bool {
	return '0' <= ch && ch <= '9'
}

func isLetter(ch byte) bool {
	return 'a' <= ch && ch <= 'z' ||
		'A' <= ch && ch <= 'Z' ||
		ch == '_' ||
		ch == '-' ||
		ch == '+' ||
		ch == '*' ||
		ch == '%' ||
		ch == '$' ||
		ch == '/'
}

func isQuote(ch byte) bool {
	return ch == '"' || ch == '\''
}
