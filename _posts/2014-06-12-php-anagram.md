---
layout: post
title: Quickly Determine If Two Strings Are Anagrams in PHP
date: 2014-06-12 12:00:00
---
When interviewing with tech companies, there are a LOT of questions involving anagrams. While there are many different approaches to solving these questions, here is a simple one-line function that can determine whether or not two strings are anagrams in PHP.

This approach utilizes the built-in PHP function, [`count_chars()`](http://www.php.net//manual/en/function.count-chars.php). When using a double-equals (not a triple equals), we can compare the arrays returned by this function on both strings, and if they are anagrams, they will be equal.

```php
<?php

function is_anagram($a, $b) {
	return(count_chars($a, 1)==count_chars($b, 1));
}
```