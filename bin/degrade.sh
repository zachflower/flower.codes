#!/bin/bash

pushd ./http/assets/posts/

for f in *.jpg; do
    if [ -f "${f%.jpg}-degraded.gif" ]; then
        continue
    fi

    echo "Converting $f to gif"

    convert "${f}" -verbose -format GIF -interlace GIF -resize 640\> -colorspace gray -colors 4 -ordered-dither o8x8,2 -set filename:f "%[t]-degraded" "%[filename:f].gif"
done