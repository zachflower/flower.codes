---
layout: post
title: A Linked List Implementation in PHP
date: 2014-06-12 12:00:00
permalink: php-linked-list-implementation
---
For the past few weeks, I have been going through the process of applying and interviewing with some amazing companies, the most exciting of which has been Facebook. Interviewing with Facebook has been an incredible experience which has challenged my knowledge of software development and computer science in so many new ways. Throughout this whole process, I have been spending a lot of time getting back up to speed with some of my computer science fundamentals.

Unfortunately, my primary language is PHP, and many of the traditional computer science data structures do not exist in PHP. Because of this, I’ve decided to implement my own versions of these classic classes, both for the sake of practice, as well as furthering my understanding about the implementation of how they work.

The first class that I will be implementing is the classic [linked list](https://en.wikipedia.org/wiki/Linked_list). Please feel free to provide any feedback on my implementation, especially any bugs or issues that I may not have caught!

```php
<?php

class Node {
	public $data = NULL;
	public $next = NULL;

	public function __construct($data = NULL) {
		$this->data = $data;
	}
}

class LinkedList implements Iterator {
	private $_firstNode = NULL;
	private $_current = NULL;
	private $_position = 0;
	private $_count = 0;

	/**
	 * Insert node at the beginning of the list.
	 */
	public function insertFirst($data = NULL) {
		$newNode = new Node($data);

		if ( $this->_firstNode !== NULL ) {
			$newNode->next = $this->_firstNode;
		}

		$this->_firstNode = &$newNode;

		$this->_count++;

		return TRUE;
	}

	/**
	 * Insert node at the end of the list.
	 */
	public function insertLast($data = NULL) {
		if ( $this->_firstNode === NULL ) {
			$this->insertFirst($data);
		} else {
			$newNode = new Node($data);

			$current = $this->_firstNode;

			while ( $current->next !== NULL ) {
				$current = $current->next;
			}

			$current->next = $newNode;

			$this->_count++;
		}

		return TRUE;
	}

	/**
	 * Insert node after the node that matches the query.
	 * Returns FALSE if no matching node can be found.
	 */
	public function insertAfter($query = NULL, $data = NULL) {
		$newNode = new Node($data);

		$current = $this->_firstNode;

		while ( $current->next !== NULL ) {
			$current = $current->next;

			if ( $current->data === $query ) {
				break;
			}
		}

		if ( $current !== NULL ) {
			if ( $current->next !== NULL ) {
				$newNode->next = $current->next;
			}

			$current->next = $newNode;

			return TRUE;
		}

		return FALSE;
	}

	/**
	 * Insert node before the node that matches the query.
	 * Returns FALSE if no matching node can be found.
	 */
	public function insertBefore($query = NULL, $data = NULL) {
		$newNode = new Node($data);

		if ( $this->_firstNode !== NULL ) {
			$previous = NULL;
			$current = $this->_firstNode;

			while ( $current->next !== NULL ) {
				if ( $current->data === $query ) {
					$newNode->next = $current;
					$previous->next = $newNode;
					$this->_count++;
					break;
				}

				$previous = $current;
				$current = $current->next;
			}
		}
	}

	/**
	 * Delete the first node in the list.
	 */
	public function deleteFirst() {
		if ( $this->_firstNode !== NULL ) {
			if ( $this->_firstNode->next !== NULL ) {
				$this->_firstNode = $this->_firstNode->next;
			} else {
				$this->_firstNode = NULL;
			}

			$this->_count--;

			return TRUE;
		}

		return FALSE;
	}

	/**
	 * Delete the last node in the list.
	 */
	public function deleteLast() {
		if ( $this->_firstNode !== NULL ) {
			if ( $this->_firstNode->next === NULL ) {
				$this->_firstNode = NULL;
			} else {
				$previous = NULL;
				$current = $this->_firstNode;

				while ( $current->next !== NULL ) {
					$previous = $current;
					$current = $current->next;
				}

				$previous->next = NULL;

				$this->_count--;
			}

			return TRUE;
		}

		return FALSE;
	}

	/**
	 * Delete the node that matches the query.
	 */
	public function delete($query = NULL) {
		if ( $this->_firstNode !== NULL ) {
			$previous = NULL;
			$current = $this->_firstNode;

			while ( $current->next !== NULL ) {
				if ( $current->data === $query ) {
					if ( $previous === NULL ) {
						$this->_firstNode = $current->next;
					} else {
						$previous->next = $current->next;
					}

					$this->_count--;

					return TRUE;
				}

				$previous = $current;
				$current = $current->next;
			}
		}

		return FALSE;
	}

	/**
	 * Delete all matching nodes.
	 */
	public function deleteAll($query = NULL) {
		if ( $this->_firstNode !== NULL ) {
			$previous = NULL;
			$current = $this->_firstNode;

			while ( $current->next !== NULL ) {
				if ( $current->data === $query ) {
					if ( $previous === NULL ) {
						$this->_firstNode = $current->next;
						$current = $this->_firstNode;
						continue;
					} else {
						$previous->next = $current->next;
					}

					$this->_count--;
				}

				$previous = $current;
				$current = $current->next;
			}
		}

		return FALSE;
	}

	/**
	 * Reverse the list.
	 */
	public function reverse() {
		if ( $this->_firstNode !== NULL ) {
			if ( $this->_firstNode->next !== NULL ) {
				$reversed = $temp = NULL;
				$current = $this->_firstNode;

				while ( $current !== NULL ) {
					$temp = $current->next;

					$current->next = $reversed;
					$reversed = $current;

					$current = $temp;
				}

				$this->_firstNode = $reversed;
			}
		}
	}

	/**
	 * Sort the list in ascending order.
	 */
	public function sort() {
		if ( $this->_firstNode !== NULL ) {
			if ( $this->_firstNode->next !== NULL ) {
				for ( $i = 0; $i < $this->_count; $i++ ) {
					$temp = NULL;
					$current = $this->_firstNode;

					while ( $current !== NULL ) {
						if ( $current->next !== NULL && $current->data > $current->next->data ) {
							$temp = $current->data;
							$current->data = $current->next->data;
							$current->next->data = $temp;
						}

						$current = $current->next;
					}
				}
			}
		}
	}

	/**
	 * Get the nth element in the list.
	 */
	public function getNthElement($n = 0) {
		if ( $this->_firstNode !== NULL && $n <= $this->_count ) {
			$current = $this->_firstNode;

			for ( $i = 0; $i < $n; $i++ ) {
				$current = $current->next;
			}

			return $current;
		}

		return FALSE;
	}

	/**
	 * Get the nth element from the end in the list.
	 */
	public function getNthElementFromLast($n = 0) {
		if ( $this->_firstNode !== NULL && $n <= $this->_count ) {
			$current = $this->_firstNode;

			for ( $i = 0; $i < $this->_count - $n - 1; $i++ ) {
				$current = $current->next;
			}

			return $current;
		}

		return FALSE;
	}

	/**
	 * Get size of the list
	 */
	public function size() {
		return $this->_count;
	}

	/*
	 * Iterator Implementation
	 */
	public function rewind() {
		$this->_position = 0;
		$this->_current = $this->_firstNode;
	}

	public function current() {
		return $this->_current->data;
	}

	public function key() {
		return $this->_position;
	}

	public function next() {
		$this->_position++;
		$this->_current = $this->_current->next;
	}

	public function valid() {
		return $this->_current !== NULL;
	}
}
```