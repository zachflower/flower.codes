---
layout: post
title: Leveraging AWS Spot Instances for Continuous Integration
date: 2015-10-22 12:00:00
canonical_url: https://www.sumologic.com/blog/aws-continuous-integration/
source: sumologic
---
Automated Continuous Integration (CI), at a high level, is a development process in which changes submitted to a central version control repository by developers are automatically built and run through a test suite. As builds and tests succeed or fail, the development team is then aware of the state of the codebase at a much more granular level, providing more confidence in deployments. While CI is often used primarily on production-ready branches, many implementations run builds and tests on all branches of a version control system, giving developers and managers a high level view of the status of each project in development. The trouble with automated CI is that it typically requires an always-on server or an expensive SaaS product in order to run builds and tests at any given time. In a large development team, this can be prohibitively expensive as a large backlog of commits would require more resources to test in a reasonable amount of time.

A way that organizations can save money is by utilizing Amazon Web Services (AWS) EC2 On-Demand Instances. These instances let you pay by the hour with no long-term commitments. You just spin up an instance when you need one, and shut it down when you’re done. This is incredibly useful, as in the times between builds, you aren’t paying for servers, and conversely, your CI environment can scale to the needs of your team as the need for testing builds increases. While more volatile, AWS Spot Instances are even more cost effective than On-Demand instances. Spot Instances are spare On-Demand instances Amazon auctions off at up to 90% off the regular price that run as long as your bid exceeds the current Spot Price, which fluctuates based on supply and demand. The trouble with Spot Instances is that they can disappear at any point, so applications running on them need to be able to appropriately handle this unpredictability. This requirement puts us at a bit of a disadvantage when configuring a CI server, as it will need to be capable of going down in an instant without throwing false failure negatives.

Sample Reference Architecture (Source: aws.amazon.com)

Finding a CI server that can safely handle the volatility of AWS Spot Instances can be tough, and configuration and maintenance is a bit more difficult as well, but luckily [Jenkins](https://jenkins-ci.org/), one of the most popular open source CI servers, has an extensive plugin library that provides extended support for most use cases; including Amazon EC2 support. The [Amazon EC2 Jenkins plugin](https://wiki.jenkins-ci.org/display/JENKINS/Amazon+EC2+Plugin) is a plugin that is in active development that gives Jenkins the ability to start slaves on EC2 on demand. This allows you to run a lower powered Jenkins server, and spin up slaves for more resources as they are needed. The EC2 plugin also provides great Spot Instance support, giving you the ability to configure persistent bid prices and monitor slaves more accurately. In the event a Spot slave is terminated, a build will be marked as failed, but the error messaging will reflect the reason appropriately.

While the barrier to entry of configuring your CI environment to utilize AWS Spot Instances can be high, the possible savings can be even bigger. SaaS products are often a great way to offload the time and expertise needed to manage services like this, but CI services can be unnecessarily expensive. The same can be said for always-on servers in large organizations with a backlog commits that need to be built and tested. Spot Instances are a great way to dynamically allocate only the resources that an organization needs when they need them, while at the same time reducing operating costs and build wait times.