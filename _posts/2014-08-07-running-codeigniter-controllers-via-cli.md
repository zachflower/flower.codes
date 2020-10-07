---
layout: post
title: Running CodeIgniter Controllers in the Command Line
date: 2014-08-07 12:00:00
permalink: running-codeigniter-controllers-in-the-command-line/
---
Running CodeIgniter controllers in the command line is a surprisingly easy thing to do, but for the novice, it can seem a bit confusing at first. If you want to skip the tutorial, here is how you run any CodeIgniter controller in the command line (run the following from the root of your CodeIgniter directory):

```
php index.php <controller_name> [<method_name>] [<parameter_1> <parameter_2> ...]
```

For more information, follow along below.

## Setup

While the above example will successfully run any CodeIgniter controller in the command line, it is often helpful to be a bit more organized in your directory structure. CodeIgniter allows sub-directories inside the `controllers` directory, which allows for more organized controller grouping. I find it super useful to keep all of my command line scripts in one directory, as it will keep things from getting cluttered. For the purposes of this example, we’ll use cli as the directory name. Inside of your `controllers` directory, create a new directory called `cli`. All command line controllers we create will go inside here.

## Restrictions

Now, all we’ve done so far is put our command line scripts inside a different directory, but we also want to make sure that they are only accessible via the command line. It wouldn’t be very good if visitors to your site accidentally (or purposefully) hit a CLI controller. To restrict access to the command line only, add the following code at the beginning of your controller, just after the the opening PHP tag, and just before your class declaration:

```php
if ( PHP_SAPI === 'cli' ) exit('No web access allowed');
```

## Finishing Up

Now that we have our directory structure and script access set up, we can jump back to the beginning and run our script:

```
php index.php cli/<controller_name> [<method_name>] [<parameter_1> <parameter_2> ...]
```