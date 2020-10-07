---
layout: post
title: Running Django Automatically in Vagrant Using Puppet
date: 2014-01-21 12:00:00
permalink: running-django-automatically-in-vagrant-using-puppet
---
Recently, I set up a Vagrant box that was running [Django](https://www.djangoproject.com/), the Python-based web framework. One thing I quickly learned is that Django cannot run as a daemon. After hours of Googling and stressing out, I remembered one of my favorite tools: [GNU Screen](https://www.gnu.org/software/screen/). GNU Screen is a terminal-based window manager that lets you detach running processes, and connect back to them later. Unlike nohup, screen is an excellent way to manage long-running scripts, as you can interact with them later.

The setup for this is pretty easy. All you need, in addition to the Vagrant+Puppet setup you will already require to run Django (which I won’t go into at this time), is to install the `screen` package. Assuming your `manage.py` file is in the shared `/vagrant` directory, the following Puppet command will run Django as the default `vagrant` user, listening on all interfaces on port `8000`.

```ruby
exec {
  "start-django": command => "/bin/su -c 'cd /vagrant ; /usr/bin/screen -S runserver -d -m /usr/bin/python manage.py runserver 0.0.0.0:8000' vagrant", require => Package["screen"]
}
```

That’s it! It’s quite simple, and this same technique can be used for other methods as well (for example, running `grunt watch` on your `/vagrant` folder under the `vagrant` user upon startup).