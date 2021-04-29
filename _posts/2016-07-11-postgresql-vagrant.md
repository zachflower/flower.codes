---
layout: post
title:  "Connecting to a PostgreSQL Database in Vagrant with PSequel"
date:   2016-07-11 12:00:00
---
I’m a huge fan of [SequelPro](http://www.sequelpro.com/), a Mac OSX application that provides an incredibly easy to use GUI for managing MySQL databases. Unfortunately for me, I’ve spent the past year working on a project with a Postgres database, so my easy-as-you-please SequelPro days are pretty much over. Thankfully, after about 6 months of searching and trialing different applications, I stumbled upon [PSequel](http://www.psequel.com/), an excellent SequelPro alternative for Postgres databases.

Almost every project I work on (a good 98% of them) uses Vagrant to manage the development environment. I love Vagrant, so much so that I am usually the person who insists on setting it up whenever possible. What makes Vagrant great is the consistency between development environments through the use of virtual machines, but this can also cause an issue with applications that aim to “ease” development by working with services directly on your machine (I’m looking at you, every IDE I’ve ever used).

The biggest requirement for a GUI of any sort (whether it is for a database client or something else), is the ability to use SSH tunneling to connect to the server. SSH tunneling allows an application to first connect to a machine (in this case a virtual machine managed by Vagrant), and act as normally as if it were connected directly to a service on your personal machine.

While PSequel does support SSH tunneling, what it does not do is support password authentication. I’m sure there was a good reason for this, but in the case of Vagrant it is irritating nontheless. Most Vagrant boxes have a default username and password (vagrant and vagrant respectively). This makes it incredibly simple to use applications that support SSH tunneling.

In the case of PSequel, the only authentication method that is supported is key authentication. Luckily for us, Vagrant does typically utilize this method of authentication (when you SSH into the Vagrant machine, for example, a private key is used so you don’t have to enter a password). Unfortunately for us, the location of this private key can be different for every machine. If you don’t know how to find it, using PSequel can seem impossible.

To find the private key for a Vagrant box, open up a terminal, navigate to the project folder, and type vagrant ssh-config. You’ll see something like this:

```
$ vagrant ssh-config

Host default
HostName127.0.0.1
User vagrant
Port2222
UserKnownHostsFile/dev/null
StrictHostKeyChecking no
PasswordAuthentication no
IdentityFile/Users/zach/project/.vagrant/machines/default/virtualbox/private_key
IdentitiesOnly yes
LogLevel FATAL
```

Take note of the **HostName**, **User**, **Port** and **IdentityFile** values. You’ll need them in the next step.

![PSequel Setup](/assets/posts/postgres-1.png)


Now, open up PSequel and set up a new connection. Click the “Use SSH Tunneling” checkbox, and fill in the values you noted above in the appropriate spaces.

![PSequel Setup](/assets/posts/postgres-2.png)


Now that you’ve configured SSH tunneling, all you have to do is fill out the appropriate “Connection Details” (be sure to use localhost as the Host) and you are ready to rock!
