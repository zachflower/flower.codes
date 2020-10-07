---
layout: post
title:  "Good Code Is Subjective, Documentation Is Not"
date:   2016-09-08 12:00:00
permalink: good-code-is-subjective-documentation-is-not/
---
Last week, I had an interesting chat with a peer about the difficulty of finding a balance between using established standards and building proprietary solutions within development projects. Personally, I’m an advocate for utilizing established third-party solutions whenever possible as a way to reduce new developer onboarding time and increase architectural knowledge within the team; but I’ll admit that there are times when you have to break the mold and create something custom to accomplish business goals.

In an attempt to work out a way to reduce the impact of these decisions, I took the stance that all proprietary code should be accompanied by clear documentation in order to prevent knowledge silos within a project. While this requirement means that the time it takes to document proprietary features would have to be taken into account during project planning, it is a good way to ensure the team is prioritizing standards-based solutions over custom ones whenever possible.

This conversation brought to mind a phrase that I’ve been seeing more and more lately:

> Good code doesn’t need documentation.

What a crock of shit.

The problem with the “good code = documentation” sentiment is that good code is _entirely_ subjective, while documentation is not. Developers come in all experience levels, and think in many different ways, which leaves undocumented code completely up to interpretation. Just because the reasons for using that GOTO there are clear to you, does not mean those reasons will be clear to the next person who sees your code.

Now, the best way to document code is entirely up to debate (a debate nobody will ever win) but, at a bare minimum, clear comments should be a requirement of any organization. Sure, a beautifully organized wiki would be fantastic, but managing something like a wiki can be detrimental to your productivity (especially when you’re already neck-deep in code) so let’s stick with comments for now.

Unfortunately, writing comments is super easy, but writing _quality_ comments takes a little more time and effort. Exactly what “quality” means in this context is dependent on the organization but, at a high level, comments should explain the “why” and the “how” of the code. A codebase filled with one-liners saying things like “this loop iterates through the data” is far from useful; which is exactly the reason that documentation standards like [PHPDoc](https://www.phpdoc.org/) and [Ruby-Doc](http://ruby-doc.org/) exist. They keep code and documentation together in a commonly accepted standard and encourage more thorough breakdowns of how and why a piece of code works.

I think, as developers, we like to think of code as a recipe. All the steps are written out, so understanding code is as simple as reading the steps, but that’s not the way code works. Programming is an art form, and programmers each have their own unique style and thought process, so it is important to remember that what is clear and intuitive to one may be disorganized and confusing to another.
