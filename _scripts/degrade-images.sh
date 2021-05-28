#!/bin/bash

project_root=$(dirname $(dirname $(realpath $0 )))

cd ${project_root}/assets/posts/

# compress png images
for f in *.png; do
    if [[ "$f" == *-degraded.png ]]; then
        continue
    elif [ -f "${f%.png}-degraded.png" ]; then
        continue
    fi

    convert "${f}" -verbose -strip -resize 800\> -colorspace Gray -colors 4 -quality 10 -set filename:f "%[t]-degraded" "%[filename:f].png"
done

# compress jpg images
for f in *.jpg; do
    if [[ "$f" == *-degraded.jpg ]]; then
        continue
    elif [ -f "${f%.jpg}-degraded.jpg" ]; then
        continue
    fi

    convert "${f}" -verbose -sampling-factor 4:2:0 -strip -interlace JPEG -resize 800\> -colorspace Gray -colors 4 -quality 10 -set filename:f "%[t]-degraded" "%[filename:f].jpg"
done
