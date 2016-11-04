---
layout: post
title:  "MIME Type Validation Isn't Good Enough"
date:   2016-07-12 12:00:00
categories: [writing ]
---
An uncomfortable majority of companies that offer high storage limits for specific file types have a major problem: MIME type validation isn't good enough.

If you've ever had to implement file validation for user uploads, you've probably relied heavily on MIME type validation to ensure that the files you are receiving are what they're supposed to be. This is an important piece of validating uploads, especially because validating the file extension is incredibly unreliable (and irresponsible). Unfortunately, this type of validation isn't good enough to detect anomalies within files and, without any further checks, allows users to sneak in "extra" data under the guise of an accepted file format.

A few weeks ago, a friend asked me if it was possible to use Flickr's 1TB storage limit to backup large ZIP files instead of photos. My gut told me that, no, this wouldn't work. It's not like you could just change the file extension and Flickr would say "seems legit" and store the file for you. Immediately following that instinct, though, I started to wonder just how strict Flickr's validation really is. Using steganography to sneak in some data occurred to me first, but because we are talking about uploading massive non-image files, I didn't think it would be a usable method. We would be dealing with more data than image.

So what would work? That was the challenge of the evening. I started experimenting with different methods and services, curious about who did a "good" job at validating user uploads, and who did a "not so good" job.

## What I Found

The first thing I tried was to just open an image in VIM and mash the keyboard a little bit at the end of the file (super high-tech, I know). The general idea here is to test the extent of Flickr's upload validation. If they can catch the "corrupted" data at the end, then the experiment would be dead before it even started. As I expected, though, Flickr didn't seem to care at all. The image I uploaded was viewable (and re-downloadable) with my "comments" in tact.

But what if I threw in a LOT more data than just a few lines of random text? My next experiment was to concatenate two files. I know, it's not exactly a high-tech solution, but I wondered how I'd fare if I just copied the "hidden" file and pasted it onto the end of the "visible" one? Thanks to a resounding lack of imagination, I decided to concatenate two binary files in a way that would allow me to re-separate them later on, and you know what? It worked!

That's right, ladies and gentlemen, I've essentially created the digital equivalent of this:

![Red Riding Hood]({{ site.url }}/assets/posts/red-riding-hood.jpg)

Seems legit.

Here's a quick comparison of the two files. The only difference, as far as my computer can tell? The file size of the concatenated file is 30MB bigger.

![Comparison]({{ site.url }}/assets/posts/comparison-1.png)

To make it clear that MIME type validation is useless in this situation, here are the results of three different file type commands:

![Comparison]({{ site.url }}/assets/posts/comparison-2.png)

Nope.

![Comparison]({{ site.url }}/assets/posts/comparison-3.png)

Wrong and wrong.

Since my operating system couldn't seem to tell any real difference between the two files, there was some hope that Flickr wouldn't have a problem with them either. Unfortunately, while the Flickr test did work (yay!), I quickly learned that Flickr's 1TB of storage is limited by their 200MB upload cap.

**That wouldn't do.**

What if I wanted to backup a ZIP of my entire music library? No, 200MB wouldn't do at all. So I did some digging (and by digging, I mean I Googled for about 5 minutes) and found that SoundCloud has a 5GB upload limit and allows you to download the original file. The interesting thing about SoundCloud is that they don't technically have an upper limit on storage. Their limits are based on the total length of all of the tracks you have uploaded, which in the case of their free tier is 180 minutes. So, theoretically, if I used only 1 second audio clips and used up the entire 5GB upload limit, I would have access to a total of… (insert math montage here)… 54TB of storage (a limit I absolutely have no intention of testing).

**Now that's more like it!**

My first step was to re-run my original concatenation script, except this time I used an audio file instead of a photo (in this case, I used a recording of a song that I actually helped write, record, and produce). 10 minutes later, I had an uploaded, processed, and playable file on SoundCloud that (to cut to the chase) I was able to pull back down and extract the "hidden" video.

Here's a comparison between the original and concatenated audio files. The only visible difference is, again, the file size.

![Comparison]({{ site.url }}/assets/posts/comparison-4.png)

You're probably noticing a theme here, though let's face it, this isn't exactly rocket science (or science at all, for that matter). Once you figure it out once, reproducing the results is a pretty straightforward process.

## Possible Solutions

By this point I was starting to wonder what other services were only doing cursory validations of their files. Was anybody doing a good job at combating this potential problem, and if so, how were they doing it? I did a quick check of a few popular services and found that there were two likely methods of upload validation.

### File Normalization

The first solution that came to mind was skipping extended validation altogether and just normalizing file uploads. Imgur, knowing they are only going to be dealing with certain file types, seems to do this. While they accepted the concatenated file, and allowed me to re-download it at the original resolution, they didn't retain the original file so the attached video was removed. YouTube seemed to do the same thing. I was able to pull back down the "original" file, but it appeared to be normalized with the "hidden" file removed.

In the case of Flickr and SoundCloud, this vulnerability could likely be resolved relatively easily by providing a close 1–1 copy of the original uploaded file, rather than the original file itself (however, I won't presume to know how they've architected their backends, so this is likely less trivial than I would imagine).

I did a quick test of this solution, and for a quick way to "fix" uploaded image files, you can utilize ImageMagick's convert function to "convert" an image into the same file format it is already in:

![ImageMagick]({{ site.url }}/assets/posts/imagemagick.png)

A similar method works for audio files as well, although the results are a little different. Using FFmpeg, I took the same path of converting an MP3 to an MP3 with the hope that it would strip out the "hidden" data. The good news: it worked!

![FFmpeg]({{ site.url }}/assets/posts/ffmpeg.png)

The bad news (which is actually good news in disguise) is that FFmpeg marked the conversion as a "failure." Even though the converted file was written, FFmpeg sensed that something was wrong and (rightfully) shit a brick. This led me to the next (better) solution: file verification.

### File Verification
The second possible solution I could think of would be verifying the format of the file in its entirety, rather than just the validating the MIME type. This is definitely the more difficult of the two solutions, but would allow you to safely store the original uploaded file. Unsurprisingly, the only service I could find that was doing this type of validation was Google Photos. They knew something was amiss and rejected the upload entirely.

While this is clearly the more desirable solution, the implementation (as I see it) is likely more complicated than the normalization option. While I highlighted a possible path to verifying audio files above, I couldn't come up with a quick and easy way to verify image files as well as Google is doing.

Validating user-submitted data is always a chore, no matter what you are building, but it is a necessary evil. I know, like all of us at one time or another, I have been guilty of taking shortcuts in the past (especially when confronted with high-speed startup development timelines), but it is important to take extra steps to ensure the integrity of the data you accept from your users because (like any form of code debt) it will save you from massive headaches later on.
