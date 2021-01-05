---
layout: post
title: "Soft(where): Where Does Software Come From?"
date: 2018-11-23 07:24:00
permalink: where-does-software-come-from/
canonical_url: https://blog.automox.com/softwhere-where-does-software-come-from
category: automox
---

"If I have seen further it is by standing on the shoulders of Giants."

Most commonly attributed to Isaac Newton in 1675—who himself was paraphrasing a 12th-century parable—this quote has always resonated deeply with me as a programmer. An objectively new field of study by any standard, the practice of software development has undergone rapid evolutions since the first electronically stored program was created 70 years ago. While the software of today only superficially resembles the software of yesteryear, it wouldn't be at all possible if it weren't for the giants that laid the foundation before us.

## The Bytes and the Bits

A term coined by John Wilder Tukey in 1958, "software" is a collection of instructions that tell a computer how to work—in contrast to "hardware," or the physical materials with which the computer is built. While an argument can be made that software existed (at least in spirit) prior to the invention of digital storage mechanisms, I am a firm believer that its intangibility is precisely what makes it "soft"—and why the process in which software is designed, developed, and deployed has taken the better part of half-a-century to perfect.

## The Software Development Lifecycle

In 1948, a computer science researcher by the name of Tom Kilburn created the world's first piece of software at the University of Manchester. A simple program, it was originally created as a practical demonstration of a permanent digital storage technology he had created one year prior. While this small proof-of-concept ultimately earned Kilburn his Ph.D., it signaled a shift in how computers would be programmed in the future. Doing away with punched tape and plugboards is a key moment in the evolution of computing, providing an avenue for distributing better and more complex programs to consumers.

But while the creation of software and the information systems it powered grew in strength and complexity, it wasn't until the 1960's that an attempt to establish a formal process truly reached the mainstream. The Systems Development Life Cycle (SDLC), as this process has become known, is a cyclical product development process that outlines a path with which the development of information systems should follow, from planning all the way through implementation and into maintenance.

### Planning

Despite the limited resources required for the vast majority of modern software development, the time invested can still make it a costly endeavor. Before putting pen to paper—or code to screen, to be more accurate—understanding the problem which you are trying to solve is critical. When it comes to software development, there is rarely one right answer to any given problem, so identifying a number of potential solutions and weighing their merits against the goals of the business is an important step towards creating quality software.

### Analysis

Once the initial planning is completed, is then important to understand the full scope of the proposed solution. This can come in the form of collecting facts—documentation, client interviews, observations, and questionnaires—and scrutinizing the existing system. Every solution has its pros and cons, so aligning the pros of the proposed system with the cons of the existing system can help ensure a cost-effective solution.

### Design

After the planning and analysis of the proposed solution in the context of the existing system and the needs of the business, the true technical preparation can begin. At this point, the destination will be well defined, but the path towards it likely won't be. Beyond simply identifying the solution to individual business goals, additional stakeholders are generally brought in to describe the new features and operations in detail. This is an involved step that can result in the creation of screen layouts, process diagrams, documentation, and even some pseudocode.

### Implementation

When most people think about "software development," this is generally the phase that comes to mind. Development, testing, and release management are all rolled into the Implementation stage of the SDLC. This is where the application as defined in the Design phase is created, the performance, quality, and accuracy of the implementation is verified, and the application itself is released into a production environment.

### Maintenance

Every system ages, and as they age things become obsolete and new features become necessary. The SDLC is called a "life cycle" because it is just that: a cycle of life. While the maintenance phase can sometimes be treated as the digital manifestation of hospice care, more often than not the necessary changes discovered in this phase start the cycle all over, with each new feature entering into its own planning phase and working its way through the phases in its own time.

## Becoming Agile

One of the biggest criticisms of the standard SDLC is its lack of flexibility. While it is often represented as a big circle, in practice each phase often refers to its predecessors fairly frequently. The reason for this discrepancy in the theory versus the reality is that the consequences of changing software requirements are significantly less drastic than other industries. When a bridge is finished being built, for example, it is a little more costly to go back to the drawing board, but with software the risk and cost can be almost negligible, especially in light of the ease with which software changes can be released thanks to their low footprint and the accessibility of the internet.

In recent years, this traditional "waterfall" development methodology has given way to a new process called "agile." Unlike waterfall, where an entire product is delivered all at once after following a strict SDLC process over the course of months to years, agile encourages rapid delivery and continual improvement. The flexibility of agile development has become a favorite amongst engineering organizations as it allows applications to evolve over time and provides value nearly immediately.

## Engineering for Quality

Regardless of an organization's software development methodology, it's no secret that software is inherently risky. After all, even Microsoft and Apple make mistakes, so what's to stop organizations with fewer resources from letting a defect go through from time to time?

Why do bad bugs happen to good software?

When it comes to consumerism, we have a right to expect that the products we use work as advertised. But technology, and software in particular, is a highly complex field with near endless infinite moving parts. Even the most careful engineers with the best of intentions can struggle to claim 100% confidence in the stability of any piece of software they release, and that's because even perfect code can be derailed by the systems with which it relies upon.

But just because it is difficult to create bug-resistant software, that doesn't mean we will not try. While creating software is easy, creating good software that your users can trust is much more complicated. It requires encouraging a culture of quality at an organizational level and engendering empathy and attention to detail within every producer.

### Reviewing Code

No product should be created in a vacuum. Software developers are human after all, and "human error" is a phrase that exists for a reason; "human error" is unavoidable. The code review is a process many organizations follow to ensure that the logic and implementation details of any new code that is written for a piece of software is verified by a developer's peers. This prevents siloed knowledge about different parts of a product and encourages best practices within an organization.

### Programming in Pairs

In addition to code reviews, many organizations have adopted the pair programming model of software development. Rather than assigning a task to each developer to work through on their own, organizations that implement pair programming assign a task to a pair of developers, that work together to complete it. This practice has the same benefits of code reviews, but in a much shorter timespan.

### Automating Testing

In addition to verifying software at the code level, it is critical to actually test it as well. Historically, software was tested manually, with quality assurance teams clicking buttons and turning dials in order to verify that the product does exactly what it's supposed to do, but thanks to more relatively recent advancements in automation and testing best practices, much of these manual testing processes have been replaced with scripts that can perform the same tasks in 1/100th of the time.

From unit tests, that test individual units of code, to integration tests, that test the entire application from one end to another, automated testing has become a favorite of developers for not only ensuring quality but also reducing the number of defects that ultimately make it into a production environment. In more recent years, "shift left" testing has shifted the test phase from an application's pre-release stage onto its development environment. By testing early and often, the cycle time between the discovery of a bug to its remediation is becoming increasingly small.

## The Circle of Life

While the creation and deployment of quality software is a deliberate act, built upon decades of learning and experience, it doesn't all last forever. In the next article of this series, we will take a look at what happens when software is no longer maintained, and how you can identify and mitigate the risks associated with deprecations.