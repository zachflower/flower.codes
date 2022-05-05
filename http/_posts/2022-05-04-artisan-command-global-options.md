---
layout: post
title: "Adding Custom Global Arguments to Artisan Commands"
date: 2022-05-04 13:51:53
---

I love [Laravel](https://laravel.com/).

As a PHP developer with a history of working in everything from WordPress to CodeIgniter, when Laravel came on the scene it was a revelation. From the design to the usability, it is an absolutely top-notch framework that contains untold depths of power.

That said, sometimes Laravel's own opinionated structure can get in the way of what can feel like pretty simple intentions, such as adding custom global arguments to all Artisan commands.

What do I mean by "custom global arguments?" As an example, _all_ Artisan commands have the same set of arguments and options that can be used during runtime:

```
    --raw             To output raw command list
    --format=FORMAT   The output format (txt, xml, json, or md) [default: "txt"]
    --short           To skip describing commands' arguments
-h, --help            Display help for the given command. When no command is given display help for the list command
-q, --quiet           Do not output any message
-V, --version         Display this application version
    --ansi|--no-ansi  Force (or disable --no-ansi) ANSI output
-n, --no-interaction  Do not ask any interactive question
    --env[=ENV]       The environment the command should run under
-v|vv|vvv, --verbose  Increase the verbosity of messages: 1 for normal output, 2 for more verbose output and 3 for debug
```

But, what if we wanted to add _our own_ options and arguments?

## A Wild Problem Has Appeared!

I've always been a pretty big fan of [Heroku](https://www.heroku.com/) for both its power and ease-of-use—okay, maybe not so much lately thanks to how poorly they've communicated their most recent [security incident](https://www.theregister.com/2022/05/04/heroku_security_communication_dubbed_complete/), but _historically_ I've been a fan.

One of Heroku's most frustrating drawbacks, though, is how limited the Scheduler is. A kind of half-assed cron, [Heroku's Scheduler](https://devcenter.heroku.com/articles/scheduler) allows you to run any command on 10-minute, 1-hour, or 1-day intervals, which is _kind of_ useful, but also woefully insufficient for many different types of jobs.

What if I only need something run weekly, monthly, or even yearly?

Scheduler says "no."

So, in order to work around this (within a typical Laravel application), I have traditionally added an additional argument to my Artisan commands that limits running on specific days. For example:

```
php artisan run:command --day=friday
```

Pretty simple design, right?

It gets the job done, but it's hardly scalable. Copying the same several lines of "if current day == --day parameter, then run, otherwise return 0" logic can get pretty tedious (not to mention nothing close to DRY), so I dug into Artisan to better understand how I could add additional global parameters that can be applied to _all_ commands, rather than just the ones I specify.

## Extending `Artisan`

Thankfully Laravel, being the object-oriented framework that it is, is pretty easy to extend. The challenge isn't so much in the extension as it is in properly writing said extension up into the rest of the application.

That said, before we can actually wire _anything_ up, we first need to extend the `Console\Application` class and add our own custom `--day` argument. To do this, create a new file called `./app/Console/Application.php` and paste the following code in:

```php
<?php
namespace App\Console;

use Illuminate\Console\Application as Artisan;
use Illuminate\Support\Str;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;

class Application extends Artisan
{
    /**
     * Runs the current application.
     *
     * @return int 0 if everything went fine, or an error code
     */
    public function doRun(InputInterface $input, OutputInterface $output)
    {
      if ( !$this->checkDay($input) ) {
        $output->writeln(sprintf('<comment>This command can only be run on %s.</comment>', Str::plural(ucfirst($input->getParameterOption('--day')))), OutputInterface::VERBOSITY_QUIET);

        return 0;
      }

      return parent::doRun($input, $output);
    }

    protected function getDefaultInputDefinition()
    {
        $definition = parent::getDefaultInputDefinition();

        $definition->addOption(new InputOption('--day', null, InputOption::VALUE_OPTIONAL, "Only run the command on the specified day of the week"));

        return $definition;
    }

    public function checkDay(InputInterface $input)
    {
      $day = $input->getParameterOption('--day');

      if ( !$day ) {
        return true;
      }

      return strtolower(now()->englishDayOfWeek) === strtolower($day);
    }
}
```

What the above code is doing can be broken down into a few parts:

1. It creates a new `checkDay()` method that gets our custom global parameter (`--day`) and checks the value against the current day of the week. If the two values are matched (or `--day` is not provided), then `checkDay()` will return `true`, otherwise it will return `false`.
1. It extends the `doRun()` method and checks the value of `checkDay()` before running the rest of the command. If `checkDay()` returns false, the command will immediately `return 0` and print a comment indicating that the command can only be run on the specified day.
1. Finally, because we want anyone that types `php artisan --help` to _know about_ this new argument, we extend `getDefaultInputFunction()` and add a new definition indicating that `--day` both _exists_, and how it works.

## Wiring It Up

So, we've extended our console application, but if we were to run `php artisan --help` our new `--day` argument won't show up yet. That's because we need to _tell Laravel_ about our new class, otherwise it will load the original `Console\Application` class by default.

To do this, open up `./app/Console/Kernel.php` and add the following function to the `Kernel` class:

```php
/**
 * Retrieve the artisan application instance.
 *
 * @return \Illuminate\Console\Application
 */
protected function getArtisan()
{
  if (is_null($this->artisan)) {
    return $this->artisan = (new \App\Console\Application($this->app, $this->events, $this->app->version()))->resolveCommands($this->commands);
  }

  return $this->artisan;
}
```

What the above function does is tell Laravel to load our newly defined `\App\Console\Application` class when setting Artisan up, rather than the default `\Illuminate\Console\Application` class. Because we extended the original `Console\Application` class, the existing functionality will still be maintained, but with the new functionality we just added.

Now, if we were to type `php artisan --help`, we would see a new argument listed in the response:

```
    --raw             To output raw command list
    --format=FORMAT   The output format (txt, xml, json, or md) [default: "txt"]
    --short           To skip describing commands' arguments
-h, --help            Display help for the given command. When no command is given display help for the list command
-q, --quiet           Do not output any message
-V, --version         Display this application version
    --ansi|--no-ansi  Force (or disable --no-ansi) ANSI output
-n, --no-interaction  Do not ask any interactive question
    --env[=ENV]       The environment the command should run under
    --day[=DAY]       Only run the command on the specified day of the week
-v|vv|vvv, --verbose  Increase the verbosity of messages: 1 for normal output, 2 for more verbose output and 3 for debug
```

## Fin.

That's it!

All-in-all, it's a pretty straightforward change with some potentially powerful implications.

---

This is post 005 of [#100DaysToOffload](https://100daystooffload.com/)