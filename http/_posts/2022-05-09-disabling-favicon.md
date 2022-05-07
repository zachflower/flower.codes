---
layout: post
title: "How To Completely Disable Your Favicon"
date: 2022-05-09 00:00:00
---

This site doesn't have a favicon, and it likely never will.

I'm not _100%_ sure why I feel so strongly about that decision, but considering the fact that I don't have a logo—nor do I really _want_ one—setting up a favicon felt unnecessary.

But, you can't just _not_ define a favicon (via the `<link rel="shortcut icon" />` tag), because most web browsers will try to request one anyway. This means that every page load is accompanied by a second request for a `favicon.ico` file that will _always_ come back as `Not Found`.

Annoying, right?

So, what are we to do?

While we could just slap together a transparent `favicon.ico` and be done with it, I wanted to _eliminate_ that second request, not just serve up a perfunctory image to appease my need for a successful response.

## First Attempt

While omitting the icon tag doesn't give the results we want, I decided to experiment with values that _do_. My first attempt at this was to use a simple hash:

```html
<link rel="shortcut icon" href="#" />
```

While this eliminated the `404 Not Found` response in the favicon request, it ended up re-requesting the entire page. This makes sense, as the `#` ultimately gets interpreted by the browser as `https://flower.codes/#`, and the same is true for pretty much every other character you might want to try (spaces, question marks, etc).

Not a proper solution.

## Enter Data URLs

So, we can't omit the favicon, and we can't use an arbitrary character... what _can_ we do?

After a little bit of digging, I came across a concept that most web developers are fairly familiar with: [Data URLs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs).

For the uninitiated, Data URIs allow you to embed files directly inline in your HTML, rather than making an external request. To be overly simplistic, they generally consist of a definition of the _type_ of file to be loaded (such as `text/html` or `text/plain`) and the file contents (which can be encoded to reduce the number of characters).

This means that instead of loading an external file, you can include it inline like so:

```
data:text/html,<script>alert('hi');</script>
```

For our purposes, though, we can define a Data URL that is effectively empty by simply omitting both the content type and the contents themselves:

```html
<link rel="shortcut icon" href="data:," />
```

## Okay, But... Why??

As expected, _this_ solved my problem. By including the content directly, and keeping it empty, we can eliminate the second request without inducing any errors in the console.

But, why go through all this trouble?

Believe it or not, I actually _like_ favicons. I think they make organizing tabs and bookmarks far easier. But in a world (wide web) filled with them, eschewing one on my own site felt like a small way to stand out (and going the extra mile to do it the "right" way is just icing on the cake).

--

_This is post 010 of [#100DaysToOffload](https://100daystooffload.com/)_