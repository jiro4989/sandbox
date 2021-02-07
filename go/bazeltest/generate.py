#!/usr/bin/env python3
# -*- coding: utf-8 -*-

def main():
    m = 100000
    print('package main')
    print('import "fmt"')
    print('func main() {')
    for i in range(1, m):
        print('\ttestFunc%d()' % i)
    print('}')
    print('')
    for i in range(1, m):
        print('func testFunc%d() { fmt.Println(1) }' % i)

if __name__ == '__main__':
    main()


