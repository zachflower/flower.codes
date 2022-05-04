---
layout: post
title: "A Few Heroku Alternatives"
date: 9999-01-01 12:00:00
---

Heroku's been taking it on the chin lately for their response to what looks to be a pretty-damn-serious security incident—and for good reason, because [their communication](https://www.theregister.com/2022/05/04/heroku_security_communication_dubbed_complete/) about the whole event has been _abysmal_.

Personally, this is a pretty big letdown, because I've been riding the [Heroku train](https://flower.codes/2016/06/28/cloudflare-laravel-heroku.html) for quite some time. As a software developer with a history of working for teeny-tiny startups (on top of a fair amount of freelancing), Heroku's platform-as-a-service solution (PaaS for all you cool kids out there) has been a lifesaver.

When you're crunched for time and resources, offloading things like server maintenance, security, database management, and all the other _tasks_ that accompany running a software company is incredibly valuable; and Heroku's add-on marketplace is just icing on the cake.

Trust me, there's nothing more satisfying than spinning up all the internal and external resources you need within a single-pane of glass. As a freelancer, this sort of organization makes billing clients (and eventually transferring application ownership) a snap.

## Heroku Alternatives

Buut... all of that is gone now. It has been outweighed by a complete and total lack of trust in a company that I've historically put a _lot_ of trust in. As a result, I've been exploring a few Heroku alternatives that are all _relatively_ new to the PaaS space.

To be clear, I'm skipping the most well-known solutions like [DigitalOcean](https://m.do.co/c/a8eb87aea1f2)'s App Platform and [Google Cloud](https://cloud.google.com/)'s App Engine, because I think most people are already aware of them, so flogging that particular horse is probably just a waste of bits and bytes.

That said, I've stumbled across a handful of _awesome_ solutions that are both unique _and_ pretty "indie" feeling—a great combination in the "tools by developers, for developers" category, if you ask me.

### Fly.io

I've heard of [Fly.io](https://fly.io/) a few times over the years, but it wasn't until just the last few days that I've really taken the opportunity to try it out; and, I've got to say, it's pretty damn awesome.

While not nearly as "feature robust" as Heroku (read: no "marketplace"), it is a Docker-driven solution with an _incredibly_ generous free tier, and one of the most impressive commitments to technical writing I've ever seen (which, if I'm being honest, is only outshone by DigitalOcean's approach).

As the founder of [The MUD Coders Guild](https://mudcoders.com/), I personally own and manage any of the integrations and websites that we rely on, and have chosen Fly.io as our new destination. The transition from Heroku to Fly.io was about as painless as you could imagine, and the terminal-driven management has been a great experience.

If you are on the fence and don't have a huge application footprint, you definitely can't go wrong with Fly.

### Render

[Render](https://render.com/) is a new solution for me, but it most closely resembles Heroku as far as features and functionality goes (although that isn't to imply that it is no better than Heroku). A winner in the 2019 TechCrunch Startup Battlefield (an event I will forever associate with Pied Piper and Middle-Out Encryption thanks to HBO's [Silicon Valley](https://yewtu.be/watch?v=7G5Mf6Zqe0E)), Render offers all the bells-and-whistles that we've come to expect in a PaaS platorm:

- Autoscaling
- Managed databases
- Preview environments
- Docker deployments
- And _actual_ cron support

I have yet to dig _too_ deeply into it, but will likely be moving some of my more complicated freelance projects over to Render when the opportunity presents itself (and, just as an aside, their free tier is about as generous as you can ask for).

### Porter

I've examined [Porter](https://www.getporter.dev/) in the past as a part of an [Open Source PaaS](https://www.techtarget.com/searchcloudcomputing/feature/6-open-source-PaaS-options-developers-should-know) roundup for TechTarget and _really_ liked what I saw.

What sets porter apart from the other solutions on this list is that it is an open source _and_ self-hosted option. While they do offer a managed cloud solution that relies on your _own_ backend infrastructure, the self-hosted option is super compelling as it gives you total control over your infrastructure.

While I am personally not in the "manage all my things" game, this is an excellent solution for people that are looking to make the leap from hosted PaaS to managing their own infrastructure.

## Conclusion

Obviously, there are a hell of a lot more platform-as-a-service providers out there than just these three. From big to small, proprietary to open source, it's a pretty big space. That said, these three are the more compelling ones in my mind, and I will be watching them as they continue to grow.

If these don't quite fit with your needs and are looking for more options to try, take a look at this [Awesome-PaaS list](https://github.com/debarshibasak/awesome-paas). There are some great solutions available.