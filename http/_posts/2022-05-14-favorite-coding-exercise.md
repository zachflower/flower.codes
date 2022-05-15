---
layout: post
title: "My Favorite Coding Interview Exercise"
date: 2022-05-14 20:04:38
---

I hate interviewing.

Actually... I take that back. I _love_ interviewing. I just hate _being_ interviewed.

Like most software developers, I can count the number of times I've _actually_ had to reverse a linked list, or traverse a binary tree in a work setting on zero hands. But I've _completely_ lost track of the number of times I've actually been _asked_ to do those things on a whiteboard.

It's a pain in the ass, and while the interviewers might get _some_ value out of them—assuming their goal is to evaluate a candidate's skill and not just show off their own knowledge—it leaves the interviewee with an unclear idea of what it is actually like to _work_ at the company in question.

Because that's the thing that a lot of companies forget about the hiring process: it's a two-way street. As much as you are evaluating every candidate for fit within your organization, _they_ are evaluating _you_ for the same thing, which is why it is crucial to structure your interview process in a way that is mutually beneficial.

_Great_, I can hear you thinking, _I've only got a couple hours to get to know this person, how the hell do I do that?_

To put it bluntly: with deliberate planning and execution.

## Properly Evaluating a Candidate

While I'm a fan of creating interview "tracts" to send candidates through, where each session is designed to measure a specific quality or skill, my personal favorite is the **collaborative coding** exercise.

In this session, you pair up an engineer with a candidate for an hour and a half and give them a project to work on together. This isn't an exercise where the candidate is forced to write code on a whiteboard while the engineer evaluates them, but instead one where they actually work on the solution together on a real live computer.

To keep your employee and your candidate on equal footing—and thus to properly simulate the type of collaborative environment you can find within an engineering team—I've found the following rules to be a good place to start:

### Let the candidate choose the programming language.

By allowing the candidate to choose the programming language to build the project in, it puts them in the drivers seat. While the engineer they are working with _may_ have solved this problem with previous candidates, giving the candidate control over the tech stack ensures that the exercise is a truly collaborative one rather than a guided one.

### Encourage a familiar environment.

Companies generally shouldn't dictate the tools their engineers use. Vim or Emacs, CLI or GUI, even Linux or... you know... the other ones; generally, it doesn't matter. Productivity is king, and our choice of tooling _aids_ in that productivity.

So when you have a candidate come in for your collaborative programming exercise, encourage them to bring their laptop in. Let them work in the development environment they are _most_ comfortable in. After all, you've got less than two hours together. Putting someone in the drivers seat of an unfamiliar car isn't going to make the task any easier.

### Evaluate the journey, not the destination.

When I run this exercise, the last thing I care about is whether or not we actually _solve_ the problem. Not every problem can be solved within such a fixed time period, so treating completion as pass/fail will likely reject many qualified candidates. Instead, focus on how the problem solving _goes_.

How do they get started? How well do they collaborate? Do they accept input or ignore it? Do they over-think, or are they sloppy? There's no better way to get a feel for what it's like to work with someone than to _actually work with them_. I've found that 90 minutes working with someone in this scenario is _very_ reflective of what _always_ working with someone is like.

**Encourage pragmatism.**

Most software developer candidates want to show that they know how to do the work _and_ that they know how to do it _right_. But in this scenario, they've got no time for that. I like to set expectations early on what the point of the exercise is (see above), and that things like code quality and unit tests are neither expected or beneficial.

That said, I have found that even when asked to forego that stuff, most candidates will mention _how_ they might test something, how they'd structure the solution if they had extra time, or note the corners they are intentionally cutting as a result of the time constraint.

## Choosing a Project

Ideally, the project chosen follows [Joel Spolsky's advice](https://www.joelonsoftware.com/2006/10/24/the-phone-screen-2/) about properly evaluating software developers over the phone:

> The ideal question takes something where the interviewee is deeply familiar with how the thing works from having used it, but is unlikely to have ever implemented it themselves.

The project I am most fond of for this exercise is the web server. Of the above criteria, most backend web developers should deeply familiar with how a web server works, _and_ are unlikely to have ever implemented it themselves (to that end, I've only ever had _one_ candidate who had built a web server before).

Here's the thing, creating a _feature complete_ web server in 90 minutes is impossible, but getting the bones in place to accept and respond to simple HTTP requests is not only doable, but is also _just_ tricky enough to make it fun. If we can spin up a simple socket server and properly respond to `GET` requests from a standard web browser, then we've got a winner!

Knock it out in 30 minutes instead of 90? There's always room to grow. Add support for `POST` requests, mime type parsing, or cache headers. It's the roaring 20s. Web servers are freaking complicated now. Get creative.

## Keep Both Lanes Open

I said it above, but it bears repeating:

> ... that's the thing that a lot of companies forget about the hiring process: it's a two-way street. As much as you are evaluating every candidate for fit within your organization, _they_ are evaluating _you_ for the same thing, which is why it is crucial to structure your interview process in a way that is mutually beneficial.

The interview process isn't _just_ about candidates. It's also about you. How you treat them reflects directly on you and your company, and in my vast experience from ignoring my Spidey Sense and joining companies with shitty interviewers, that reflection is _pretty accurate_.

--

_This is post 011 of [#100DaysToOffload](https://100daystooffload.com/)_