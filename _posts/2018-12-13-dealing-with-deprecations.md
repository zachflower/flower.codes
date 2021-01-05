---
layout: post
title: "Soft(there): Dealing With Deprecations"
date: 2018-12-13 07:24:00
permalink: dealing-with-deprecations/
canonical_url: https://blog.automox.com/softthere-dealing-with-deprecations
category: automox
---

"If it ain't broke, don't fix it."

As a software developer, I can't express how much I hate that phrase. Popularized in 1977 by Bert Lance, the then-Director of the Office of Management and Budget under President Carter, "if it ain't broke, don't fix it" is an oft-used mantra amongst the change-averse that—in the context of computing—can have disastrous effects on everything from productivity to security. While originally intended to highlight the importance of focusing resources on impactful problems instead of perceived ones—a process lovingly known as "yak shaving" in software development—this southern colloquialism-turned-cliché has become a catch-all for any marginally-convincing reason to avoid updating out-of-date software.

Unlike objects in the physical world, the lifespan of any individual piece of software is exceptionally small. On one hand, as computing resources get faster and more efficient, so too do the applications that run on them, which ultimately encourages innovation and progress—imagine a world where software developers continued to work with the hardware limitations of a pre-internet era. On the other hand, our growing understanding of the art of software development has resulted in an equally-improved understanding of what it takes to corrupt previously-stable software.

## It's Probably Broke

But, if it ain't broke, don't fix it, right?

In 1993, while looking for a better way to manage his personal finances, my dad purchased a fresh copy of Quicken 3.0 for Windows and installed it on his personal computer. Over the next two decades, as Quicken released dozens of new versions for a growing market, that old computer jumped from my dad's office to our home office… and then to a spare bedroom… and then finally our basement, where it quietly lived out the remainder of its life. Satisfied with the software he had originally purchased, my dad never upgraded Quicken. With every new release, his accounting tool grew more and more obsolete, until the hardware it was first installed on started to fail and 20 years of data was nearly lost inside a piece of dead software that was practically impossible to migrate off of.

In the pre-internet era of unconnected applications, dealing with deprecated software is—more often than not—a matter of data resiliency. But, in a post-web world, obsolescence can have a much more serious impact on things we can't afford to take for granted, such as security and privacy. As our devices become more connected to one another, the potential attack surface also increases. In some cases, this has lead to companies offering extended security support for far longer than is reasonable, but in others, the onus is put on the user to upgrade or suffer the wrath of the next great cybersecurity incident.

To put a point on how severe this risk is, on January 1, 2019, version 5 of the PHP programming language will officially stop receiving new updates. This means that, after more than 14 years in active development, there will be no more patches, fixes, and or support for the soon-to-be-obsolete version of the web's most popular programming language. While the deprecation of a single version of a decades-old programming language is hardly a newsworthy event, the troubling fact is that PHP 5 currently powers nearly 60% of the entire internet… and almost no one is ready for the upgrade.

## So Fix It

So, what can we do about it?

The simple answer here is to #patchyourshit, but while that is a great solution in theory, it can be far more complicated in practice. The thing is, while minor software versions can be incrementally applied with minimal impact, the same can't be said for major version releases. Looking at our PHP problem, the vast majority of websites that are affected are running PHP 5.6, the final version released within the PHP 5 family. The impact of upgrading from PHP 5.3 to 5.6 is practically nonexistent, but upgrading from PHP 5.6 to 7.0 (PHP skipped version 6 because reasons) can be a massive undertaking resulting in countless man hours and financial burdens.

While in some cases it is possible to pay for extended support of deprecated software, this is hardly a sustainable solution. At some point, the financial impact of maintaining a piece of software beyond its life will be too great, and the cost caused by the interim years where that software was not upgraded or replaced will be compounded. Maintaining third-party software is an ongoing job, and as a result should be treated with an appropriate level of seriousness to match its importance.

The reality of deprecated software is that you can't live with it forever, and while there will always be a newer, shinier solution out there, what matters most is that you look beyond the short-term impact of keeping your packages up-to-date. In the long run, it's far easier to take one small step every day than it is to attempt one giant leap at the last possible second.

## But… How?

Like all high-risk patching, dealing with deprecated software is a matter of impact mitigation. No matter how easy it is to apply a patch, it is crucial to test it in a controlled environment in order to identify potential issues you may run into in production. This is particularly true when dealing with software that has been completely abandoned. While running deprecated software is hardly ideal, there is almost always a solution that endeavors to be a low-effort replacement (and in some cases, a free replacement). The point is to stay ahead of the problem, rather than procrastinating until you can't ignore it anymore.

Ultimately, the problem with software is that the classical definition of "broke" doesn't apply, because broken software is rarely fixed; it's replaced. While my dad would have happily run that abandoned version of Quicken for another 20 years, and millions of website owners would be glad to run PHP 5 unto eternity, the fact of the matter is that the second a new version was released, their death clocks started counting down. The further removed an installed piece of software is from the currently available version, the more impactful the upgrade becomes because patching deprecated software isn't about fixing something that's broken, it's about ensuring that it never becomes broken in the first place.

## Achieving Consistency

When it comes to cyber hygiene, patching is the name of the game. The safety and security of your organization relies on patched operating systems, software, and properly managed third-party solutions, but there's a fourth pillar that can help bring it all together. Managing endpoints by hand is an unsustainable solution that can eat up nearly every bit of time you have, which is where endpoint management comes into play. As a software developer, I believe in the power of automation in driving consistency in my infrastructure. In the next and final parts of this series, we will be diving deep into some of the most popular cross-platform endpoint management tools available, and identifying ways in which they can be used to maintain a consistent configuration across every machine in your stable.