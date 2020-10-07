---
layout: post
title: Connecting To Panic’s Transmit Favorites From The Command Line
date: 2012-02-17 12:00:00
permalink: connecting-to-panics-transmit-favorites-from-the-command-line/
---
I am a fan of running my apps my own way. Sometimes, I want to be able to write a shell script around an action, or just have an alias to run a command from the command line. Whatever the reason, I like to tinker, and recently I needed a way to connect directly into one of my [Transmit](https://panic.com/transmit) favorites from the command line.

## The Favorites

My first stop was to find out where and how Transmit stores the favorites. Transmit’s favorites are stored here:

```
/Users/***USERNAME***/Library/Application Support/Transmit/Metadata/
```

Where `***USERNAME***` is your username. Each `.favoriteMetadata` file in that directory is a favorite you have stored (or a duplicate or autosave of a favorite). You can edit them and get an idea of what they are used for, or you can just connect to each one individually to figure it out.

## The Command

The command to load a favorite into Transmit automatically is as follows:

```
/Applications/Transmit.app/Contents/MacOS/Transmit /Users/***USERNAME***/Library/Application Support/Transmit/Metadata/***FILENAME***.favoriteMetadata
```

It really is as simple as that. If you have any questions or problems, feel free to leave a comment, or shoot me an email using the contact page.