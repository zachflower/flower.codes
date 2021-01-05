---
layout: post
title:  "Setting Up CloudFlare SSL for Laravel on Heroku"
date:   2016-06-28 12:00:00
---
**CloudFlare. Laravel. Heroku.**

Despite being the keywordiest article title I've ever written, I really did have to solve this exact problem recently, and it took me longer than I'm proud to admit.

Let's face it: SSL is a pain in the ass.

At least it is when it comes to freelance development. Architecting and launching a web application for technically-inexperienced clients is difficult enough without the added pain of managing the completely unautomated process of ordering, configuring, and renewing SSL certificates. Add onto that a client that is based in the United Kingdom and the whole process is enough to drive one to drink.

So, in an effort to save my client time and money, I did some research and discovered [CloudFlare](https://www.cloudflare.com/). I think it's safe to say that I fell in love instantly. CloudFlare offers a host of incredible features, from DNS and content distribution to security and SSL; all with an insanely generous free tier.

In my particular case, I was interested in their Universal SSL. The general idea is that you can route traffic to designated DNS records through the SSL-encrypted CloudFlare servers, which then act as a reverse proxy for your traffic. It's simple, automated, and free.

**The Trifecta!**

While I am a pretty die hard [DigitalOcean](https://m.do.co/c/a8eb87aea1f2) fan, I've found that [Heroku](https://www.heroku.com/) is the best platform for this specific type of client, so my next step was getting CloudFlare and Heroku to play nicely. Luckily for me, the cherry on top of this delicious mound of DevOps goodness is that CloudFlare even offers a Heroku-specific integration tutorial. I followed the steps exactly, and in less than 5 minutes my client's site was secured!

Unfortunately, that's where things stopped being easy.

## The Problem

You see, because of the way CloudFlare manages SSL, Laravel doesn't natively detect that SSL is enabled. This immediately became apparent when clicking on any link on the site. My fancy new HTTPS got stripped every time.

After some fervent Googling (and not finding much to help), I came across this awesome [Gist](https://gist.github.com/Ingramz/bbb8f4f2634e0701c186) by GitHub user [Ingramz](https://github.com/Ingramz) that allowed me to add the CloudFlare IP addresses to a list of trusted proxies (specifically, I used the code in the comment by GitHub user [antriver](https://github.com/antriver)). Presumably, the way this is supposed to work is that the IP addresses CloudFlare uses to send traffic to my client's site are considered to be "trusted," which tells Laravel to take information from the proxy headers.

**Nothing.**

I mean, all the information was there, the request had all the proper headers, but all of the site links were still insecure.

So I started digging into the Laravel core to understand more about what was going on, and that's when I discovered that the `isFromTrustedProxy()` method in the Symfony Request class compared the trusted proxy addresses we defined above with the `REMOTE_ADDR` server parameter:

```php
<?php

private function isFromTrustedProxy() {
  return self::$trustedProxies && IpUtils::checkIp($this->server->get('REMOTE_ADDR'), self::$trustedProxies);
}
```

The thing that I noticed is that the `REMOTE_ADDR` parameter didn't match anything on the CloudFlare IP list, nor did it match my current public IP address. To be honest, I have no idea _where_ that IP address came from, but it was in the private range, which led me to believe it was an internal Heroku IP.

So, setting trusted proxies doesn't work out of the box. After inspecting the request headers, I discovered that both my IP address _and_ a CloudFlare one were in the `X-Forwarded-For` header, which meant that a small tweak to the Gist I found earlier should solve all of my problems.

## The Solution

At this point, I know that my CloudFlare proxy request is getting forwarded by an internal Heroku server, so all I have to do is look in the `X-Forwarded-For` request header for a CloudFlare IP address and, if found, add the `REMOTE_ADDR` parameter to the proxy IPs list we downloaded form CloudFlare.

### Laravel 4

To accomplish this in Laravel 4, open up the `app/filters.php` file and add the following at the end of the anonymous function within the `App::before()` method.

```php
<?php

App::before(function($request) {
  // INSERT WITHIN THIS METHOD

  $proxyIps = \Cache::remember('cloudFlareProxyIps', 1440, function () {
    $url = 'https://www.cloudflare.com/ips-v4';
    $ips = file_get_contents($url);
    return array_filter(explode("\n", $ips));
  });

  if ( $forwardedFor = $request->headers->get('X_FORWARDED_FOR') ) {
    $forwardedIps = explode(", ", $forwardedFor);

    foreach ( $forwardedIps as $forwardedIp ) {
      if ( \Symfony\Component\HttpFoundation\IpUtils::checkIp($forwardedIp, $proxyIps) ) {
        $proxyIps[] = $request->server->get('REMOTE_ADDR');
        break;
      }
    }
  }

  // INSERT ABOVE THIS LINE
  $request->setTrustedProxies($proxyIps);
});
```

### Laravel 5

This is significantly more thorough (albeit a bit more complicated) to handle in the Laravel 5 thanks to the awesome middleware support. The first step is to create a file called `app/Http/Middleware/CloudFlareProxies.php` with the following content:

```php
<?php namespace App\Http\Middleware;

use Closure;

class CloudFlareProxies {

  /**
   * Handle an incoming request.
   *
   * @param  \Illuminate\Http\Request  $request
   * @param  \Closure  $next
   * @return mixed
   */
  public function handle($request, Closure $next) {
    $proxy_ips = \Cache::remember('cloudFlareProxyIps', 1440, function () {
      $url = 'https://www.cloudflare.com/ips-v4';
      $ips = file_get_contents($url);
      return array_filter(explode("\n", $ips));
    });

    if ( $forwarded_for = $request->headers->get('X_FORWARDED_FOR') ) {
      $forwarded_ips = explode(", ", $forwarded_for);
      foreach ( $forwarded_ips as $forwarded_ip ) {
        if ( \Symfony\Component\HttpFoundation\IpUtils::checkIp($forwarded_ip, $proxy_ips) ) {
          $proxy_ips[] = $request->server->get('REMOTE_ADDR');
          break;
        }
      }
    }

    $request->setTrustedProxies($proxy_ips);

    return $next($request);
  }
}
```

Next, we need to tell Laravel about the new middleware. This is handled in the `$middleware` array in the `app/Http/Kernel.php` file:

```php
<?php

protected $middleware = [
  \App\Http\Middleware\CloudFlareProxies::class
];
```

Basically, what we are doing here is detecting if the proxied request originated from the CloudFlare servers. If so, then trust the REMOTE_ADDR. I am doing it this way because I'd rather now add the entire private IP subnet to the list of trusted proxies, and if Heroku changes anything in the future this solution will still hold up well.

## Huzzah!

After a quick test on a Heroku development dyno, I was able to confirm my fix and deploy it to production to provide my client with a happy treen lock icon in their address bar!
