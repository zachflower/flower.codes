---
layout: post
title: How to Force Installation of Vagrant Plugins
date: 2014-09-22 12:00:00
---
[Vagrant](https://www.vagrantup.com/) is an amazing tool for local development, especially in the case of distributed teams. It allows for complete parity between every team member’s development environment without forcing anyone to follow a complicated list of environment setup steps. Vagrant’s plugin support is also excellent, as it provides for further automating the environment setup, such as automatically adding host names, running additional commands on the host machine, etc.

Unfortunately, the simplicity that Vagrant provides is reduced as plugins are added, as each team member will then have to install and possibly configure those plugins. Luckily, because the `Vagrantfile` is (essentially) just a Ruby script, we can detect missing plugins, and force their installation before any other actions are run in the Vagrant file.

To automatically detect and install Vagrant plugins for your team members, add the following code right above the `Vagrant.configure()` section of your `Vagrantfile`:

```ruby
unless Vagrant.has_plugin?("<PluginName>")
	system('vagrant plugin install <PluginName>')
	raise("Plugin installed. Run command again.");
end
```