---
layout: post
title: "WTF is a Postmortem?"
date: 2021-12-11 08:47:03
---

A postmortem is the analysis of an event after it occurs. When an issue is encountered in a production environment, a postmortem is an important process that lets us reflect on and learn from our mistakes so we can improve our process and prevent them from happening again in the future. It is not an opportunity to assign blame or point fingers. When something goes wrong, it is nearly always due to an underlying, systemic problem, rather than the deliberate actions of any one individual.

## Who Can Call a Postmortem?

In a failure-tolerant environment, anyone  can call a postmortem. Generally speaking, though, the best person to call a postmortem is someone who is aware of a problem but not directly involved in its resolution. This makes it easier to facilitate an unbiased process and ensures that the root causes and underlying solutions can be properly identified.

## When to Call a Postmortem

A postmortem should be called whenever a critical problem is encountered in a production environment. This could be anything from a bug to a process failure. The more likely it is that a problem will occur again, the more important it is to call a postmortem while there is still an opportunity to adapt and iterate. If, for whatever reason, an issue is unlikely to happen again, then calling a postmortem can be done at the discretion of the stakeholders.

## Anatomy of a Successful Postmortem

What does a successful postmortem look like? In general, a successful postmortem can be broken up into six phases: assembling the team, gathering the facts, identifying the high-level root causes, identifying the true root causes, taking action, and closing the loop.

### Assemble the Team

The first step towards executing a successful postmortem is assembling the team and blocking off an hour or two on the calendar (as needed) to discuss and reflect. At a high level, "the team" should include anyone that was directly or indirectly involved in the underlying issue; engineering, sales, support, etc. Anyone that helped plan, design, build, deploy, triage, or mitigate the issue should be included, as they all have relevant knowledge that can help identify the underlying causes.

### Gather the Facts

Once the team is assembled, the next phase is to start gathering the facts. Focus on what happened, when it happened, and what was done to mitigate the problem (or problems). By identifying the timeline and clearly outlining what went wrong (and how the team reacted), we will have a common framework with which to start from.

To be clear, fact gathering should be devoid of opinion. All that matters is what happened without any color or caveats. Additionally, this is the only section where any individual person's name should be mentioned, and only insofar as it provides context (e.g. "At 10:53 AM, an alarm indicated that network connectivity was down in the lab. Joe Smith rebooted the network switch, restoring connectivity.").

### Identify the High-Level Causes

With a detailed timeline in place and all the information we can gather, it's time to start identifying the high-level causes of the issue. This isn't a detailed analysis, but a general identification of where the first problem was introduced. For example, if a software bug was released that triggered the problem at hand, then the bug itself would be the high-level cause. Keep in mind that, depending on the incident, there may be more than one high-level cause.

### Dig Deeper

Once the high-level causes are identified, it's time to start the real work. While a software bug may have been the initial cause, it isn't the underlying cause. Why did the bug happen in the first place? Why wasn't it caught in test? Why did it happen when it happened? Questions like these are what allow us to identify the true root cause to a problem.

A useful exercise here is the "[5 Whys Process](https://buffer.com/resources/5-whys-process/)," which (as the name implies) involves asking the question "why?" for each successive root cause until we've asked it five times in a row. If we are honest in our answers, then the chances are good that the response to the final "why?" is the true root cause of the problem, and the place where we should focus our problem-solving energy. To illustrate, here's an example of the "5 whys" in practice from the article above:

> 1. Why did the application go down?
>     - Because the database became locked.
> 1. Why did the database become locked?
>     - Because there were too many database writes.
> 1. Why were we doing so many database writes?
>     - Because this risk was not foreseen, and as such as not load tested.
> 1. Why wasn't the change load tested?
>     - Because we do not have a development process set up for when we should load test changes.
> 1. Why don't we have a development process set up for when to load test?
>     - We are hitting new levels of scale, so have not had to load test before.

### Take Action

Once we've identified our true root cause (or root causes) it's time to take action and assign the action to a specific person. Assignment is a critical step, because if nobody owns an action then it will not get done. In this context, "action" is defined in two distinct, but important ways: corrective actions, and preventative actions.

### Corrective Actions

Corrective actions are the implementation of solutions believed to eliminate the root cause of an observed problem, defect, or failure. In our database example above, a corrective action would be to implement a load test to address the specific behavior that caused the problem.

### Preventative Actions

Preventative actions are the implementation of a solutions believe to prevent similar problems from happening in other processes and products. In our database example, a preventative action would be to invest more time in educating the team about high-scale environments, and ensuring that all features get screened for potential scale issues moving forward.

### Close the Loop

Once action items have been assigned, a follow up meeting should be scheduled to close the loop. Whether it is two weeks or two months later, the team should get back together, review the action items, and reflect on whether or not they were valuable. This is an opportunity to hold ourselves accountable and ensure that we're truly working to improve our underlying processes. Walking the walk, and not just talking the talk.

