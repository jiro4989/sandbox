#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
from bs4 import BeautifulSoup

def main():
    soup = BeautifulSoup(sys.stdin.read(), "html.parser")
    print(soup.find_all("tr"))

if __name__ == '__main__':
    main()


