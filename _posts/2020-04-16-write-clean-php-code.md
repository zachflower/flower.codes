---
layout: post
title: "Write Clean PHP Code (or “else”)"
date: 2020-04-16 12:00:00
permalink: write-clean-php-code-or-else/
---

> Always code as if the guy who ends up maintaining your code will be a violent psychopath who knows where you live — John Woods

Writing clean code isn’t hard, but sometimes getting a piece of code to work right can get in the way of making it maintainable. Unfortunately, as many of us know, code that works but is impossible to read is just as dangerous as code that doesn’t work at all. Making changes, even small ones, can be risky because the consequences of modifying messy code are often difficult to foresee.

I love PHP, but because of its infinite flexibility, it has developed a (probably well deserved) reputation for being frustrating to work with. You see, when developers don’t have a lot of guardrails, anti-patterns can emerge pretty quickly, and spaghetti code can become the norm. But that doesn’t have to be the standard, and even small changes to the way you think about structuring your PHP code can go a long way towards increased maintainability.

```php
function foo(string $param) : ?bool
{
    if ( $param === 'bar' ) {
        $key = true;
    } else if ( $param === 'baz' ) {
        $key = null;
    } else {
        $key = false;
    }

    return $key;
}
```

As an example, a really great rule of thumb that I operate by is to avoid using else blocks at all costs. Why? At their core, else blocks aren’t particularly nasty, but when used they almost always make code — even simple functions, like the one above — just slightly less readable. By trying to avoid them, you force yourself to focus on the logic you are trying to implement as a whole, rather than the individual components.

So, to illustrate the ways in which removing `else` statements from your code can make it easier to maintain, let’s walk through a few ways we can refactor the simple `foo()` function shown above — and even take a look at how we can take refactoring just a little too far.

## Start With Default Values

A common pattern developers follow when writing code is to define variables within `if` blocks, with an ultimate fallback value being thrown into a final `else`. But what if, instead of doing that, we started with the default value?

```php
function foo(string $param) : ?bool
{
    $key = false;

    if ( $param === 'bar' ) {
        $key = true;
    } else if ( $param === 'baz' ) {
        $key = null;
    }

    return $key;
}
```

Looking at our `foo()` function, we can see that this simple change immediately defines a default value for `$key` and then overrides it if necessary. This sets a tone, and reduces the back-and-forth of your eyes as you read through the different definition cases.

## Return Early and Often

Default values are only a start, though. In a function that is large enough, it’s entirely possible that you can forget what the default value was at the beginning of your spelunking. Instead of focusing on an individual variable definition, focusing on the purpose of the function as a whole can allow you restructure it in a way that the output gets prioritized.


```php
function foo(string $param) : ?bool
{
    if ( $param === 'bar' ) {
        return true;
    }

    if ( $param === 'baz' ) {
        return null;
    }

    return false;
}
```

Applying this logic to our `foo()` function means returning when we know what the return value is, rather than waiting until the end of the function. For example, we know for sure that if `$param === 'bar'`, then we have to return `true`. There’s no point in maintaining a local variable like `$key` when we can just return as quickly as possible. This logic also has the added benefit of making it very clear what happens when certain conditions are met, which reduces nesting, and also makes the logic extremely explicit.

## Be Explicit, Not Implicit

Speaking of being explicit, we can take our goal of avoiding else blocks even further by reducing if blocks too. While this can be tempting, it has the added risk of requiring just a little more effort to read the codebase.

```php
function foo(string $param) : ?bool
{
    if ( $param === 'baz' ) {
        return null;
    }

    return $param === 'bar';
}
```

For example, we know that in our `foo()` function if `$param === 'baz'` we return `null`, otherwise we return a boolean value based on what `$param` equals. We can reduce our function even further, which can limit the lines of code used, but it requires an extra cycle of thought for the reader to make sure they understand what is going on. Implicit code often comes at the expense of readability, especially for more junior developers.

### Prefer Form Over Function

Lines of code is a useless metric. Often times, it can imply that a piece of code is either overly complex, or overly nuanced. This can be nice when trying to maintain small file size, but can make maintenance unnecessarily difficult. There’s something to be said about preferring form over function in source code.

```php
function foo(string $param) : ?bool
{
    return ($param === 'baz') ? null : ($param === 'bar');
}
```

Our `foo()` function can be easily reduced to a ternary, but to what end? While it makes this a one-line function, its readability is almost nonexistent. Sure, with a little effort you can see that we return `null` if `$param === 'baz'`, otherwise we return `true` or `false` depending on if `$param === 'bar'`, but are the eight lines we removed really worth the extra effort to deconstruct what the code does really? I’m not so sure.