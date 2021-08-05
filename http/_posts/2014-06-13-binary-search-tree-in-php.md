---
layout: post
title: PHP Binary Search Tree Implementation
date: 2014-06-13 13:00:00
---
A [Binary Search Tree](http://en.wikipedia.org/wiki/Binary_search_tree) is an ordered binary tree that has the following rules:

- The left subtree always contains nodes that have a value less than the current node.
- The right subtree always contains nodes that have a value greater than the current node.
- Each subtree must also be binary trees ordered in the same way.
- There can be no duplicate nodes.

This is a quick PHP implementation of a binary search tree. It is fairly simplistic in design, providing insert, delete, and search functionality, and is based off of my [Linked List implementation](/linked-list-in-php.html). The usual call for review and bug fixes stands here.

```php
<?php

class Node {
	public $level = 1;
	public $data = NULL;
	public $left = NULL;
	public $right = NULL;

	public function __construct($data = NULL) {
		$this->data = $data;
	}
}

class BinarySearchTree {
	private $_topNode = NULL;
	private $_count = 0;
	private $_height = 1;

	/**
	 * Insert a value into the tree.
	 */
	public function insert($data = NULL) {
		$newNode = new Node($data);

		if ( $this->_topNode === NULL ) {
			$this->_topNode = &$newNode;
		} else {
			$current = $this->_topNode;

			while ( $current !== NULL ) {
				if ( $data < $current->data ) {
					$newNode->level++;

					if ( $current->left !== NULL ) {
						$current = $current->left;
					} else {
						$current->left = $newNode;
						break;
					}
				} else if ( $data > $current->data ) {
					$newNode->level++;

					if ( $current->right !== NULL ) {
						$current = $current->right;
					} else {
						$current->right = $newNode;
						break;
					}
				} else {
					return;
				}
			}
		}

		$this->_count++;
	}

	/**
	 * Delete a node from the tree.
	 *
	 * Source: http://www.algolist.net/Data_structures/Binary_search_tree/Removal
	 */
	public function delete($data = NULL) {
		$direction = NULL;
		$parent = NULL;
		$current = $this->_topNode;

		while ( $current !== NULL ) {
			if ( $data < $current->data ) {
				if ( $current->left !== NULL ) {
					$parent = $current;
					$direction = 'left';
					$current = $current->left;
				} else {
					return FALSE;
				}
			} else if ( $data > $current->data ) {
				if ( $current->right !== NULL ) {
					$parent = $current;
					$direction = 'right';
					$current = $current->right;
				} else {
					return FALSE;
				}
			} else {
				if ( $current->left === NULL && $current->right === NULL ) {
					if ( $parent !== NULL && $direction !== NULL ) {
						$parent->$direction = NULL;
					} else {
						$this->_topNode = NULL;
					}
				} else if ( $current->right !== NULL && ($current->left === NULL || $current->right->left === NULL) ) {
					if ( $parent !== NULL && $direction !== NULL ) {
						$parent->$direction = $current->right;
					} else {
						$this->_topNode = $current->right;
					}
				} else {
					$current->data = $this->popLeftmost($current->right);
				}

				$this->_count--;

				return TRUE;
			}
		}
	}

	/**
	 * Search the tree for a given value.
	 */
	public function search($data = NULL) {
		$current = $this->_topNode;

		while ( $current !== NULL ) {
			if ( $data < $current->data ) {
				if ( $current->left !== NULL ) {
					$current = $current->left;
				} else {
					return FALSE;
				}
			} else if ( $data > $current->data ) {
				if ( $current->right !== NULL ) {
					$current = $current->right;
				} else {
					return FALSE;
				}
			} else {
				return $current;
			}
		}
	}

	/**
	 * Return the size of the tree.
	 */
	public function size() {
		return $this->_count;
	}

	/** 
	 * Traverse down the left side of a node and pop the node off
	 * of the tree, returning the value.
	 */
	private function popLeftmost(&$node) {
		$parent = NULL;
		$current = $node;

		while ( $current->left !== NULL ) {
			$parent = $current;
			$current = $current->left;
		}

		$parent->left = NULL;
		$data = $current->data;

		return $data;
	}
}
```