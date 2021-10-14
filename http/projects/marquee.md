---
layout: page
title: </marquee>
regenerate: true
---

`</marquee>` is a command-line Node.js app that creates back-dated Git commits in
order to write a message on your GitHub contribution summary graph.

**Source:** [https://github.com/zachflower/marquee](https://github.com/zachflower/marquee)

1. [Installation](#installation)
1. [Usage](#usage)

___

## Installation

```
npm install github-marquee
```

## Usage

Writing a marquee message to your GitHub contribution summary graph is done in a few steps.

#### 1. Create a New Directory

Marquee is designed to work on a brand new repository. Because we are `</marquee>` history, it is a _really bad_ idea to use this on an existing repository.

```
$ mkdir hi-there
```

#### 2. Create Commit Messages

Open up your terminal and use the following syntax to create a commit history that maps to your message.

```
$ marquee <message>
```

#### 3. Create a Public GitHub Repository

`</marquee>` only creates a contribution history, it does not interface directly with GitHub. After you've set up your commits, head over to [https://github.com/new](https://github.new) and create a new repository.

Be sure to leave "Initialize this repository with a README" unchecked, and do not add a license or `.gitignore`.

#### 4. Push Your New Repository

After creating your repository, follow the GitHub instructions to "push an existing repository from the command line." After pushing your repository, your GitHub contribution summary graph will be updated immediately.

**Note**: If you'd like to change your marquee message, you will need to _delete the repository_ and run through the process from the beginning, otherwise the messages will be overlayed on top of one another.