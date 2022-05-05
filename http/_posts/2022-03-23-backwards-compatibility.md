---
layout: post
title: How To Build an Absurdly Backwards Compatible Website
date: 2022-03-23 13:20:42
---

Let's face it: the internet is broken.

It feels like so much of the web is composed of clickbait, ads, popups, and a toxic amount of JavaScript that you need a modern computer just to get any value out of it. Remember when low-power computers were created for people who were "just browsing the internet?"

Half of the sites on the internet are so overloaded with tracking scripts, ads, third-party "analytics" platforms, and other junk that they simply crash in the face of sub-par hardware; and don't even get me started on what they do to "retro" computers.

If the modern web hasn't been created with aging hardware in mind, what does that mean for the proliferation of e-waste? Is it _really_ so necessary to update your computer every 2-5 years? And, what if you didn't? What if you couldn't _afford_ to?

My daily driver is a mid-2012 MacBook Pro that will stop receiving all updates (security included) from Apple by the end of this year. While I personally intend to keep it alive with Linux, this isn't a path that is readily available to most people. What are _most people_ supposed to do in this situation to save some money _and_ avoid adding more junk to our landfills?

These are the questions I have been asking myself over the last year or so, and while I haven't come up with many _great_ answers for the general populace, I did make the decision to ensure that this website is as _backwards compatible as possible_.

## The Basics

When I say "as backwards compatible as possible," I mean that this website will be usable on as many browsers, connections, and hardware as I can reasonably support. But, how exactly am I accomplishing this?

While there are no hard and fast rules for keeping a website accessible to _everyone_, there are a few basic guidelines and workarounds that I've come to rely on.

### Missing `Host` Headers

Did you know that the HTTP/1.0 specification didn't require a `Host` header? Up until recently, I didn't. You see, in HTTP/1.1, the `Host` request header tells a web server _exactly which site it is requesting_, giving the Web Master—coolest title ever—the ability to configure multiple "virtual hosts" on a single server.

In other words, `example.com` and `example.net` can be hosted on the same server, while serving up _different_ content. As far as sustainability goes, this is a pretty decent solution, as it allows you to utilize the infrastructure you already have to host multiple websites.

But, you know what _doesn't_ send a `Host` header? Internet Explorer versions 1 and 2. Probably more, too, but they are the only two I've come across so far that have forsaken me; which means that, without a workaround, my website is completely inaccessible to all of those IE1 and IE2 users out there. That's literally _ones_ of people that don't have access to sweet, sweet content like this. Thanks for that one, Microsoft.

So, how do we bring those no-`Host` rebels into the fold? A second IP.

