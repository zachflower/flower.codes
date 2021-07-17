---
layout: post
title: "Fix Spaghetti Code and Other Pasta-Theory Antipatterns"
date: 2020-05-29 07:24:00
canonical_url: https://searchsoftwarequality.techtarget.com/tip/Fix-spaghetti-code-and-other-pasta-theory-antipatterns
source: techtarget
---

Nobody ever said it's easy to write clean code. Successful software development isn't just about making software work; it's about making sure it will continue to work. While hardly an exciting objective, code maintainability is one of the most important elements of any application.

So, what does maintainable code look like? There is no single answer to that question. Every language, framework and company has a different strategy to ensure durable, maintainable code. Developers should understand the reasons why code fails to be maintainable, to avoid programming antipatterns.

Nearly every software developer agrees on what maintainable code doesn't look like: pasta. The pasta theory of programming, in which various types of unmaintainable code take on familiar food shapes and structures, is a menu of avoidable practices.

The most well-known on this list is spaghetti code, lasagna code, ravioli code and pizza code. Here are examples of each antipattern and how they manifest in software.

## Spaghetti Code

The phrase *spaghetti code* dates back to the 1970s as a metaphor for sloppy, unmaintainable code. Spaghetti code derives its meaning from the tangled, disconnected mess of individual strands that characterizes a bowl of spaghetti.

Every legacy codebase I've ever worked with contained bits of spaghetti code. In many cases, the codebase was that way from the start. Immediate needs determine the direction of projects in their early stages. This pressure leads developers to operate under tight timelines and limited budgets. For startup companies, it's a luxury to think far ahead, especially when you have funds to raise and customers to impress. What matters is a working product. Thus, technical proofs-of-concept long outlive their intended lifespan, and they present problems down the road.

Programmers can learn how to avoid spaghetti code with practice. Focus on the separation of concerns. Every piece of code should have a logical flow. Abstract away isolated sets of functionality to ensure each function and class does only one thing -- and does it well. And take the time to structure code. Spaghetti code often occurs as a result of short deadlines and a lack of planning.

## Lasagna Code

Carelessness isn't the only way to end up with hard-to-maintain code; over-complication can be a cause too. In 2013, I took a job at a technology company that had one of the most confusing codebases I have ever seen. Every element of the product was abstracted into dozens of singular, nested components. It was nearly impossible to make a change in one layer of the stack without affecting every other layer. The codebase wasn't a mess, but it wasn't maintainable either.

If spaghetti code suffers from architectural sloppiness, lasagna code is a characteristic of over-engineering at its most extreme. Programmers who work with object-oriented codebases often fall into this trap. Lasagna code is abstracted, tightly connected layers; developers write it as they are convinced every subcomponent necessitates its own object. These programmers tend to focus on the layout of code at the expense of its maintainability. What starts out as a highly organized codebase quickly becomes an over-architected disaster.

Here's a good rule to follow: Be conservative with your abstractions. If you plan to abstract away a component only one other component uses, which in turn only another single component uses, you've gone too far. Keep the codebase simple.

## Ravioli Code

Just like other application architecture approaches -- monolithic, service-oriented -- are neither inherently good nor bad, ravioli code is a design pattern that has the right idea, but it can get out of hand quickly.

Ravioli code is metaphor for small, self-contained classes of code, which resemble individual pieces of pasta. Ravioli code emphasizes a component-based code style and encourages the separation of concerns. This practice is a good start for readable, maintainable code, as a ravioli codebase is well-structured. Each component is isolated from external dependencies, which makes steps like testing and validation easier.

However, just like with lasagna code, there is such a thing as too much abstraction. If developers abstract away code to an extreme degree, the individualized components can drastically increase a codebase's call stack. Thus, ravioli code makes long-term maintainability difficult. So, find a balance; if code classes become particularly anemic, it's time to pull back.

## Pizza Code

Pizza isn't a type of pasta, but it does fit with spaghetti code and its ilk into the pasta theory as a programming antipattern. In most cases, pizza code is described as code with a flat architecture.

Pizza code generally has a large number of classes or functions, all interconnected at the same level on top of a foundational layer. In pizza code, the individual components are generally independent of one another, but it can sometimes be difficult to pull one off without interfering with others.

All good software requires structure. Pizza code suffers from being under-designed. It's good to have relatively isolated components, but pizza code makes it nearly impossible to understand the roles and responsibilities of each class. To get the codebase under control, cut the pizza code into slices; add some logical structure to each component.

## Other Programming Antipatterns

Developers have a tendency to go overboard with Italian food as metaphors for design patterns. You can find references to plenty of terms that fit within the parameters of the pasta theory -- or, at least, close to it. Here are a few other tasty dishes to order at a restaurant, but antipatterns to avoid as a code architecture:

- macaroni code: source files comprised of multiple programming languages;
- [stromboli code](https://twitter.com/hartsock/status/1094241842789601281?s=20): sprays from one end if you bite the other;
- [campanelle code](https://twitter.com/twostraws/status/1063844463976562690): built using a framework almost no one has heard of; and
- baklava code: similar to lasagna code, a codebase with too many architectural or abstracted layers.

Whichever metaphor you have on your plate, remember coding best practices don't last forever. The programming patterns of today can quickly become the antipatterns of tomorrow. As much as you should avoid difficult-to-maintain code, even well-designed codebases might go stale and moldy in a few years. What truly matters is you keep code fresh, easy to read and documented for maintainability.