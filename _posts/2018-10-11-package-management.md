---
layout: post
title: "The Ins-and-Outs of Package Management"
date: 2018-10-11 07:24:00
canonical_url: https://blog.automox.com/the-ins-and-outs-of-package-management
source: automox
---

It's hard to remember a time before package managers. A time when software arrived on a set of floppy disks in the mail or a compact disc in the back of a catalog. A time when finding software online meant visiting a half-dozen shady websites that may or may not have been responsible for the three thousand search bars installed on your web browser. A time when you had to just trust the integrity of software distributors, because what other choice did you have?

Okay… maybe it's not that hard to remember.

Finding and installing new software used to be such a chore that the concept of real-time patching for consumers was laughable. What company could afford to deliver minor updates to consumers in a timely manner? For that matter, how could they incentivize users to even install those updates? As internet speeds increased, and access became more ubiquitous, many software vendors built out proprietary solutions for delivering software updates to consumers, but each solution was a singular effort, resulting in dozens of programs on one machine all running their own remote update procedures.

It was hardly sustainable.

## Enter The Package Manager

And then, in 2008, Apple introduced the iPhone App Store and permanently changed the public expectation of software distribution into what it is today. While not even close to being the first package manager in existence, the simplicity of Apple's App Store was what popularized the concept of package managers for consumers, and ultimately paved the way for other devices and operating systems to distribute software packages in a similar manner. What this shift in expectations resulted in was a merging of resources. Now, instead of every software manufacturer being forced to create their own patching solutions (if they chose to create one at all), software updates and patches are delivered in a consistent, reliable—and most importantly, efficient—manner.

"That's great," you might be thinking, "but what exactly *is* a package manager?"

At its core, a package manager does exactly what its name implies: it manages packages installed on a particular device. From installations and uninstallations to updates and configurations, package managers are responsible for ensuring that your software is up-to-date and in the state it is supposed to be in. Additionally, package managers also protect consumers by vetting and verifying the integrity and provenance of software packages and their updates, which means no more discs in the mail or semi-trustworthy websites.

## Types of Package Managers

While there are quite literally hundreds of package managers in the wild, they can generally be broken down into two categories: native package managers and third-party package managers.

### Native Package Managers

Native package managers—you might have heard them called "app stores" before—are so named because they are generally shipped with their host operating system. Because of their close association with the host operating system, the packages within these package managers are intended to have received the highest level of scrutiny, and while there have been widely publicized incidences of native package managers serving up not-so-friendly applications, they are generally the most trusted by consumers.

While the "app store" moniker is one that is most associated with smartphones, thanks to Apple, the terminology is one that has been borrowed in some form or another by nearly every operating system available to consumers today. The iPhone and Mac operating systems have the App Store, Android has the Play Store, Microsoft Windows has the Windows Store, and even Linux distributions have their own solutions like the Ubuntu Snap Store that are powered by their respective command-line package managers.

The "app store" concept has not only simplified the software installation and patching workflows for everyday users, it's actually improved software discovery. With just a little bit of effort, users are more capable than ever of finding high-quality, safe solutions for their daily computing needs. No longer having to rely on word-of-mouth and hours of agonizing research, every-day computer users can find and try new software at the click of a button, which is something that was practically unthinkable two decades ago.

### Third-Party Package Managers

If native package managers are built for the every-day user, third-party package managers are built for the power users. Created to ease the management of package that can't be found within native package managers, third-party package managers provide the same functionality but with much larger catalogues. From Homebrew on macOS to Chocolatey on Windows (and yes, even Linux has solutions like Linuxbrew), these package managers—as the name implies—are built by third-parties, and serve up third-party software.

In addition to the types of user-friendly packages that can be found in native package managers, third-party package managers also often include more advanced packages like software development tools, making them particularly popular amongst programmers. It's worth noting that, while the packages that wind up in these third-party package managers do receive some vetting, it's not nearly as stringent as the vetting performed by native package managers, so trust is something that can be more difficult to earn.

## Package Delivery, Sign Here Please

Regardless of the type of package manager, their end goal is the same: to deliver and install software and patches to their host. But how exactly do they accomplish that? Generally speaking, packages are delivered in one of two formats: binary and raw. Now, while there is no major benefit to the consumer in using one of these package types over the other, it is often an indication of the type of licensing associated with each package.

### Binary Packages

Binary packages are pre-compiled binaries that are delivered to their target operating systems, no compilation required. These packages are generally closed source, and can most often be found via the app stores in Windows and macOS (however even third-party package managers like Homebrew and Chocolatey will deliver binary packages when asked).

### Raw Packages

Raw packages, on the other hand, are delivered "raw," source code and all. These packages are often open source and are compiled directly on the host system, by the host system. While the native package managers on Windows and macOS do not deliver raw packages, nearly every third-party package manager—and even Linux-based native package managers—deal with raw packages most often.

## Package Management for Software Developers

While not technically within the scope of this article, it's worth mentioning that package management isn't limited solely to software delivery. [Factor II](https://12factor.net/dependencies) of The Twelve Factor App states that "a twelve-factor app never relies on implicit existence of system-wide packages. It declares all dependencies, completely and exactly, via a dependency declaration manifest." What this statement means is that software developers should manage application dependencies through the use of a packaging system, such as CPAN for Perl, Rubygems for Ruby, or Composer for PHP (to name a few). This allows developers to isolate, install, and patch dependencies that their applications rely on, which in turn ensures a more stable, secure product.

## Trusting Trust

Let's face it, package managers make the lives of consumers better, but they aren't the only way to install and update software. With manually downloadable binaries and proprietary update channels still being popular methods for delivering applications, there is still a component of trust that must be won; but when can you really trust a software vendor? Security breaches in the software delivery chain are not unheard of and have resulted in malicious packages being downloaded and installed by unsuspecting users in the recent past. In the next article of this series, we will look at how software repositories and download pages have been successfully used as attack vectors, and discuss what (if anything) consumers can do to protect themselves.