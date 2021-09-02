---
layout: post
title: "What's with These Images, Anyway?"
date: 9999-01-01 12:00:00
---

## WTF is Dithering?

## And the Color?

## H... How?

```sh
convert image.jpg -verbose -format GIF -interlace GIF -resize 640\> -colorspace gray -colors 4 -ordered-dither 8x8 -set filename:f "%[t]-degraded" "%[filename:f].gif"
```

```html
<div class='img'>
    <img src='image-degraded.gif' />
</div>
```

```css
.img {
    background: #562;
}

.img img {
    mix-blend-mode: screen;
}
```

## Okay, but Why GIFs?
