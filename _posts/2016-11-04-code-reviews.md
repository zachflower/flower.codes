---
layout: post
title:  "Why We Review"
date:   2016-11-04 12:00:00
permalink: why-we-review/
---
Many development agencies refuse to inherit already built projects, and earlier this year, I found out why.

The most dreaded part of any developer's job is dealing with "legacy code." While legacy code is a near inevitability in most tech companies, understanding and maintaining it is time consuming and costly. For this reason, many freelancers and agencies refuse to accept work for existing projects. The knowledge transfer alone can be enough to whittle away earnings on a flat rate project down to minimum wage, but when you tack on maintenance, support, and feature development, the project ends up costing more money than it makes.

## My Code "Good," Your Code "Bad"

Complete project ownership is more profitable. It's a pretty straightforward concept; the more original code you write, the more you can charge for. Unfortunately for me, it's an opinion I don't tend to subscribe to. Legacy code is difficult to maintain and manage, and as a solo freelancer I have the luxury of being able to charge for the added difficulty without going over budget.
This stance has served me well in the past.

While I'd like to think that my professional experience has made me a relatively decent programmer, it has made me a much better engineer. I've learned that, more often than not, "bad" code is really just "ugly" or "inexperienced" code. Being able to understand the _why_ of design decisions is far more important than the _how_.

Last year I inherited a very large project from an "award winning" interactive digital agency. At first glance, the code was cleanly organized (albeit entirely undocumented), but was lacking any test coverage and was running outdated packages. As I dug deeper, however, it was clear that this project was built entirely by a junior developer.

That fact, on its own, isn't really all that surprising or damning. We all have to learn somewhere. What did surprise me was the obvious lack of senior oversight on the project.

## The Pitfalls of Unreviewed Code

The codebase was filled with both repetitive code segments that could have been pared down to singular methods ("[DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)," as it were), as well as massive and unique individual methods that should have been split into multiple parts. The biggest offender in this project, however, was the criminally inefficient database query design.

To provide a quick example of what I mean, the database had a 5 million row MySQL table that was the backbone of the project. By itself, this wouldn't be much of an issue; however, in order to extract data out of this table, the codebase was riddled with triple nested queries that pulled, at _minimum_, 3 million rows directly into memory. The data in memory was then reduced by the web application for various reasons (extracting individual user data, setting up pagination, etc).

I feel the need to emphasize the fact that these operations directly affected the users. As a backend developer, I understand that the backend often needs to do some heavy lifting in order to provide value in a quick way to the consumers, but this wasn't a case of backend pre-caching. These operations were utilized directly within the web application, increasing the load time of the application by up to 10 minutes for the users that were unfortunate enough to not get served a cached response.

## Mentorship is a Responsibility

While the amount of time I had to spend optimizing this code was infuriating, I really can't be too angry at the original developer of this project. The blame lies solely on his superiors. When you are a senior or lead developer within an organization, it is your responsibility to mentor the new and inexperienced developers in order to ensure a consistent quality of projects across the board.

A subscription to [Code School](https://www.codeschool.com/) isn't enough.

Bag lunches, code reviews, code style guides, unit tests... These are all things that should be implemented within an organization in order to ensure attention to detail and quality. In my heart, I know if an experienced developer had reviewed this code, the inefficiencies would have been ironed out long before entering a production environment. Not only that, but the developer on the project would have gained some valuable feedback that would have positively furthered his education and career.
