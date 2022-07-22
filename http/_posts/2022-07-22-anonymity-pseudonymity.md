---
layout: post
title: Anonymity and Pseudonymity
date: 2022-07-22 14:48:00
rss_only: true
---

I've been thinking a lot about identity lately. Not in the existential sense, but the literal one: my name, my face, my contact information; all of the things that don't tell you who I *am*, but still sort of tell you *who* I am.

Being anonymous on the internet isn't impossible, but it sure as hell isn't easy either. You have a name, a face, and email address, a phone number... these things, and more, are being asked of us all the time to prove our legitimacy on countless websites.

You have to put *something* down, even if it's a lie, but how do you come up with a new name and face for every website you use? And how the hell do you keep *track* of all of them?

After watching more paranoia-driven YouTube videos about privacy and the Internet than I care to admit, I've come up with a few websites and services that have helped me generate random pseudonyms—also known as aliases—for every service I sign up for.

Some of these tools help take the cognitive load off of making up random information, while others actually help you hide your identity at a deeper level. That said, it's important to remember that any service you use becomes a bottleneck in and of itself, so just because you use a different email for every website, app, and service, if you generated those emails using a single tool, then _that tool_ still knows who you are.

These tools aren't a pancea, but at the very least they can reduce your blast radius in the event of a data breach or other compromising incident.

## Identity

There's something about random identity generation that I absolutely _love_. It's not a particularly _difficult_ problem, but the output is a fascinating one. I've been playing around with https://www.fakenamegenerator.com/ for _years_ as a software developer, diligently generating new names for every demo application I use.

What makes FNG (that's right, I used a cool initialism) so interesting is that it goes _far_ beyond just generating fake names. For the (very free) click of a button, you can generate a name, an address, a social security number, a username, a password, a _credit card number_, physical characteristics, and just about anything else that could be used to fill out an online form you _really_ don't want to fill out.

While I sometimes skip FNG and use the name of a fictional character, celebrity, or the tried-and-true "John Smith," it is a great way to override my own biases and ensure that I'm not falling into the trap of adhering to a pattern I'm not aware of.

## Avatar

Artificial intelligence has come a _long_ way in recent years. One particularly interesting use is https://thispersondoesnotexist.com/, a website that generates a photo of a 100% real looking person that 100% _does not exist_. While you can always use the default avatar (or even a non-human one, like an animal or cartoon character), there's something satisfying about selecting a picture of what looks like a _real_ human being to go with your randomly generated aliases.

## Email

Even if you _never_ intend to use a pseudonym for your online accounts, there is a good case to be made for using a different email address for every service. Credential stuffing is the act of taking leaked emails and passwords from one data breach and attempting to use those same combinations on other websites, which means that if you use the same email and password for multiple services, when _one_ gets compromised, they _all_ get compromised.

"Why not just use the Gmail `email+keyword@gmail.com` address trick," you ask?

Well, for one, appending `+keyword` to the end of your email address is trivial to programmatically remove, which means that it doesn't anonymize you at all. In addition, there are plenty of email validators that simply won't accept an email with a `+` sign in it, in which case you're back to square one.

To help combat this, I'm a big fan of https://anonaddy.com/, an open source service (with helpful browser extensions and mobile apps) that allows you to generate a brand new email address on the fly that automatically forwards to the destination email you choose.

What makes it particularly great is that, if a service gets compromised or that email address gets shared around to other service providers for ~~SPAM~~ marketing purposes, you can simply shut the email off and wash your hands of the whole thing. Easy peasey.

## Other

Now, the previous sections focused on the basics of online identity, the things that are asked for most often. But they aren't the _only_ things used to identify you. The next few sections outline some more advanced (and, potentially pricey) ways to present yourself as a "completely unique individual" for every service you sign up for.

### Phone

A not-insignificant number of apps and websites have decided that emails and passwords are "bad," so they've moved to using pin-based logins that get texted to your phone number—nevermind the fact that SIM swapping makes using a phone number as a login method a laughable instance of security theater.

While you can always generate a _single_ pseudonymous phone number using Google Voice, a more "on rails" solution is https://www.burnerapp.com/, a mobile app that can be used to generate (and destroy) multiple temporary phone numbers at once. I don't personally use this service, but I like the _idea_ behind it.

### Credit Card

Sometimes you have to pay for stuff, and despite popular belief, Bitcoin is _not_ a privacy-based coin. After all, if someone finds your wallet address, then _every_ purchase you've made is available for the whole world to see.

Yikes.

If, like me, you want to use a regular old, regulated credit card, then https://privacy.com/ is the way to go. What I like about Privacy is that you can generate a new credit card for every online merchant you purchase from (and even a new card for every single purchase). By specifying a maximum amount per charge (or month, or year, or ever), you can protect yourself from overbilling (or, you know, forgetting to cancel that free trial you signed up for).

But, if you'd like to reinforce your privacy (no pun intended), Privacy can be configured to use a generic billing description when charging your underlying bank account. This means that you can buy a subscription to [2600 magazine](https://2600.com/), and all your bank will see is something like `NSA Gift Shop`.

## Anything Missed?

Let's be clear: I'm not a privacy expert. I have no idea what the hell I'm doing, and I can guarantee that the vast majority of the "influencers" on YouTube and elsewhere don't either. But, _some_ effort is better than _no_ effort, right? If you're reading this, and have any services or ideas to share, _please_ send them my way.

--

_This is post 015 of [#100DaysToOffload](https://100daystooffload.com/)_