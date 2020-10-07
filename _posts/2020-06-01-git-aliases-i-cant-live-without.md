---
layout: post
title: "5 Git Aliases I Can’t Live Without"
date: 2020-06-01 12:00:00
permalink: an-introduction-to-vagrant-aliases-2
---
I’m a _huge_ fan of shortcuts.

Aliases,  hacks, scripts, automations, workarounds… I love unnecessary  optimization, so it should come as no surprise that I’m particularly  fond of the alias functionality in Git—so much so that it inspired me to  contribute a similar feature to the Vagrant project several years ago.

While  I am comfortable using Git in my day-to-day as a software developer,  some tasks are more tedious than others—and some are simply less  memorable—which is where aliases come in. Over the years, I’ve built up a  pretty extensive list of aliases that I use, and rather than hoard them  I thought I’d troll through my archives and share my five favorite  ones.

_Note: If any of these aliases interest you, drop the relevant code snippets in the `[alias]` section of your `.gitconfig` file (usually found within your home directory). For more detailed  information on how to use and install aliases, I highly suggest you read the documentation._

## `$ git undo`

I don’t know how often I’ve committed something that I didn’t intend to, but it happens more than I like. The `git undo` alias is probably my most-used one, as it “undoes” the last commit and  gives you a bit of a do-over to make changes, unstage files, and fix a  recently screwed up commit.

### Alias

```
undo = reset --soft HEAD~1
```

### Demo

![](/assets/posts/git-undo.gif)


## `$ git amend`

In case the the previous alias didn’t tip you off, this one should make it abundantly clear that I screw up a ton. While I often over-commit files, I also tend to forget to commit files. This happens a lot when I make a commit, and then realize that I forgot to stage a new file or change. The `git amend` alias allows me to add any staged changes to the previous commit without having to update the commit message.

### Alias

```
amend = !git log -n 1 --pretty=tformat:%s%n%n%b | git commit -F - --amend
```

### Demo

![](/assets/posts/git-amend.gif)

## `$ git tree`

When  working with a team that uses a large number of feature branches, it  can often be useful to see just how those branches come together. The `git tree` alias allows me to see what has been merged into the current branch,  and when, which can make it significantly easier to get a larger view of  the activity within a given project.

### Alias

```
tree = log --graph --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(white)- %an, %ar%Creset'
```

### Demo

![](/assets/posts/git-tree.gif)

## `$ git review`

Just about every project I work on is hosted on GitHub, so the `git review` alias is particularly handy. It allows me to checkout a pull request by  its ID, which I can then run through the ringer and validate without  having to jump through any hoops.

### Alias

```
review= "!f() { git fetch origin pull/$1/head:pr/$1 && git checkout pr/$1; }; f"
```

### Demo

![](/assets/posts/git-review.gif)

## `$ git trim`

A fairly new tool in my toolbox, the `git trim` alias is what I use to clean up after myself. When run, it gets a list  of all of the branches that have been merged into the current branch,  and deletes them from your local repository. This is super useful when  pulling down a large number of feature branches, as you can clean them  up as they get merged without much overhead.

### Alias

```
trim = !git branch --merged | grep -v '*' | xargs -n 1 git branch -d
```

### Demo

![](/assets/posts/git-trim.gif)