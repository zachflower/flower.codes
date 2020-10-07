---
layout: post
title: My Two Favorite Git Aliases
date: 2013-04-28 12:00:00
permalink: my-two-favorite-git-aliases
---
I’m a big fan of Git. It is a super easy-to-use version control and source code management system. Before I came to Git, though, I used Mercurial, and there were two commands that I missed. Through a lot of Googling, I came across two Git aliases that have changed everything for me: `incoming` and `outgoing`.

## Usage

### `incoming`

**Command: `git incoming`**

The Incoming command will return a nicely formatted list of incoming commits, the next time you do a pull.

```
$ git incoming
621d0eb - Developer Name - (origin/master, origin/HEAD) Commit Message - 2 days ago
31d6367 - Developer Name - CommitMessage - 2 days ago
```

### `outgoing`

**Command: `git outgoing`**

The Outgoing command will return a nicely formatted list of outgoing commits, the next time you do a push.

```
$ git outgoing
9a0af47 - Developer Name - (HEAD, master) Update message - 5 seconds ago
b903948 - Developer Name - Update message - 6 minutes ago
```

## Setup

To add the aliases, put the following in your `.gitconfig` file (typically located in your home directory):

```
[alias]
incoming = !(git fetch --quiet && git log --pretty=format:'%C(yellow)%h %C(white)- %C(red)%an %C(white)- %C(cyan)%d%Creset %s %C(white)- %ar%Creset' ..$(git rev-parse –abbrev-ref –symbolic-full-name @{u}))
outgoing = !(git fetch --quiet && git log --pretty=format:'%C(yellow)%h %C(white)- %C(red)%an %C(white)- %C(cyan)%d%Creset %s %C(white)- %ar%Creset' $(git rev-parse –abbrev-ref –symbolic-full-name @{u})..)
```