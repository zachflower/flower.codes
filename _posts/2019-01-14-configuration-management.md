---
layout: post
title: "The Life and Times of Configuration Management: A Brief History"
date: 2019-01-14 07:24:00
permalink: the-life-and-times-of-configuration-management-a-brief-history/
canonical_url: https://blog.automox.com/the-life-and-times-of-configuration-management-a-brief-history
category: automox
---

In 2001, the Department of Defense published [MIL-HDBK-61A(SE)](http://www.acqnotes.com/Attachments/MIL-HDBK-61A%20(SE)Configuration%20Management%20Guidance.pdf), a 221-page military handbook offering guidance on the practice of configuration management to all military departments and agencies. While MIL-HDBK-61A(SE) is the government’s most recent contribution to the practice of configuration management, the Department of Defense itself has a long history of expertise in the field, having originated the concept in the 1950s as a technical management discipline for hardware components—as opposed to the software-based discipline it is most commonly associated with today.

## From Military to Modernity

Throughout the 1960s and 1970s, the Department of Defense went on to publish a series of military standards—known as the “480 series”—that outlined the uniform engineering and technical requirements for the then-military-specific discipline of Configuration Management. Over the next two decades, this series of standards would be consolidated into a single, all-encompassing standard known as MIL-STD-973, which was itself ultimately replaced by MIL-HDBK-61—the first iteration of the current military handbook.

This change, from a “standard” to a “handbook,” is marked by a Department of Defense goal of reducing the number of military-specific standards in favor of more widely-supported industry standards developed by non-military organizations. It was the beginnings of the ANSI/EIA-649 National Consensus Standard for Configuration Management (try saying that ten times fast).

The most widely accepted standard on configuration management today, ANSI/EIA-649 is a civilian standard that addresses the industry-agnostic best practices of configuration management without dictating any specific terminology or approaches to configuration management in any particular environment. Over the years, this holistic approach to configuration management has been expanded upon by a number of different organizations to provide technical guidance in the practice of configuration management at an industry-specific level.

## Configuration Management for Dummies

But, as fascinating as this biblical evolution of standards documentation is (MIL-STD-480 begat MIL-STD-973 who begat MIL-HDBK-61 who then begat ANSI/EIA-649, blah, blah, blah), you might be wondering just what in the hell “configuration management” actually *is*, am I right?

Configuration management, as defined in MIL-HDBK-61A(SE), is “a process for establishing and maintaining consistency of a product’s performance, functional and physical attributes with its requirements, design and operational information throughout its life,” and—at its core—is a critical piece of the cyber hygiene puzzle. More clearly defined as the practice of handling changes systematically, configuration management ensures that a given system maintains its integrity over time.

From both MIL-HDBK-61A(SE) and ANSI/EIA-649, the configuration management process is broken down into five distinct disciplines that can be implemented as policies and procedures to shepherd changes through any system while also establishing a standard baseline with which to build upon.

### Planning and Management

At its inception, a configuration management program must be driven by a documented plan of action. This formal document should provide direction for everything from personnel needs and responsibilities to naming conventions; even things like baseline measurements and audit and review processes should be covered. The purpose of configuration management is to ensure system integrity over time, so the more detail that is put into this phase the more resistant to unplanned change the process is.

### Configuration Identification

The Configuration Identification discipline is responsible for defining the baseline configuration of the system at any point in time. It is from this practice that changes to the system can be identified and documented throughout its lifecycle.

### Configuration Control

When a change request is received, the Configuration Control discipline evaluates and responds to the provided proposals with a subsequent approval or disapproval. By maintaining the process with which changes to a system’s design, implementation, or even documentation are applied, this process can ensure that the integrity of the system is properly maintained without inadvertent or unapproved changes.

### Configuration Status

After a change has been approved, the Configuration Status discipline is responsible for documenting the incremental changes from the original baseline. This process is crucial towards the safe rollback of any changes when problems arise.

### Configuration Verification and Audit

Before a configuration baseline can be updated, any applied configurations must be verified and audited independently to ensure that the change complies with the functional and physical characteristics of the system prior to its application. Once approved, a new baseline is established and the process can begin again.

## Software Configuration Management

In a standard IT environment, the practice of configuration management is often represented by a software-based approach towards ensuring that the configuration of each device on the network is consistent, reliable, and maintainable. A sub-discipline of configuration management, Software Configuration Management (SCM) is a process that aims to track and control system changes in a software-level environment.

In some instances, SCM is used to manage the integrity and traceability of a product throughout the software development lifecycle. However, in a typical IT environment, SCM is more-often associated with maintaining the configuration of operating systems and the software that runs on them. While the five disciplines outlined above can be found in one form or another, much of the manual work that drives the process is now managed by automated configuration management systems that can apply, remove, or reset configuration changes across an entire network in a fraction of the time it would take to do by hand.

## Infrastructure-as-What?

These automated configuration management systems are often driven by a process called Infrastructure-as-Code (IaC). IaC is the practice of managing network devices through the use of machine-readable definition files, often in a proprietary programming language, rather than through manual or interactive configuration tools. While not every software configuration management tool is managed through Infrastructure-as-Code, it is becoming a favorite amongst administrators of large networks for its flexibility, speed, and risk mitigation.

By treating configuration management as a software-development discipline, individual changes to any device can be tracked at the source-code level, allowing for much more fine-grained auditing and analysis of changes as they flow through the system. For example, when an IaC definition file is changed, that change can be tracked in a version control system to help identify when a given change happens, and who is responsible for it. To take it even further, source code is inherently testable, which means that changes can be audited programmatically prior to their release, allowing for a more fault-tolerant and defect-resistant system.

## Configuration Management, DevOps, and You

As enterprise networks have started to move to the cloud, the way in which companies manage the configuration of their endpoints has changed. Moving away from bare-metal resources means more virtualization, which in turn means more endpoints at a lower cost. While a practice like IaC can help streamline the configuration management process, it is also a core component in the DevOps toolchain.

By allowing for source-code-driven configuration management, stakeholders can become more involved in endpoint management much earlier in the process, allowing for a more iterative approach to managing device configurations. In the next article of this series, we will take a deep dive into some of the open source tools systems administrators and DevOps engineers alike rely on to automate their configuration management.