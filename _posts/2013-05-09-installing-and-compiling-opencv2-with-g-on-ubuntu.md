---
layout: post
title: Installing and Compiling OpenCV2 with G++ on Ubuntu
date: 2013-05-09 12:00:00
permalink: installing-and-compiling-opencv2-with-g-on-ubuntu/
---
Recently, I was working on some basic [Object Recognition](https://en.wikipedia.org/wiki/Object_recognition) and was having trouble figuring out how to get started with OpenCV2 in Ubuntu. There was a lot of disparate advice and documentation across the web, and after spending a little bit of time stitching it together, came up with these 3 steps to getting started with OpenCV2 development using C++ in Ubuntu.

## Step One: Installation

Run the following command to install OpenCV2 and all dependencies:

```
$ sudo apt-get install libcv2.3 libcvaux2.3 opencv-doc libcv-dev libcvaux-dev
```

## Step Two: Header

Much of the documentation that I came across didn’t account for the distinction between OpenCV and OpenCV2, so the headers often looked like this:

```c
#include <cv.h>
#include <highgui.h>
```

After some Googling, I found the following to be correct:

```c
#include <opencv2/opencv.hpp>
```

## Step Three: Compiling

Compilation also requires linking the OpenCV2 libraries. There is a lot of different documentation on how to do this, however the following seemed to be the most foolproof to me:

```
$ g++ hello.cpp -o file `pkg-config opencv --cflags --libs`
```

## Step Four: Profit!

That’s it! Keep in mind, I am fairly new to OpenCV, so this may not be the best or most accurate path to getting started, but it worked for me and I felt I should share it.