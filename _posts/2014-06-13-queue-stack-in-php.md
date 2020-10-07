---
layout: post
title: PHP Queue and Stack Implementations
date: 2014-06-13 12:00:00
permalink: php-queue-and-stack-implementations
---
Continuing on my job interview study session binge, the next two data structures I have built using PHP are the traditional [queue](https://en.wikipedia.org/wiki/Queue_(abstract_data_type)) and [stack](https://en.wikipedia.org/wiki/Stack_(data_structure)).

In computer science, stacks and queues typically go hand in hand, however they are opposite implementations of each other. A queue is a first-in-first-out data structure. The name implies this pretty well, however we don’t tend to use the word “queue” as much as we use the word “line” in the US. The first person in line is the first person to be served. A stack, however, is a first-in-last-out data structure. The best way to think of a stack is to think of a stack of plates. You stack them from the bottom up, but you take a plate off the top.

My queue and stack implementations were based on the standard C++ operations listed at [http://www.cplusplus.com/reference/queue/queue/](http://www.cplusplus.com/reference/queue/queue/) and [http://www.cplusplus.com/reference/stack/stack/](http://www.cplusplus.com/reference/stack/stack/). As usual, please feel free to let me know if you find any flaws or bugs in my implementation!

## Queue

```php
<?php

// http://www.cplusplus.com/reference/queue/queue/

class Queue {
	private $_queue = array();

	public function size() {
		return count($this->_queue);
	}

	public function front() {
		return end($this->_queue);
	}

	public function back() {
		return reset($this->_queue);
	}

	public function push($value = NULL) {
		array_unshift($this->_queue, $value);
	}

	public function pop() {
		return array_pop($this->_queue);
	}

	public function isEmpty() {
		return empty($this->_queue);
	}
}
```

## Stack

```php
<?php

// http://www.cplusplus.com/reference/stack/stack/

class Stack {
	private $_stack = array();

	public function size() {
		return count($this->_stack);
	}

	public function top() {
		return end($this->_stack);
	}

	public function push($value = NULL) {
		array_push($this->_stack, $value);
	}

	public function pop() {
		return array_pop($this->_stack);
	}

	public function isEmpty() {
		return empty($this->_stack);
	}
}
```