#! /bin/bash

cd "$(dirname "$0")" || exit

rm -f ./*.ttf
java -jar ./bin/BitsNPicas.jar convertbitmap -f ttf -o ./zpix-mono.ttf ../src/zpix-mono.sfd

# minify has a bug for web, OTS parsing error: OS/2: Failed to parse table
# so I'm going to convert woff2 here
# `ttf2woff2` is a npm module, RUN `npm i -g ttf2woff2` install
cat < ./zpix-mono.ttf | ttf2woff2 > ../website/zpix-mono.woff2

./minify-mono.py
mv -f ./zpix-mono.ttf ../dist/zpix-mono.ttf


rm -f ./*.bdf
java -jar ./bin/BitsNPicas.jar convertbitmap -f bdf -o ./zpix-mono.bdf ../src/zpix-mono.sfd
mv -f ./zpix-mono.bdf ../dist/zpix-mono.bdf
