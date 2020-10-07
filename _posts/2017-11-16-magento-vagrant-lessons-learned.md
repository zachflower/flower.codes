---
layout: post
title:  "Magento on Vagrant: Lessons Learned"
date:   2017-11-16 12:00:00
permalink: magento-on-vagrant-lessons-learned/
---
Let's get this out of the way first: Magento is by far the single-most inefficient framework I have ever had the displeasure of working with.

While I've made a similar statement about [Craft CMS](https://flower.codes/tutorials/2017/02/27/speed-up-craft-admin.html) in the past, after a week working with Magento 2 I happily rescind my earlier Craft criticisms. All whining aside, though, in the contract development game you don't always get to choose your technology stack; like it or not, the work has to get done and the bills have to get paid.

What we _do_ get to choose, in most situations, is our toolset. One tool I am unnecessarily passionate about is [Vagrant](https://www.vagrantup.com/). For the uninitiated, Vagrant is a virtual machine orchestration platform that is used by development teams to automate the creation and management of development environments; in other words, Vagrant makes life easier.

Unfortunately, as much as I love Vagrant, its out-of-the-box configuration does _not_ play nicely with Magento—which, as I alluded to above, is a massive resource hog. So, in addition to the Magento development project I've had, my past several days have been also devoted to getting the development environment running as efficiently as possible. While there's not a _ton_ that you can do, I did learn a few things to make life with Magento + Vagrant easier (although these tips would also be beneficial to _anyone_ trying to develop against inefficient applications on Vagrant).

## Fine-tune Memory + CPU

If you Google `magento vagrant slow`, one of the first things you will be told to do is to increase the amount of system memory and CPU cores. While this is generally good advice, it isn't exactly portable. I have two primary development machines: a MacBook Pro for on-the-go, and a Windows Desktop PC for home. While both of these machines are great, they don't have the same amount of resources, so simply cranking the memory and CPUs available to the VM isn't an effective solution because it doesn't take into account the host system's available resources. What we _can_ do—thanks to the advice in this [fantastic article](https://stefanwrobel.com/how-to-make-vagrant-performance-not-suck) by Stefan Wrobel—is detect the system's resources and adapt the virtual machine to it:

```ruby
config.vm.provider "virtualbox" do |v|
  host = RbConfig::CONFIG['host_os']

  # give vm 1/4 system memory & 1/2 cpu cores
  if host =~ /darwin/
    cpus = `sysctl -n hw.ncpu`.to_i / 2
    # sysctl returns Bytes and we need to convert to MB
    mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
  elsif host =~ /linux/
    cpus = `nproc`.to_i / 2
    # meminfo shows KB and we need to convert to MB
    mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
  else
    cpus = `wmic cpu get NumberOfCores`.split("\n")[2].to_i / 2
    mem = `wmic OS get TotalVisibleMemorySize`.split("\n")[2].to_i / 1024 /4
  end

  v.customize ["modifyvm", :id, "--memory", mem]
  v.customize ["modifyvm", :id, "--cpus", cpus]
end
```

As the code comments imply, dropping the above code into your `Vagrantfile` will detect the number of CPU cores and amount of system memory—regardless of the host's operating system—and make a dynamic amount available to the guest machine. In this case, we are allocating a fourth of the system memory, and half of the CPU cores. One thing worth noting is that, while it may be tempting to allocate the majority of your CPU cores to Vagrant, it has [been shown](https://ruin.io/benchmarking-virtualbox-multiple-core-performance/) that adding more cores to a VirtualBox VM can actually _decrease_ performance, so be conservative with your core allocation if you can.


## Create a Swapfile

Sometimes increasing memory isn't enough. This is where virtual memory comes into place. While there are a lot of pros and cons to using virtual memory (in the form of a swapfile) in a production environment, spinning one up in a virtualized development environment can help protect against out of memory errors. In a nutshell, virtual memory provides additional _virtual_ RAM beyond what is already available to the system. Your disk drive is effectively being used as memory which, while slower than system RAM, will give memory-heavy applications like Magento a little more breathing room before crashing with memory-related issues. To setup a swapfile, create a [shell provisioner](https://www.vagrantup.com/docs/provisioning/shell.html) using the following script as your provisioner:

```bash
#!/usr/bin/env bash

# only do all of this once
if [ ! -f /swapfile ]; then
  # create a 1GB swap space
  fallocate -l 1G /swapfile
  ls -lh /swapfile

  # secure the swapfile
  chown root:root /swapfile
  chmod 0600 /swapfile
  ls -lh /swapfile

  # turn the swapfile on
  mkswap /swapfile
  swapon /swapfile

  # verify the swapfile
  swapon -s
  grep -i --color swap /proc/meminfo

  # add it to the fstab
  echo "\n/swapfile none            swap    sw              0       0" >> /etc/fstab
fi
```

## NFS, NFS, NFS

Another tip that Stefan gives in the article mentioned above is to use NFS to share files between the host and guest operating systems. By default, VirtualBox uses its own custom sharing mechanism, which has been shown in [benchmarks](https://stefanwrobel.com/how-to-make-vagrant-performance-not-suck#toc_3) to be far inferior to NFS. To enable NFS sharing, there is one prerequisite: a `:private_network` address. With that, all you have to do to share folders with your virtual machine via NFS is to add the `nfs: true` flag to the `synced_folder` directive:

```ruby
# Required for NFS to work, pick any local IP
config.vm.network :private_network, ip: '192.168.50.50'

# Use NFS for shared folders for better performance
config.vm.synced_folder '.', '/vagrant', nfs: true
```

## Automate Cleanup Between Destroys

Alright, time for some Magento-specific tips. Magento, like WordPress, uses flat-files to manage configuration settings. While this is practical in a production environment, it sucks in a development environment that can be reset with a single `vagrant destroy` command. Thankfully, with the help of the amazing (`vagrant-triggers`)[https://github.com/emyl/vagrant-triggers] plugin, we can hack our way to _actually_ resetting the development environment whenever we need to do a `destroy` and `up`. To do this, we'll want to create two different triggers: one after `:destroy`, and one after `:up` and `:provision`.

```ruby
# delete config/cache data on destroy (this is necessary, as Magento saves
# database info, installation metadata, cache, etc as flat files in the
# project directory, so destroying and re-upping the VM won't clear it out)
config.trigger.after [:destroy] do
  # delete the env file to run the uninstaller on the next `up`
  if File.file?("./app/etc/env.php")
    info "Deleting config files..."
    File.delete("./app/etc/env.php")
  end
end
```

What the after `:destroy` trigger does is deletes the `./app/etc/env.php` file, which tracks things like database credentials, the admin panel path, etc. If you're a seasoned Magento developer, you may be screaming at your screen because that's not the only file that needs to be deleted.

I know.

_But_, rather than doing everything manually, Magento has a command that does the cleanup for us. While we can easily run it from the host machine, that isn't a portable solution, so we need to run it from _within_ the virtual machine. So, why don't we just do it in the `:destroy` trigger? Why only delete _one_ config file?

```ruby
# run the following commands after every vagrant up and provision
config.trigger.after [:up, :provision] do
  unless File.file?("./app/etc/env.php")
    # if the env file doesn't exist, run the uninstaller to clean up any other
    # potential remaining config or cache files from the last install
    info "Cleaning up stale files..."
    run "vagrant ssh -c \"cd /var/www/public ; sudo bin/magento setup:uninstall --no-interaction\""
  end
end
```

The answer to that is... we can't trust that the virtual machine is actually running when the `destroy` command is executed. So we delete the `env.php` file to signal to the `:up` and `:provision` triggers that we need to run the Magento uninstaller command. This two-punch reset process might seem a little like overkill, but the name of the Vagrant game is automation and ease-of-use, which this method accomplishes, reducing overhead for developers who shouldn't have to waste time wrestling with their development environment.

## Skip the Installation Wizard

So... I love automation... and in lieu of the easy `destroy` and `up` process above I felt it necessary to also automate the Magento installation process as well. Using the already established deleted `env.php` signal, after the uninstallation process we can then run a similar Magento install command with a few pre-configured settings:

```ruby
# run the following commands after every vagrant up and provision
config.trigger.after [:up, :provision] do
  unless File.file?("./app/etc/env.php")
    # automatically run the Magento installer
    info "Installing Magento..."
    run "vagrant ssh -c \"cd /var/www/public ; bin/magento setup:install --base-url=http://localhost.dev --db-name=magento --db-password=root --admin-user=admin --admin-password=Password123 --admin-email=admin@example.com --admin-firstname=Admin --admin-lastname=Adminson --backend-frontname=admin --no-interaction\""
  end
end
```

While the settings in the installer are generalized for this demonstration, you should take special care to customize the `--base-url`, `--db-name`, `--db-password`, and other settings to match your specific Vagrant setup.

## What Did I Miss?

While these are just a few tips that helped _me_ deal with the inefficiencies of the Magento framework in a virtualized development environment, I'm sure they aren't _all_ of the ways things can be improved. Have anything you've done to make Magento development easier? Let me know! I would absolutely love to hear your thoughts!