Thankfully, DigitalOcean offers a handful of free floating IPs that you can assign to a single droplet, which means that [flower.codes](http://flower.codes) has it's own dedicated IP address in order to appease those picky, early 90's Windows computers. With a [little bit of overhead](https://docs.digitalocean.com/products/networking/floating-ips/how-to/find-anchor-ips/), you can simply set your server to listen on the float IP, so _any_ request to that particular IP will fall back to your website.

I use the [Caddy](https://caddyserver.com/) webserver, so to accomplish an HTTP fallback that will be returned on every request (unless a valid `host` entry can be matched), simply use `http://` as the site address:

```
http:// {
  root * /www/example.com
  file_server
}
```

### No Automatic HTTPS

To be absolutely clear here, I am _not_ advocating for not supporting HTTPS. It's 2022. That would be absurd. But, what I am advocating for is _not automatically redirecting_ to HTTPS. Get your certs, encrypt that traffic, do all the things you normally do... just don't force an HTTP => HTTPS redirect on your users.

Don't get me wrong, HTTPS is critical for modern website security, but all modern browsers automatically redirect to HTTPS whether you enforce it or not. What this means is that retro browsers can still load your website in good-ole HTTP, while newer browsers will handle the more secure redirection to HTTPS for you.

If you're using the [Caddy](https://caddyserver.com/) webserver, this is as simple as creating two separate server entries, one with an `http://` prefix, and one with an `https://` prefix:

```
http://example.com {
  root * /www/example.com
  file_server
}

https://example.com {
  root * /www/example.com
  file_server
}
```

### Raw HTML is Your Friend

Remember the `<FONT>` tag? And `<TABLE>` based layouts? What about `<CENTER>`? I do. Because the foundation of my website is built using those pre-Y2k web development standards.

As much as modern browsers like to say that they have deprecated some of the aforementioned tags (among other things, like setting a default `bgcolor` in your `BODY` tag), they still support the usage because there are enough websites that haven't (and likely never will) upgraded to the homogeneous post Web 2.0 hellscape.

One of the advantages to using these old-school web design methods is that _you can still use modern CSS_ to make things look better on newer devices. Instead of going crazy with flexbox and floats, do a basic layout using tables and _then_ adjust the look with CSS. This gives you the advantage of having a modern-looking website design (if that's your thing), while also gracefully degrading on older browsers that don't support it.

### Use CSS Sparingly

I think it is safe to say that modern CSS simply won't work with old browsers. I shouldn't have to go into _why_ that is, but what if you want to have _some_ CSS, just to make things look a tad more pretty for browsers that were released in the last decade?

In general, most browsers (even most legacy ones) will gracefully ignore CSS that they don't understand, which means that `@media` tags for things like basic responsiveness and dark mode are usable without any issue. That said, browsers that predate CSS _do not know what to do with `<style>` tags_, and as a result simply _print_ the styles out at the top of the page. It's pretty ugly and, depending on how much CSS you have, borderline unusable.

To work around this problem, you can put standard HTML comments within the `<style>` tags, which will get ignored by CSS-supported browsers, while getting interpreted by pre-CSS browsers:

```html
<style type="text/css">
<!---
body {
  /* ... */
}
--->
</style>
```

### Gettin' GIFfy Wit It

Fun fact: the earliest browsers only supported color images of the GIF variety. I won't get into the technical details here, but you can blame CompuServe for its creation. This means that, if you want your images to load in _any_ browser, they need to be in GIF format.

Neat, right?

Also, not for nothing, but GIF is absolutely pronounced with a soft "G" sound. Scream at me all you want, but it's what the inventors of the format intended[^gif], and I'm a sucker for historical accuracy:

> The creators of the format pronounced the acronym GIF as /dʒɪf/, with a soft g as in 'gin'. Wilhite stated that the intended pronunciation deliberately echoes the American peanut butter brand Jif, and CompuServe employees would often quip "choosy developers choose GIF", a spoof of Jif's television commercials.

[^gif]: Wikipedia, 2022. GIF - Wikipedia. [online] Available at: [en.wikipedia.org](https://en.wikipedia.org/wiki/GIF#Pronunciation) [Accessed 22 March 2022].

## Unnecessary Improvements

### Forgotten Link Tags

There are a number of `<link>` tags that older browsers support that can be pretty fun to add. For example, the `home` tag indicates what the homepage for the current website. In some browsers (such as NCSA Mosaic), this results in a cute little "home" icon at the top of the page that, when clicked, sends you to the designed `home` URL.

```html
<link rel="home" href="{{ site.url }}" />
```

Another useful `<link>` tag to add is the author tag (`refv=made` and `rel='me authn'`). This provides information about the author of the page, usually in the form of a `mailto:` address. In some browsers—such as [Lynx](https://lynx.invisible-island.net/lynx_help/Lynx_users_guide.html#Mail)—this tag makes it easy for the user to contact the page author without having to look anything up (or jump to a "contact" page).

```html
<link rev="made" rel="me authn" href="mailto:{{ site.email }}" />
```

### <3 Dithering

Lately, it seems like dithering is all the rage. Personally, I came across it via [Low Tech Magazine](https://solar.lowtechmagazine.com/2018/09/how-to-build-a-lowtech-website/), but I've seen it mentioned more frequently in the past year or so. I won't go into the technical details here (Low Tech Magazine does a far better job explaining it than I can), but the thing to know is that dithering allows you to reduce the filesize of your images by reducing the amount of information it takes to render them.

Most applications focus on desaturating the image and inserting strategic whitespace so our eyes fill in the gaps, but I've taken a more... extreme approach (that is, when I use images at all, which I generally try not to). Because my website requires all images to be in the much-larger-than-PNG GIF format (see above), I insert significantly more whitespace to keep the filesizes super small. The result is terrible for screenshots, but looks fantastic on photos:

![Black and white picture of an old abandoned chicken coop](/assets/posts/chicken-coop.jpg)

In case you want to accomplish the same thing on your own website, here is the shell script I use to "degrade" all of my images using the [ImageMagick](https://imagemagick.org/) command line interface:

```bash
#!/bin/bash

pushd ./http/assets/posts/

for f in *.jpg; do
    if [ -f "${f%.jpg}-degraded.gif" ]; then
        continue
    fi

    echo "Converting $f to gif"

    convert "${f}" -verbose -format GIF -interlace GIF -resize 640\> -colorspace gray -colors 4 -ordered-dither 8x8 -set filename:f "%[t]-degraded" "%[filename:f].gif"
done
```

As you can see, it enters the `http/assets/posts` directory and degrades (resizes, dithers, and desaturates) all `.jpg` images using the ImageMagick `convert` command, appending a `-degraded.gif` suffix to them (thus preserving the original image).

### No JavaScript

Just... No.

## Validation, Baby

Okay, so we've built a website that any time traveler would be able to use. How the hell do we actually _test_ it? While it's tempting to collect retro hardware and do it natively (something I haven't _completely_ avoided), there are a handful of great resources out there that can make checking your website against old browsers incredible straightforward.

### OldWeb.Today

The most frequently used tool in my arsenal, [oldweb.today](http://oldweb.today) is a website that allows you to emulate a number of different retro browsers (from NCSA Mosaic to Netscape Navigator) from directly within your _own_ browser. This has allowed me to double-check my work and verify the workarounds above in realistic environments.

### Utilu IE Collection

If you have an old Windows XP virtual machine laying around (or an old XP laptop, as I do), then the [Utilu IE Collection](https://utilu.com/IECollection/) is an _incredibly_ valuable resource. On Windows XP, it allows you to install every version of Internet Explorer from 1 through 8, which is how I learned that my website actually _works_ on IE 1-8, but also how I discovered that IE 1 and 2 _don't send the `host` header.

### Old Version

Finally, for all of the _other_ browsers you may want to test (think Safari, Firefox, Netscape, and Chrome), [oldversion.com](http://www.oldversion.com/) is a favorite of mine. Personally, I pull down the oldest version of each browser they offer and install it on my test machine, allowing me to check my work on the "v1" releases of every browser out there.

## Anything Else?

It's important to remember that this is an experiment that I'm running in relative isolation. There aren't exactly a ton of resources out there for providing value to aging systems beyond "recycle it" or "install Linux on it," so what I've learned has been a long series of trial and error.

If you happen to read this and have some of your own tips, please shoot me an email. I'd love to hear from you!

---

This is post 001 of [#100DaysToOffload](https://100daystooffload.com/)