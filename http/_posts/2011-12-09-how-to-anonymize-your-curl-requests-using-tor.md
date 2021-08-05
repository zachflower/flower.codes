---
layout: post
title: Anonymize Your cURL Requests Using Tor
date: 2011-12-09 12:00:00
---
**Note: This post assumes that you already have Tor installed and configured on your server. If not, visit the [Tor Project Homepage](https://www.torproject.org/) for instructions on how to set it up.**

I love writing web crawlers and data aggregators in PHP. They say knowledge is power, and I find it exciting to write applications that allow you to gather up as much knowledge as possible. Sometimes, though, you want to gather your data without revealing your identity to your target. This can be for both good and bad reasons, but let’s assume it is for a good reason that you need to keep hidden. The Tor Project is a great way to accomplish this task. Tor allows you to anonymously browse the web, and you can configure the applications on your computer to run through the Tor network. The PHP script below outlines the process it takes to randomly refresh your IP address on Tor, and then run a cURL request through your local Tor proxy, providing a unique identity and anonymity every time you run the script.

For this particular example, I am sending a request to [icanhazip.com](http://icanhazip.com//) to demonstrate the changing IP address. If you have a greater understanding of cURL, there are many more steps that can be taken to mask your identity as well, but I won’t go into that here.

```php
<?php

// connect to local tor proxy and refresh ip address
$ip = '127.0.0.1';
$port = '9051';
$auth = 'PASSWORD';
$command = 'signal NEWNYM';

$fp = fsockopen($ip,$port,$error_number,$err_string,10);

if(!$fp) {
    echo "ERROR: $error_number : $err_string";
    return false;
}

fwrite($fp,"AUTHENTICATE \"".$auth."\"\n");
$received = fread($fp,512);
fwrite($fp,$command."\n");
$received = fread($fp,512);

fclose($fp);

// submit curl request through tor proxy at 127.0.0.1:9050
$ch = curl_init();

curl_setopt($ch, CURLOPT_URL, "http://icanhazip.com/");
curl_setopt($ch, CURLOPT_PROXY, "127.0.0.1:9050");
curl_setopt($ch, CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_VERBOSE, 0);

$response = curl_exec($ch);

// do something with the response
```