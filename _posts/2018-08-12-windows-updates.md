---
layout: post
title: "Everything You Ever Wanted to Know About Microsoft Windows Updates"
date: 2018-08-12 07:24:00
canonical_url: https://blog.automox.com/everything-you-want-microsoft-windows-updates
category: automox
---

In the summer of 1998, Microsoft released the next version of their flagship Windows operating system, Windows 98. While Windows 98 is often remembered as the operating system that defined desktop computing for the majority of users in the late 90s, it included a particularly unique feature that changed the way Microsoft was able to release updates. Originally introduced as a web application within Windows 98, Windows Update offered some additional customization for power users that was not available within the distributed operating system. This included things like new themes, games, driver updates, and optional applications. The initial intention of Windows Update was to provide free add-ons for Windows users. Over time, however, access to beta programs, security fixes, and critical patches were included as well; such as a fix for the now-infamous Y2K bug that plagued systems of the time.

In the 20 years that Windows Update has been around, it has gone through a number of different evolutions. An early update to Windows Update was the release of the Critical Update Notification Utility, which was a recurring check that would notify users of any new critical updates that were available. While the tool did face some criticism from the security community due to its reliance on a single host to determine available patches, it was ultimately replaced in 2000 with the Automatic Updates utility. This reduced the number of checkins required to detect updates and was more respectful of the network and physical resources it utilized. It wasn't until the release of Windows Vista in 2007 that Automatic Updates was replaced with the current iteration of Windows Update, the Windows Update Agent.

## Where Do Patches Come From?

With an emphasis on usability and configuration, the Windows Update Agent provided users with the ability to manually defer updates, define appropriate update windows, and download updates from multiple locations. To better deal with bugs, the Windows Update Agent was built with recovery in mind, allowing file changes to be committed atomically and rolled back in the event of an unexpected failure. Since the release of Windows 10, the Windows Update Agent has ceased allowing users to pick and choose the patches they want to apply. Now, all updates, regardless of impact, origin, or size are downloaded and installed automatically on end-user devices in order to better protect against vulnerabilities and critical issues.

Windows Update is a great way for consumers to keep their devices up to date, but at the enterprise level all of the duplicate bandwidth and unvetted patches can introduce a lot of unnecessary risk and latency. To better address this issue, Microsoft released Windows Server Update Service (WSUS) in late 2005 alongside Windows Server 2003 R2. An enterprise-level service that allows administrators to cache distributed patches within an internal network location, WSUS gives administrators the ability to save on bandwidth and reduce the number of unnecessarily public devices while still applying critical patches. It is a great way for enterprises to safely and securely keep every device in their control patched and running. While WSUS can be difficult to manage and configure, the primary benefit is that it puts far more control in your hands when managing and releasing critical updates to your managed endpoints. Ultimately, this can make long-term administration far more manageable.

## How Do Patches Work?

Named for the literal act of using tape to patch erroneous holes in punched cards, applying operating system patches is a critical activity for maintaining good security hygiene in the age of high profile data breaches. While the act of patching is easier than ever before, thanks in no small part to the introduction of automatic updates and the ubiquity of the internet, understanding what they do and why they are important is something many end-users struggle to grasp. Like the subtle ambiguity of the "check engine" light in your car, many operating systems make it all too easy to indefinitely "remind me tomorrow" when prompted to download and apply new updates while others, like Microsoft Windows, are far less forgiving.

While our dependence on computers increases, so does the level of impact an unpatched vulnerability presents. To counter this risk, Microsoft makes an effort to release security patches directly to consumers as quickly as possible *(an aggressive tactic that no-doubt fuels the collection of memes Microsoft Update has acquired over the years)*. Unfortunately, this "treat-em and street-em" attitude doesn't work at the enterprise level. Frequently applying patches to production-level servers has an obviously negative effect on productivity and stability, so to address this Microsoft celebrates what has been unofficially dubbed "Patch Tuesday." Occurring on the second Tuesday of every month since October of 2003, Patch Tuesday applies a months worth of patches in one fell swoop allowing systems administrators to prepare ahead of time for any impact patch applications might have, and communicate it within their own organizations.

## What's in a Name?

When Microsoft distributes patches, they are often received as a collection of updates, each with varying fixes. While each update addresses its own particular set of issues, understanding the established naming conventions can determine the type of update that is applied. It is important to note that, while the following patch types make up the bulk of updates published by Microsoft, they are often distributed in one single distribution *(see Patch Tuesday above)* called a "Cumulative Update."

### Critical Update

A Critical Update is, as the name implies, a widely released update that applies a critical patch to a non-security-related bug.

### Security Update

On the flip side, a Security Update is a widely released update that applies a patch to a security-related vulnerability. In addition to the patch, all Security Updates are accompanied by a severity rating indicating how severe the vulnerability is on a scale from low to critical. In addition to the security bulletin containing the severity rating of the addressed vulnerability, every Security Update is accompanied by a Microsoft Knowledge Base article identifier to better communicate its impact. Contained in a repository of over 200,000 articles, these KBs provide in-depth explanations about what was patched, how, and any additional information that the end-user may find useful or necessary, such as any Common Vulnerability and Exposures (CVE) identifiers that the update addresses.

### Definition Update

Detecting applications and websites with malicious intent is a lot of work, which is where Definition Updates come into play. Definition Updates contain updates to a product's definition database, which is used by applications like Windows Defender to detect and identify malicious code, junk email, or dangerous websites.

### Feature Update

Released approximately twice a year, Feature Updates are major releases that drastically improve the usability and functionality of the operating system.

## Patch Caveats

It is important to remember that, in spite of the different naming conventions, not all patches are created equal. Each patch has its own set of requirements and limitations that determines how and when it can be installed. This can come in the form of semi-permanent patches, or patches that must be applied in isolation of other patches to reduce their impact.

### 'Ununinstallable' Patches

In addition to different naming conventions, the behavior of each update can differ wildly. As an example, not every patch can be _[uninstalled](https://docs.microsoft.com/en-us/windows/desktop/msi/uninstallable-patches)_. While this may seem like a trivial detail, having a proper rollback strategy in the event of a critical failure can save a lot of headaches in the long run. Unfortunately, whether or not a patch is uninstallable depends entirely on the version of Windows the patch is being applied to, how the patch was created, and the specific changes the patch applies.

When a non-uninstallable — ununinstallable?— patch is encountered, the only way to roll it back is to uninstall the underlying application it affects and re-install without the offending patch. This is obviously not ideal, so taking proper backups and preparing a rollback strategy to deal with these particular instances can ensure that even the most stubborn patches can be removed, just in case.

### Patch Impact

While Security Updates are accompanied with a security bulletin outlining the impact the targeted vulnerability might have, each update also has its own rating identifying the level of [impact](https://docs.microsoft.com/en-us/windows/desktop/api/wuapi/ne-wuapi-taginstallationimpact) the patch can cause upon application. Separated out into two potential levels, minor and normal, the patch impact can often be accompanied by an exclusive handling lock. This prevents the update from being applied alongside any other update. In general, Windows Update coordinates the specifics of these updates on its own. However, when using the Windows Update Agent API it is important to understand how each patch interacts with the others and balance their application accordingly.

## What's Next?

With 20 years of active development, Microsoft Windows Updates have a storied and dynamic past, but Windows is far from the only operating system in the... sea? Apple's Mac OS and every flavor of Linux have their own methods, processes, and limitations for distributing and applying updates. In the next article of this series, we will be digging into how non-Windows-based operating systems deal with patching, and the path they took to get there.