---
layout: post
title: "Trust, but Verify"
date: 2018-10-23 07:24:00
canonical_url: https://blog.automox.com/keep-patching-your-shit-trust-but-verify
source: automox
---

In 1983, Ken Thompson and Dennis Ritchie were awarded the ACM A.M. Turing Award "for their development of generic operating systems theory and specifically for the implementation of the UNIX operating system." In his acceptance speech, aptly titled "*[Reflections on Trusting Trust](https://www.archive.ece.cmu.edu/~ganger/712.fall02/papers/p761-thompson.pdf)*," Thompson presented a now infamous hypothetical design for a backdoor attack in the C source code compiler that would render login security obsolete and, by its own design, be nearly impossible to detect (if you haven't read it, I highly recommend taking some time to so, as it is a fascinating read).

While Thompson's speech largely consisted of a detailed explanation of exactly *how* this attack would work, the moral of his story reflected on the inherent need for trust in the software industry. In his words, "\[y\]ou can't trust code that you did not totally create yourself. (Especially code from companies that employ people like me.) No amount of source-level verification or scrutiny will protect you from using untrusted code. In demonstrating the possibility of this kind of attack, I picked on the C compiler. I could have picked on any program-handling program such as an assembler, a loader, or even hardware microcode. As the level of program gets lower, these bugs will be harder and harder to detect. A well-installed microcode bug will be almost impossible to detect."

## What is Trust?

When it comes to digital security, the balance between trust and progress is one that is constantly being threatened, and although Ken Thompson's assertion that the only code you can trust is code you wrote yourself is correct, it is far from practical. And yet, 35 years after "Reflections on Trusting Trust," our ability to sustain trust in our hardware and software vendors is far from absolute. Earlier this month, Bloomberg Businessweek published a [bombshell article](https://www.bloomberg.com/news/features/2018-10-04/the-big-hack-how-china-used-a-tiny-chip-to-infiltrate-america-s-top-companies) on the (strongly refuted) infiltration of nearly 30 American companies through an attack on the technology supply chain, and over the past two years there have been multiple instances of software vendors providing compromised downloads through official channels, something even operating system vendors like [Linux Mint](https://blog.linuxmint.com/?p=2994) aren't immune from.

But, even in a perfectly benevolent world, malicious intent isn't the only reason software vendors can lose the public's trust. Mistakes in the software development pipeline can, and have, led to system instabilities in a number of instances over the past two years. This month alone, Microsoft released a major update to Windows 10 that resulted in many users losing files, and a year ago Apple released an update to macOS High Sierra that allowed unrestricted root access on any affected machine… twice. As our reliance on technology has increased, so too has our vulnerability, but not applying software patches isn't exactly an option lest we see a repeat of last year's NotPetya cyberattacks, which were fueled in part by unpatched vulnerabilities in the Windows Server Message Block protocol.

So…what do we do?

## The Scale of Trust

As easy as it is to think of cybersecurity as a binary state—one where you are safe, and one where you aren't—it simply is not, and the same concept applies to trust. It is a sliding scale, where some vendors deserve more trust than others and, depending on the attack vectors you are trying to mitigate, some vendors don't deserve any trust at all. When it comes to avoiding malicious patches, a good rule of thumb is to trust the source, not the creator. As discussed in the last article of this series, software distributed through native package managers tend to receive the highest level of scrutiny, which can make compromising their distribution channels much more difficult than software vendors that write and manage bespoke update solutions.

## Trust, but Verify

Unfortunately, just because native package managers have a history of being more trustworthy, that doesn’t mean that they are perfect. In the words of Ronald Reagan, we must "trust, but verify." While malicious packages are less likely through native package managers, unstable packages are not. Applying critical patches is important, but in high-priority deployments can be beneficial to test patches in isolated environments to ensure their stability; and if a test environment is not available, waiting for community consensus on the effectiveness of patches (within reason) can help mitigate downtime and data loss.

## Use Patch Discipline

When all else fails, having some patch discipline can help reduce the problem of trust in software distribution. Not every patch contains high priority security and bug fixes, so while it is desirable to apply updates the second they are made available, it is better to apply the patches you need before the patches you want. When practical (and safe), remember to take your time to verify the quality of major software updates before jumping the gun. That being said, don't take too long to apply patches, even low-priority ones, because the longer you wait, the more difficult it can be to migrate incremental updates.

## The Bytes and The Bits

In a world where we must have trust in our vendors, understanding how software is created, and where it comes from can go a long way towards sharing some of that trust. In the next article of this series, we are going to dive deep into exactly *how* third-party software companies manage the design, development, and distribution of their software and software patches.