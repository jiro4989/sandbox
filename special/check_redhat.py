from bs4 import BeautifulSoup as BS
import sys

def main():
    args = sys.argv
    with open(args[1], encoding="utf-8") as infile:
        html = infile.read()

    soup = BS(html, "html.parser")
    for m in soup.find_all("th", {"id":"th-RHSA-2017:1715"}):
        print(m)

if __name__ == '__main__':
    main()