---
layout: post
title: "What's Your Open Source Bucket List?"
date: 9999-01-01 12:00:00
---

I'm not ashamed to admit that I don't usually contribute to open source as a way of giving back to the community for everything it has given me. Don't get me wrong, it's a great side effect, but the reason that I do it is because _it makes me feel good_.

That's it.

Not the most altruistic of motives, I know.

A long time ago, I jotted down a bucket list of sorts containing all of the open source projects I would love to make my mark on. There's something about building something that thousands of other engineers might get value out of that is really satisfying, so I went about making a list of all of the open source projects that I actively use.

The list (while not complete), looked something like this:

- [Electron](https://github.com/electron/electron)
- [Visual Studio Code](https://github.com/microsoft/vscode)
- [Vagrant](https://github.com/hashicorp/vagrant)
- [PHP](https://github.com/php/php-src)
- [Laravel](https://github.com/laravel/laravel/)
- [Composer](https://github.com/composer/composer)
- [Vim](https://github.com/vim/vim)
- [Curl](https://github.com/curl/curl)
- [Faker](https://github.com/fzaninotto/Faker)
- [Jekyll](https://github.com/jekyll/jekyll)

## Da Contributions

So far, I've been able to check off a couple of these: Faker, Electron, Vagrant, and Composer. The changes aren't exactly groundbreaking, but in order to check a project off of my bucket list, I have a rule that it must be a _substantial change_ (such as a major bug fix or new feature), and not something minor like a typo-fix.

### Faker: US SSN Support

Faker is an extremely robust (and now archived) PHP library for generating fake data for testing. As an advocate for shift-left testing, it has been one of my favorite projects to-date, and is one that I use almost daily.

One of my first _real_ open source contributions was adding support for US Social Security Numbers (SSN) to Faker. A pretty simple addition, all things considered, but one that solved a personal need _and_ got my code into the hands of every single project that has used Faker since—what a rush!

**Pull Request**: https://github.com/fzaninotto/Faker/pull/1266

### Faker: US EIN Support

It wasn't long after adding SSN support to Faker that I got the itch to fill another gap I saw: US Employee Identification Numbers (EIN). In the US, an EIN is like an SSN, but for companies. At the time, I didn't actually _need_ to generate an EIN for testing, but that didn't stop me. I knew that _someone_ would need the feature—and, after five years, I can safely say that I have _personally_ needed to use it during testing.

**Pull Request**: https://github.com/fzaninotto/Faker/pull/1273

### Electron: Non-Native macOS Fullscreen

Everyone knows what Electron is, so I won't repeat what doesn't need repeated here. That said, this is probably my proudest contribution to-date, and one that has had the most exciting downstream effects.

When macOS released Lion, they changed the way their native fullscreen works. Rather than simply maximizing the window and removing the titlebar, dock, etc., they instead do all those things _and_ move the window to a new desktop window. While not a big frustration in-itself, when combined with multiple monitors, all the other monitors would be blacked out and rendered useless. As you can imagine, this was _incredibly_ frustrating to most power-users (myself included).

As a fan of Visual Studio Code, I (and many others) _longed_ for the old-school fullscreen in my editor, but it was hampered by Electron's own limitations. So I did some digging, and found that [iTerm2](https://iterm2.com/) (a popular open source terminal emulator for macOS) had developed their own workaround to the Lion-style fullscreen. After a lot of trial-and-error in a language I had never written-in before (hello, Objective-C), I was able to reproduce the functionality within Electron and (eventually) get the feature merged in.

**Pull Request**: https://github.com/electron/electron/pull/10254

What made this so exciting was that, while I contributed a much-desired feature into an incredibly popular product, there were some _great_ downstream effects in products that were built on-top of Electron:

- **Atom**: https://github.com/atom/atom/pull/21214
- **Visual Studio Code**: https://github.com/microsoft/vscode/pull/55267

### Vagrant: Custom Vagrantfile Templates

While I've mostly moved over to Docker for managing developer environments, I've always been a [_huge_ fan of Vagrant](https://flower.codes/2015/10/17/why-vagrant-is-the-best.html). It has that wonderful combination of both simple and powerful that I love, so contributing back to it was pretty high on my list.

A gap in the Vagrant feature set that I noticed was the lack of Vagrantfile "templates." For the uninitiated, a Vagrantfile defines exactly _how_ the underlying virtual machine should be provisioned, and I often found myself copying and pasting the same general set of instructions over for every project I used.

The solution that I came up with was a templating system that allowed you to initialize a Vagrant project using a defined template file. This made it easy to kickstart any project with a pre-defined set of instructions or resources without having to copy-and-paste the same block of code over-and-over.

**Pull Request**: https://github.com/hashicorp/vagrant/pull/9202

### Vagrant: Vagrant Aliases

Still on the Vagrant train, another feature that I'm particularly proud of contributing is "Aliases." [Vagrant Aliases](https://flower.codes/2020/05/15/introduction-to-vagrant-aliases.html), a feature that was inspired by both Git aliases and Bash aliases, is exactly what it sounds like: the ability to define additional Vagrant commands as aliases (for example, `vagrant destroy` executing `rm -rf .vagrant`).

**Pull Request**: https://github.com/hashicorp/vagrant/pull/9504

### Composer: Default Init Values

Every PHP developer knows about Composer, PHP's de-facto package manager. One feature that it was missing at the time was the ability to define default values when initializing a Composer project, meaning that you _always_ had to type in your name, email, etc (even if they never changed).

At the time, I was leading development at a digital agency, which meant I created a _lot_ of Composer projects. While filling out the same details every time wasn't the _most_ time consuming experience, it got tedious enough that it was worth the diversion to streamline my process a bit.

**Pull Request**: https://github.com/composer/composer/pull/6743

## What's On _Your_ Bucket List?

Clearly I haven't made _that_ big of a dent in my open source contributions. As you can tell, the big ones tapered off around early 2018 (which happens to be just shortly after my second child was born). That said, I still try to look for opportunities to contribute when and where I can (despite having very little time to do so).

But, enough about me. Do you happen to have your own open source bucket list, and if so what is on it? Shoot me an email or (if the platform you are reading this on allows it) drop a comment in. I'd love to hear from you!