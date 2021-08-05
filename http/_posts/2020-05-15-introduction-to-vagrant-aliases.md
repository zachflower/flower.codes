---
layout: post
title: "An Introduction to Vagrant Aliases"
date: 2020-05-15 12:00:00
---
A  few years ago, I checked off an item on my Open Source Bucket List when  I pitched—and ultimately contributed—a brand new feature to HashiCorp’s  [Vagrant](https://www.vagrantup.com/): command aliases. While aliases have been a core Vagrant feature for some time, there hasn’t been a lot of coverage about what they are, and why they really matter.

An  expansion on the concept of shell-based aliases, user-configurable  aliases within Vagrant provide a more contextual outlet for tuning  Vagrant in a way that isn’t operating system or shell dependent.  Personally, I use Vagrant on both Windows and macOS machines, and while  Vagrant is cross-platform, my command line aliases are not.

## Who Cares?

Originally inspired by Git’s own [alias functionality](https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases),  aliases make your Vagrant experience simpler, easier, and more familiar  by allowing you to create your own custom Vagrant commands. In a world  where software developers tune and configure their environments for  optimum productivity, aliases allow us to abstract away the nuances of a  given tool in favor of our own preferred usability patterns.

Take,  for example, a common workflow that I tend to follow: completely  burning a running Vagrant box to the ground. Generally, this involves  executing a `vagrant destroy` followed by removing the `.vagrant` directory from the project. Instead of running both of these commands every time, I can instead create an alias called `vagrant eradicate` that does all that sweet, sweet destruction on my behalf.

## But How?

Defined using a standard `key = value` format, Vagrant aliases work the same way as Git aliases. By adding  these aliases to the Vagrant alias file (which can be found either at `VAGRANT_HOME/aliases` or in a custom file defined using the `VAGRANT_ALIAS_FILE` environment variable), you can start crafting your own aliases almost immediately.

Let’s say that we want to implement the `vagrant eradicate` command example from above. This can be done by dropping the following line into your Vagrant aliases file:

```
eradicate = !vagrant destroy && rm -rf .vagrant
```

Once added, the vagrant eradicate command should be available for all your burninating needs. Using this type of key = value format, there are two types of aliases that can be defined: internal and external aliases.

### Internal Aliases

Internal command aliases call Vagrant’s `CLI` class directly. This allows you to alias one Vagrant command to another  Vagrant command. This technique can be very useful for creating simple  commands that you think should exist. For example, if vagrant stop feels more intuitive than vagrant halt, the following alias definitions would make that change possible:

```
stop = halt
```

Or, maybe you want to be able to force halt a running Vagrant box. Adding parameters and options to the alias can be done as well:

```
stop = halt -f
```

This would make the following commands functionally equivalent:

```
vagrant stop
vagrant halt -f
```

### External Aliases

While  internal aliases can be used to define more intuitive Vagrant commands,  external command aliases are used to define Vagrant commands with brand new functionality. Similarly to Git aliases, these aliases are prefixed with the `!` character, which tells the command interpreter that the alias should be executed as a shell command.

As  an example, let's say that you want to be able to view the processor  and memory utilization of the active project’s running Vagrant box. To  do this, you could define a vagrant stats command that returns the required information in an easy-to-read format, like so:

```
stats = !ps aux | grep "[V]BoxHeadless" | grep $(cat .vagrant/machines/default/virtualbox/id) | awk '{ printf("CPU: %.02f%%, Memory: %.02f%%", $3, $4) }'
```

The  above alias, from within the context of an active Vagrant project,  would print the CPU and memory utilization of the running box directly  to the console:

```
CPU: 4.20%, Memory: 11.00%
```

## What Else?

What  started out as a small idea turned into one that solved a very real  pain point for me personally, and it’s one that has benefited me for  years now. These are just a few examples of the types of aliases you can  create in Vagrant, but what are some other examples you can think of  (or are currently using)?