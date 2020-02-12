---
layout: post
title: "Establishing a Documentation Strategy"
subtitle: "A Template"
date: 2020-02-12 12:00:00
categories: [writing]
---

Prioritizing documentation can be a struggle at any organization but, in my personal experience, a well-crafted documentation strategy can make that struggle seem far less real. Included below is a template I have personally used to propose and promote good documentation standards in the past. While it is far from an all-encompassing strategy, it has done a good job of outlining the challenges and goals of documentation in relationship to the business, and identifies strategies to address them.

---

The purpose of this document is to establish a strategy for creating and maintaining product documentation on an ongoing basis. The primary driver here is to ensure accurate and usable documentation for our customer-facing tooling, such as our API and mobile and web applications.

## Unanswered Questions

Before addressing goals and strategies for generating documentation, there are a few unanswered questions that should be kept in mind when designing a documentation strategy:

- How can we create useful documentation that users will actually *read*?
- How can we seamlessly integrate content creation into our existing software delivery process?
- How can we engage our community to contribute to documentation?

## Documentation Goals

The quality and effectiveness of all documentation, regardless of the product or target audience, can be measured against three traits: readability, accuracy, and discoverability. While these traits are often used to determine documentation *quality*, they can also be used to establish goals for creating a documentation strategy.

### Readability

As the name implies, readability is how "readable" a set of documentation is. While prose is an important factor in documentation, readability largely considers *who* the documentation is targeted towards and *how* the it is written.

#### Personas

As with product development, determining who a set of documentation is intended to be consumed by can greatly influence how that documentation is created. Establishing one or more reader personas will define how technical and detailed the documentation should be. It is important to note here that the user personas established for marketing campaigns and usability plans might not necessarily be the same personas used for documentation purposes, as the "buyer" isn't always the same person as the "user."

#### Keep It Simple, Stupid

When writing something—whether it is documentation or something else entirely—the best advice I've ever received is to always assume that your reader is lazy, stupid, and mean. In a nutshell, what this means is that you should always write for your most difficult reader, not your most agreeable one. Lazy readers don't want to sift through a ton of text to get to the answer, stupid readers have a hard time understanding big words, and mean readers always take ambiguous wording the *wrong* way. Getting to the point, using common language, and avoiding ambiguity can drastically improve the readability of any document.

#### Descriptive vs. Task-Based Information

Documentation is typically split between two different types of information: descriptive and task-based. Descriptive information, as the name implies, describes what something *is*. It is often written with a passive voice and used to provide context around a component or topic. On the flip side, task-based information describes *how* to do something. It is typically written in an *active* voice and directs the reader to perform one or more actions. Both of these types of information are necessary within any piece of documentation, however to improve readability it is generally recommended to split them into two distinct sections.

### Accuracy

Inaccurate documentation is beyond useless. Not only does it *not* provide any useful information, it wastes time, sends users down the *wrong* path, and breaks any semblance of trust that may have been established with them. In addition to making sure that documentation is readable, verifying its accuracy is just as—if not more—important.

#### Technical Review

In order to ensure accurate documentation, a series of technical reviews with the original feature developer should be performed throughout the process. The first review should happen prior to any documentation being written, providing the writer with an opportunity to understand the necessary information before putting pen to paper. After the initial draft is written, a second review should be performed to verify the accuracy of the written piece. This ensures that documentation is written from the perspective of a new user, while giving stakeholders an opportunity to correct any misunderstandings or wrong assumptions prior to publishing.

### Discoverability

The third, and final trait of high quality documentation is discoverability. When it comes to documentation, it doesn't matter how accurate or readable something is if the user can't find the information they are looking for. This can be accomplished in several ways, each of which focus on a different facet of discoverability.

#### Information Architecture

Establishing an intuitive and "browseable" information architecture is key to making documentation discoverable. Making an effort here is the minimum effort required to enabling readers to find the information they need about a given feature. A simple way of accomplishing this is to establish a set of topic-based hierarchies to categorize documentation under: `Dashboard > Account > Account Details`

#### Usability

In addition to establishing an information architecture to better organize documentation, it is important to put some focus on usability. Usability, in the context of documentation, means structuring single-page documentation with ease-of-use in mind. Little things like syntax highlighting in code snippets, descriptive animated GIFs, and a "Related Topics" section can go a long way towards making documentation easier to read and parse.

#### Search

