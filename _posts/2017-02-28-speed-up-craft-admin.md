---
layout: post
title:  "(Updated) Speeding Up the Craft CMS Admin Dashboard"
date:   2017-02-27 12:00:00
permalink: updated-speeding-up-the-craft-cms-admin-dashboard/
---
I am not a fan of [Craft CMS](http://craftcms.com).

Despite its relative popularity, it leaves a lot to be desired by way of resource management, requiring at least 2GB of available memory in order to function efficiently. While there are a lot of reasons for this inefficiency, one of the biggest culprits is how Craft handles static files in its admin area. Because of the way Craft has been architected, every stylesheet, image, script, and font requested in the admin area first gets loaded directly into memory before being delivered to the end user. This process eats up precious resources and adversely affects the usability of the site for every user.

Before we get into how to fix this issue, though, let's first talk about why it is happening to begin with. Taking a look at Craft's standard `.htaccess` file, we can see that, before sending a request to the Craft `index.php` file, the web server first tries to find a file or directory that matches the requested file.

```apache
<IfModule mod_rewrite.c>
	RewriteEngine On

	# Send would-be 404 requests to Craft
	RewriteCond %{REQUEST_FILENAME} !-f
	RewriteCond %{REQUEST_FILENAME} !-d
	RewriteCond %{REQUEST_URI} !^/(favicon\.ico|apple-touch-icon.*\.png)$ [NC]
	RewriteRule (.+) index.php?p=$1 [QSA,L]
</IfModule>
```

In a nutshell, if you were to open up your browser and navigate to `http://example.com/file.png`, the web server will first try and find `file.png` in the document root, and then escalate the request to `index.php` if the file can't be found. This allows things like fonts, stylesheets, scripts, and images to be sent directly to the browser, which in turn speeds up the overall load time of a web page.

Unfortunately, the static files that Craft's admin area depends on are kept outside of the document root, which means that any request for them is routed directly through Craft itself. What is happening in this instance is, for every one of these files, Craft must first lookup the file in the filesystem, and then load the file contents into memory in order to deliver it to the end-user. While this isn't necessarily bad practice, Craft's admin section loads well over a dozen static files on every request, which can take upwards of a few minutes on lightweight servers (like a Heroku Hobby Dyno, for example).

To demonstrate the issue at hand, let's perform a quick anecdotal benchmark on the login page of a stock Craft installation (the repository for which can be found at [https://github.com/zachflower/witchcraft](https://github.com/zachflower/witchcraft)). For reference, all tests well be performed on Craft v2.6.2963 hosted on a Heroku Hobby Dyno with all browser caching disabled.


![Craft Admin Resources]({{ site.url }}/assets/posts/craft-1.png)

As you can see, a large handful of Craft's admin resources take over a second to load on a small server with only one user. While this doesn't immediately scream **PROBLEM**, routing all admin resources through the Craft core can become very expensive very quickly, as the number of users in the admin panel *directly* affects the rest of the non-admin users by taking up valuable resources.

So, how do we fix this?

To put it simply… we route requests for static files *around* Craft.

Believe it or not, accomplishing this is *incredibly* simple. All we have to do is create a copy of the `craft/app/resources` folder in `public/admin/resources`. What this does is makes the static admin resources available to the web server, allowing it to serve these files directly to the end-user rather than having to use Craft as a middleman. If we redo the basic benchmark we did above, we can see that the static file load times are three times faster than they were before.


![Craft Admin Resources]({{ site.url }}/assets/posts/craft-2.png)

It should be noted here that, while copying the admin resources into a publicly accessible directory is a fast and simple fix, it doesn't account for Craft updates. Making this solution future-proof is out of the scope of this post, however in an environment that offers atomic deployments like Heroku, establishing a build-process to keep the `admin/public/resources` folder in sync with the `craft/app/resources` is a relatively straightforward process.

Craft is far from a perfect CMS solution, but perfect or not, its popularity warrants a clear understanding of its limitations. While Craft's admin panel can be a significant resource hog, this quick fix is a viable solution that will help reduce cost and improve the end-user experience.

## (Update 2017-11-16) And now, a plugin!

I received an email today from [Matt Shearing](https://github.com/matt-adigital), a developer over at [A Digital](http://www.adigital.co.uk), about a [Craft plugin](https://github.com/a-digital/cmsspeedup) they created that automates this process a bit. Because he did a better job explaining what his own plugin does than I would be able to, here's an excerpt from the email he sent me:

_I noticed your warning around updates to the cms and decided to create a plugin around this._

_The initial install copies the files automatically, and whenever an update to the cms occurs, it removes this new folder and then repeats the initial process to create a fresh copy. When the plugin is uninstalled it completely removes our folder._

_This was just done internally so that we don’t need to keep on copying the files. If this helps you or any of your readers though, I’ve made it available on GitHub here: [https://github.com/a-digital/cmsspeedup](https://github.com/a-digital/cmsspeedup)._