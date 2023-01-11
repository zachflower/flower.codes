---
layout: post
title:  "How (and why) to Perform a Project Audit"
date:   2016-06-24 12:00:00
---
As a freelance developer, I am occasionally asked to audit projects that have had the majority of development outsourced. While outsourcing isn’t an intrinsically bad thing, managing an outsourced product requires you to walk a very fine line between "bootstrapped" and "cheap."

## The Code

No two codebases are the same, so it is important to stay unbiased while performing a codebase audit; this is not the place to push new development tools and frameworks on a client. The goal of a codebase audit is to identify potential areas of "risk." Risk being defined by the client’s ultimate goals.

If they want to keep costs down, then you should highlight potential places to save money (and potential places where they will lose money). If the client is planning on bringing their development in-house, then identifying ways to reduce the onboarding time of new developers is the way to go (although it can’t hurt to find ways to reduce cost and improve efficiency too).

Regardless of the client’s goals, I personally tend to follow a loose list of things to check, and make notes and recommendations in a way that is framed specifically for the client’s needs.

### Organization

Organization is usually where you will find the majority of issues in any project. The reason for this is that most outsourced teams use a dynamic, rolling team of developers. This brings with it a lot of different styles, so you will often find a mix of clean and dirty logic.

Take note of illogical file names and sloppy directory structures. If the project is built on top of a third-party framework (Ruby on Rails, Laravel, etc), then make sure that the project code is organization within the "style" of said framework. Understanding the difference between the various object types (Models, Views, Controllers, Libraries, Helpers, etc.) and how they are used within each framework is important to provide an education recommendation here.

### Code Style

The next thing I tend to look at is code style. As I mentioned before, outsourced teams are often a revolving door of developers, and their primary goal is "results." The last thing they tend to care about is how "pretty" the code looks.

Enforcing a code style guide isn’t going to provide any immediate financial gains, however if a company is looking to bring development in-house then a consistent and documented code style is crucial to reduce developer onboarding time. The more readable a codebase is, the easier it will be for new developers to get acclimated to it and become productive.

### Best Practices

Now we’re getting into the meat of things. Best practices can be a little amorphous because of the conflicting opinions about some things. The general rule of thumb I follow is, if I were mentoring a junior developer, how would I review _his_ code? This will require an incredibly thorough review of the codebase, and more often than not will result in a bunch of "this makes no sense," but the most important thing you can provide your client is your recommendation.

Highlighting problem areas of the code is the easy part. Anyone can identify poor logic, but the true value of an audit is the guidance you can provide. _Why_ is a particular method illogical? _How_ can it be improved? _What_ are the benefits of the update? All important questions, but to really drive the point home, provide sources. This research will not only give your client something to bring back to their team, but will also help to further your own education.

### Security

Security is tough. An attacker only needs to find one hole, while defenders need to think of every possible one. Unfortunately, from my experience, outsourced teams rarely give much thought to security. Unless you have security experience, this is one of those areas where your best bet is to identify the glaring issues in order to highlight the bigger picture.

A few of the things I tend to look for are plain-text passwords in the codebase, whether the third-party dependencies are up-to-date, and if user input is validated and escaped. You may not be able to find everything, but this is one of those situations where a few problems strongly allude to a much bigger one.

## The Process

The codebase is only half of the puzzle when doing an audit. The second half is the process. The _way_ things are done is just as important (if not more) as _what_ is done. The process is the place where you can recommend tools and packages to improve the way a tool is built. Are they putting all of their styles in one giant CSS file? JavaScript files not compressed? Recommending implementing a CSS preprocessor or code minifier is appropriate here.

### Documentation

Documentation is usually the last thing on anyone’s mind, but when dealing with an outsourced product, documentation should be an absolute requirement. Knowledge isn’t kept in-house on an outsourced project, so steps need to be taken to mitigate it. Changelogs, development environment setup, integration notes; all of these things must be accounted for.

Documentation can be a lot to ask for, but imagine buying a car with no owner’s manual. As a freelancer, every product I deliver includes clear documentation. This is both for my own sanity (when the project is over, the last thing I want is to answer an email six months later about a particular configuration I’ve completely forgotten about), and to empower my client.

### Development Environment

Auditing the development environment may be going a bit above and beyond, but if the primary goal of your client is to bring development in-house, then a quick audit of the development environment is appropriate. The key here is to try and get the code running yourself, take note of any issues you have doing it, and make recommendations as to how it can be improved.

This will most likely be "install these packages on your local machine, neener neener," in which case I would personally recommend adopting [Vagrant](https://www.vagrantup.com/) to manage the development environment (full disclosure: I’m a bit of a [Vagrant snob](https://dzone.com/articles/why-vagrant-is-the-best-developer-environment)). I actually enjoy this part because I specialize in building Vagrant development environments for clients, so it gives me an opportunity to upsell my services.

### Deployment Process

While the deployment process may be managed either in-house or externally, understanding how the code gets deployed can shed some light on the technical literacy of the team. Is it being uploaded directly to a server via FTP, or are [atomic](https://en.wikipedia.org/wiki/Atomicity_%28database_systems%29) deploys being utilized? If you can make suggestions to improve on the process, then do.

### Version Control System

This is the big question. Is a version control system like Git or Mercurial being used? It sure as hell better be. If it isn’t, then there is a whole different conversation you need to have with the client about their team, but let’s assume that it is. The two things I tend to look at are the commit messages and the workflow.

Commit messages should be clear and concise. It should be clear _what_ was changed, and _why_. I don’t know how many times I’ve run across a project that had an entire git history filled with periods as commit messages. That’s it. Nothing but periods. Nobody wants to reverse engineer an application by the git diffs.

The [VCS workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/) is the next thing you should look at. While we can debate things like Gitflow and Centralized Workflow for hours, the biggest thing to take note of is branch utilization. In-progress development work should not be done on master, so if you see a single straight line in the git tree, you have something to talk about. My advice on this is to recommend an appropriate workflow for your client, rather than your personal favorite (for example, I like Gitflow, but Feature Branch might be a better workflow for inexperienced teams).

In the end, the steps you follow to perform a project audit should be modified to fit the client. This is, after all, a set of guidelines rather than a rulebook; a roadmap for your client to help them safely (and confidently) build their project on a budget. While it can be tough to compete with low-priced outsourced teams as a freelancer, our expertise and professionalism are the best way to stand out and work _with_ those same companies that outsource development.
