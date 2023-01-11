---
layout: post
title: "Putting the “Code” in Configuration Management"
date: 2019-01-24 07:24:00
canonical_url: https://blog.automox.com/infrastructure-as-code-putting-the-code-in-configuration-management
source: automox
---

Let’s face it, when it comes to endpoint management, automation is king. In our hyper-connected, ultra-virtualized, cloud-based world, there is no shortage of machines that we have access to and no limitation to the amount of infrastructure we can manage. But with new scale comes new challenges, and configuration management is one of the first ones many organizations encounter.

How do we ensure that every new machine we bring online *stays* online?

And if something needs to change, how do we synthesize that update across twelve-hundred machines?

Sure, a little scripting here and there can get the job done, but it’s hardly a scalable (or stable) solution.

While there is no shortage of ways to remotely manage the configuration of the endpoints in your domain, the introduction of cross-platform requirements and hardware mismatches will nearly always introduce inconsistencies and workarounds. What works on Machine A might not work on Machine B, and who the hell knows what’s going on with Machine C… it’s a nightmare even the most organized and disciplined of engineers would buckle under, and even at a scale of a dozen or fewer computers can drain hours from your day.

## Building a Configuration Engine

In 1993, a budding—and award winning—theoretical physicist by the name of Mark Burgess launched what is widely considered to be one of the first (or, at least, the first successful) software configuration management systems of our time. Like all great programs, CFEngine was built to solve a very real problem that Burgess was dealing with every day—trying to manage a small group of workstations in the Department of Theoretical Physics at the University of Oslo in Norway.

Like most of us, Mark Burgess initially managed the machines through scripting and manual intervention. Unfortunately, due to the differences found across the various Linux flavors in play, the scripts being used grew well beyond a reasonable level of maintainability, which ultimately necessitated a better, more time-efficient solution.

As CFEngine adoption began to gain traction, Burgess shifted his focus from theoretical physics to computer science and began researching ways to apply the principles of scientific modeling to understanding computer systems. Five years after its initial release, CFEngine was rewritten to better represent a manifesto for creating self-healing systems that Burgess write at the USENIX/LISA98 conference.

Looking back on it now, it was a *really* big deal.

## Managing Configurations Like a Coder

While it revolutionized how we, as engineers, think of configuration management as a process, CFEngine’s most impactful contribution to the field (as I see it) is as an early representation of Infrastructure-as-Code (IaC). Popularized by the Infrastructure-as-a-Service (IaaS) revolution—seriously, who do I blame for all of these initialisms?—Infrastructure-as-Code is a foundational pillar of the DevOps methodology of software development. Intended as a way to manage endpoint configurations using the same philosophies that drive the software development, Infrastructure-as-Code relies heavily on machine-readable definition files, rather than physical hardware or interactive tools.

Now, putting aside its early revolutions, it’s important to mention that CFEngine is hardly the only Infrastructure-as-Code driven software configuration management solution on the market today. Ansible, Puppet, Chef, Terraform… the number of solutions to choose from can easily feel overwhelming, but their ultimate goal is the same: to provide a reliable, code-driven way to manage your infrastructure.

## Code is Code is Code

Code, in practice, is testable, trackable, and—most importantly—undoable. In the context of Infrastructure-as-Code, when paired with a version control system every change can be associated with a given person and time, and in case something goes wrong the rollback strategy is as simple as checking out the configuration at a previous point in time. This allows for a tightly-controlled environment where changes can be tested, audited, and reviewed in a consistent and predictable way, without ever having to worry that someone will accidentally “click the wrong button.”

As an example, if a change to the configuration of a set of devices is required in an IaC-managed environment, this change would ideally be written into a text-based definition file by an individual engineer and submitted to a central source code repository. Once there, the change could be reviewed by other engineers and tested using automated tools for consistency and reliability. Once approved, the change can be merged (or included) into the production codebase, which would ultimately then be rolled out to the target servers.

This workflow allows for small, incremental changes to your infrastructure while ensuring that those changes are tested, verified, and audit-able at every step of the process.

Beyond management, however, one of the long-term benefits of thinking of infrastructure management as any other software development process is the disbursement of knowledge. Where proprietary tools require specialized training and expertise to prevent mistakes, a code-driven solution can be more easily picked up by engineers of all backgrounds and skillsets. Now, when a developer needs to propose infrastructure changes to facilitate a feature they are working on, they can follow the same process they would with any other software project and receive immediate feedback that can further their understanding of how infrastructure is managed at their organization.

It’s a positive feedback loop that helps reduce knowledge silos and improve the expertise of every engineer on staff.

## It’s About the Destination, Not the Journey

One of the biggest advantages of IaC as a configuration management practice is its inherent reliability, and this reliability is achieved through the philosophy of declarative management. Scripting, as a simple comparison, involves pushing changes out to the target endpoints being managed, but where it falls short is understanding the current state of those endpoints. Infrastructure-as-Code, on the other hand, focuses instead on what the target machines should look like.

By knowing what software should be installed or what ports should be opened or how any other number of settings should be configured on a given machine, IaC tools are able to identify the changes that are necessary to achieve the desired state on a flexible, per-machine basis. This means that, instead of scripting a solution for every machine and hoping that they don’t get out of sync, an engineer can *define* what every machine should look like in a perfect world, and allow the systems to catch up to that ideal on their own.

It’s a very hands-off approach that ensures that, even if changes are introduced by hand at a later date, everything will eventually settle back to its desired state.