Finally, when all else fails, indexing documentation and providing a mechanism to search it can make up for any failings in the other two categories. Search is, quite literally, the most common definition of "discoverability."

## Types of Documentation

While "documentation" is often taken to mean "user manual," there are actually many different *types* of documentation that can—and should—be generated. Below is an outline of the types that are most relevant to our organization.

### Release Notes

Release notes convey, in a nutshell, what has changed in an application from day to day. These are generally bulleted lists of small blurbs, with links out to additional information (where applicable).

### Reference Guides

Reference guides—also known as user manuals—are the "FM" in "RTFM." They are comprehensive manuals that outline every feature, button, and screen in a product. Often written in an impersonal voice, reference guides are intended to provide information in the form of (typically dry) definitions, examples, and explanations.

### Knowledge Base Articles

Where reference guides provide information about how a product works, knowledge base articles provide cut-and-paste solutions to common problems. They should promote best practices and have a more-than-usual eye for accuracy, as users should be expected to follow them word for word. Knowledge base articles should be treated like recipes and focus on *how* to accomplish something, not *why* the solution works. To quote Red Hat's [Rich Bowen](https://opensource.com/business/15/5/write-better-docs):

> When you assemble your new Ikea desk, you don't care *why* a particular screw size was selected, you just want the instructions, and you expect them to work.

### Tutorials

The happy middle-ground between reference guides and knowledge base articles are tutorials. They take a little bit of the *how* in knowledge base articles and combine it with the *what* and *why* from the reference guides to craft small, user-friendly pieces of content aimed at empowering the readers with the skills and tools necessary to become a power user. They should be written using a personal voice in a very conversational tone, and guide the reader down a path from question to answer (with a few pit stops along the way to impart technical wisdom).

## Strategies and Solutions

While the details outlined above draw a clear picture of what the problems are surrounding documentation and philosophies to solve them, they do not offer concrete solutions. To help kickstart a conversation around our own documentation plan, I've outlined some common strategies and solutions below.

### Versioning

When it comes to documentation versioning, there are two camps: delete vs deprecate. Microsoft, for example, falls squarely under the "deprecate" camp, as they maintain backwards compatibility beyond reason and find it more valuable to users to retain legacy documentation that is no longer valid or accurate. Deletion, on the other hand, is the more common solution, with outdated documentation being updated or deleted as required. Personally, I am a fan of deletion, because as a SaaS product, there is little reason outdated documentation will provide any value to our users.

### Quality Assurance

Technical reviews are necessary for validating the accuracy of documentation at the time of publishing, but what they do not cover is documentation that becomes stale over time. In order to maintain the accuracy of documentation, regardless of publish date, it would be valuable to schedule periodic quality assurance reviews. In addition, all new documentation should include a "related documentation" audit to ensure that any new information does not supersede or contradict what has already been published.

### Feedback

Just like any other product, gathering user feedback is crucial to ensuring it is providing maximum value. While gathering feedback on documentation can be done using any number of CRM tools, I personally think this makes a good case for open sourcing documentation. Because documentation is inherently public, open sourcing it offers little to no risk with potentially huge rewards. Contributors can be empowered identify and fix inaccurate documentation, while at the same time be given a voice in our documentation strategy. Additionally, this allows us to start building a community, and potentially identify future technical writers as our product offering continues to grow.

### Usability

Usability is more than just making sure documentation is intuitive and clean. It means establishing and adhering to a style guide, and putting an effort towards design. Much like software development, documentation that is written in the same voice and follows the same grammar rules is significantly more understandable than the alternative. Creating this style guide should be a team effort across stakeholders, however this guide by [Write the Docs](http://www.writethedocs.org/guide/writing/style-guides/) lists some excellent examples that can be pulled from.

### Publishing

The biggest question in documentation is: "how and where do we publish it?" There are a multitude of tools to create both hosted and printed documentation, from [GitBook](https://www.gitbook.com/) to [GitHub Pages](https://blog.github.com/2016-08-22-publish-your-project-documentation-with-github-pages/), however the *right* solution is the one that makes the most sense for the established documentation strategy (for reference, my personal favorite solution is GitBook, as it is markdown-based, version controlled, mobile friendly, searchable, and built for teams). Whatever solution we choose, I recommend one that requires little to no intervention from the engineering team to publish, as that only introduces a bottleneck and can hold up the documentation process as priorities shift.
