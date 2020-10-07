---
layout: post
title: "Never Install a Thing Again (Except Docker)"
date: 2019-11-08 12:00:00
permalink: never-install-a-thing-again-except-docker
---

I'm not gonna lie... it took me a while to adopt Docker. A devout [Vagrant](https://www.vagrantup.com/) follower, Docker just didn't feel mature enough to me until very recently, but _boy have I seen the light_. As a development environment, Docker has completely replaced Vagrant for me, but what really brought me around to the concept of containerization is just how _versatile_ it is. Beyond simply acting as a vehicle for application servers, a particularly impressive use-case for Docker is as a tool for replacing my most commonly-used command-line tools.

## Containerizing All the Things!

You see, Docker is a low-resourced, self-contained environment that not only allows you to execute applications in isolation, but also completely sidesteps the need to actually _install_ any applications _or_ their dependencies. To highlight just how awesome this is, let's take a look at how to install and execute a Docker-based version of one of my favorite command-line applications: [`tldr`](https://github.com/tldr-pages/tldr).

Manual pages are super useful, but damn if they aren't exceptionally complicated sometimes. To solve for this problem, an open-source command-line tool called `tldr` has been built to provide concrete, practical examples of nearly every command you can think of. In the words of the `tldr` [repository itself](https://github.com/tldr-pages/tldr/blob/master/README.md):

> New to the command-line world? Or just a little rusty? Or perhaps you can't always remember the arguments to lsof, or tar?
>
> Maybe it doesn't help that the first option explained in man tar is:
>
> -b blocksize
>    Specify the block size, in 512-byte records, for tape drive I/O.
>    As a rule, this argument is only needed when reading from or writing to tape drives,
>    and usually not even then as the default block size of 20 records (10240 bytes) is very common.
>
> Surely people could benefit from simplified man pages focused on practical examples.
>
> This repository is just that: an ever-growing collection of examples for the most common UNIX / Linux / macOS / SunOS commands.

### Avoiding Dependency Hell

Now, to install `tldr`, you only have to run the following command:

```
npm install -g tldr
```

Unfortunately, this command requires that node.js is installed on your local machine, which has an impressively large set of dependencies and can be installed in at least a half-dozen ways (depending on your operating system and package manager of choice).

This is where Docker comes in. Instead of diving into the dependency-deep-end, a simple command can be run to both download a containerized image of `tldr` _and_ execute it:

```
$ docker run --rm --interactive --tty --volume ${HOME}/.tldr:/root/.tldr nutellinoit/tldr

Usage: tldr command [options]

Simplified and community-driven man pages

Options:
  -V, --version            output the version number
  -l, --list               List all commands for the chosen platform in the cache
  -a, --list-all           List all commands in the cache
  -1, --single-column      List single command per line (use with options -l or -a)
  -r, --random             Show a random command
  -e, --random-example     Show a random example
  -f, --render [file]      Render a specific markdown [file]
  -m, --markdown           Output in markdown format
  -o, --os [type]          Override the operating system [linux, osx, sunos]
  --linux                  Override the operating system with Linux
  --osx                    Override the operating system with OSX
  --sunos                  Override the operating system with SunOS
  -t, --theme [theme]      Color theme (simple, base16, ocean)
  -s, --search [keywords]  Search pages using keywords
  -u, --update             Update the local cache
  -c, --clear-cache        Clear the local cache
  -h, --help               output usage information

  Examples:

    $ tldr tar
    $ tldr du --os=linux
    $ tldr --search "create symbolic link to file"
    $ tldr --list
    $ tldr --list-all
    $ tldr --random
    $ tldr --random-example

  To control the cache:

    $ tldr --update
    $ tldr --clear-cache

  To render a local file (for testing):

    $ tldr --render /path/to/file.md
```

_Easy_, but a bit of a mouthful, isn't it? Nobody wants to type `docker run --rm --interactive --tty --volume ${HOME}/.tldr:/root/.tldr nutellinoit/tldr` every time they want to check the `tldr` of a command.

### Keep it Simple, Stupid

So, how do we improve this? `.bashrc` to the rescue! Instead of executing a mouthful of a Docker command every time we want to access `tldr`, let's instead create a Bash function to simplify the process for us. To do this, open up your `~/.bashrc` file and add the following block of code (while some shells rely on `.bash_profile`, or even `.profile`, for the purposes of this example I'm going to use `.bashrc`):

```bash
tldr() {
    if which tldr > /dev/null; then
        tldr "$@"
    else
        if [[ ! -d "${HOME}/.tldr" ]]; then
            mkdir -p "${HOME}/.tldr"
        fi

        docker run --rm --interactive --tty \
            --volume ${HOME}/.tldr:/root/.tldr \
            nutellinoit/tldr "$@"
    fi
}
```

What the above function does is define a new command in your shell called `tldr` that will first check if `tldr` is actually installed on the local machine (`if which tldr > /dev/null`). If it is, then we will execute it directly, otherwise we will execute our `docker run` command (and, in the process, make sure that the `~/.tldr` volume exists). After reloading our shell, we should be able to execute `tldr` like any other command without installing _any_ local dependencies:

```
$ tldr scp

  scp

  Secure copy.
  Copy files between hosts using Secure Copy Protocol over SSH.

  - Copy a local file to a remote host:
    scp path/to/local_file remote_host:path/to/remote_file

  - Copy a file from a remote host to a local directory:
    scp remote_host:path/to/remote_file path/to/local_directory

  - Recursively copy the contents of a directory from a remote host to a local directory:
    scp -r remote_host:path/to/remote_directory path/to/local_directory

  - Copy a file between two remote hosts transferring through the local host:
    scp -3 host1:path/to/remote_file host2:path/to/remote_directory

  - Use a specific username when connecting to the remote host:
    scp path/to/local_file remote_username@remote_host:path/to/remote_directory

  - Use a specific ssh private key for authentication with the remote host:
    scp -i ~/.ssh/private_key local_file remote_host:/path/remote_file

```

## More, more, and more

That's it! Pretty cool, right? While this is just a simplistic example, I'm slowly but surely replacing my own command line tools with Dockerified ones for increased portability and ease-of-use in my own (self-hosted) [`dotfiles` repository](https://git.flower.codes/zach/dotfiles/src/branch/master/.bash_functions).

Cheers!