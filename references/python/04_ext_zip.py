#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import zipfile, sys

def main():
    filename = sys.argv[1]
    unzip(filename)

def unzip(filename):
    zf = zipfile.ZipFile(filename, "r")
    for fn in zf.namelist():
        unzipf = file("./" + fn, "wb")
        unzipf.write(zf.read(fn))
        unzipf.close()
    zf.close()

if __name__ == '__main__':
    main()

