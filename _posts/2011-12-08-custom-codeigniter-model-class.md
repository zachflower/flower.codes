---
layout: post
title: Custom CodeIgniter Model Class
date: 2011-12-08 12:00:00
---
For the past year, I have been an adamant CodeIgniter developer. The one thing that I have found lacking, however, is CodeIgniter’s model class. I am a big fan of the simplicity of CakePHP’s ORM structure, and wrote this model class to (slightly) mimic it. Some of the functionality in this extended model is inspired by Emran Hasan’s [CodeIgniter Extended Model Class](https://archive.phpfour.com/updated-http-class-extended-model-codeigniter-cross-domain-ajax-php/).

**Note: PHP >=5.3.4 Required**

## Installation

To install this extended model class, copy the code below into the `MY_Model.php` in the `application/core/` directory.

```php
<?php

class MY_Model extends CI_Model{
    /**
     * The table name
     *
     * @var string
     * @access protected
     */
    protected $table = '';

    /**
     * The table's primary key
     *
     * @var string
     * @access protected
     */
    protected $primary_key = 'id';

    /**
     * The current object's id
     *
     * @var int
     * @access protected
     */
    protected $id = null;

    /**
     * The current object's data
     *
     * @var array
     * @access protected
     */
    protected $vals = array();

    /**
     * The table's field names
     *
     * @var array
     * @access protected
     */
    protected $fields = array();

    /**
     * The current object's data
     *
     * @var array
     * @access protected
     */
    protected $extra = array();

    /**
     * Constructor
     *
     * @access public
     */
    public function __construct($vals = NULL){
        parent::__construct();

        if($this->table != ''){
            $this->fields = $this->CI()->db->list_fields($this->table);
        }

        if(is_array($vals)) {
            $this->vals = array();

            foreach($vals as $key => $value) {
                if(in_array($key, $this->fields)){
                    $this->vals[$key] = $value;
                } else {
                    $this->extra[$key] = $value;
                }
            }

            if(array_key_exists($this->primary_key, $this->vals)) {
                $this->id = $this->vals[$this->primary_key];
            }
        }
    }


    /**
     * Function to access the CodeIgniter Instance
     *
     * @access public
     */
    public static function &CI() { return get_instance(); }

    /**
     * Insert entry into the database.
     *
     * @return entry object
     * @access public
     */
    public function insert($parameters){
        if (!$this->CI()->db->table_exists($this->table)) {
            throw new Exception("Table does not exist.");
        } else {
            foreach($parameters as $key=>$param){
                if(!in_array($key, $this->fields)){
                    unset($parameters[$key]);
                }
            }

            if($this->CI()->db->insert($this->table, $parameters)){
                $this->id = $this->CI()->db->insert_id();
                $query = $this->CI()->db->get_where($this->table, array($this->primary_key => $this->id));
                $result = $query->result_array();
                $result = $result[0];

                if($class = get_called_class()) {
                    $obj = new $class($result);
               
                    return($obj);
                } else {
                    throw new Exception("Model class not found.");
                }
            } else {
                throw new Exception("Could not insert into table.");
            }
        }
    }

    /**
     * Save current object to the database.
     *
     * @return entry object
     * @access public
     */
    public function save(){
        if($this->CI()->db->update($this->table, $this->vals, array($this->primary_key => $this->id))){
            if($query = $this->CI()->db->get_where($this->table, array($this->primary_key => $this->id))){
                $result = $query->result_array();
                $result = $result[0];

                if($class = get_called_class()) {
                    $obj = new $class($result);

                    return($obj);
                } else {
                    throw new Exception("Model class not found.");
                }
            } else {
                throw new Exception("Unable to find record.");
            }
        } else {
            throw new Exception("Unable to update record.");
        }
    }

    /**
     * Delete current object from the database.
     *
     * @return object
     * @access public
     */
    public function delete(){
        return $this->CI()->db->delete($this->table, array($this->primary_key => $this->id));
    }

    /**
     * Grab the total results of a find query.
     *
     * @return int
     * @access public
     */
    public function findCount($params = NULL){
        $response = $this->find($params, "COUNT(*) as count");
        return $response->extra['count'];
    }

    /**
     * Returns an array of objects based on given query parameters.
     *
     * @return object array
     * @access public
     */
    public function findAll($params = NULL, $fields = "*", $orderby = NULL, $groupby = NULL, $limit = NULL){
        if(isset($orderby) && $orderby != NULL){
            if(is_string($orderby)) {
                $this->CI()->db->order_by($groupby);
            } else if(is_array($orderby) || is_object($orderby)) {
                foreach((array)$orderby as $key=>$value){
                    $this->CI()->db->order_by($key, $value);
                }
            } else {
                throw new Exception("Invalid order by type.");
            }
        }

        if(isset($groupby) && $groupby != NULL){
            if(is_string($groupby)) {
                $this->CI()->db->group_by($groupby);
            } else if(is_array($groupby) || is_object($groupby)) {
                $this->CI()->db->group_by((array)$groupby);
            } else {
                throw new Exception("Invalid group by type.");
            }
        }

        if(isset($limit) && $limit != NULL){
            if(is_int($limit)) {
                $this->CI()->db->limit($limit);
            } else if(is_array($limit) || is_object($limit)) {
                $limit = (array)$limit;
                $this->CI()->db->limit($limit[0], $limit[1]);
            } else {
                throw new Exception("Invalid limit type.");
            }
        }

        if(!isset($fields) || $fields == NULL || $fields == "*"){
            $fields = "*";
            $this->CI()->db->select($fields);
        } else if(is_string($fields)) {
            $this->CI()->db->select($fields);
        } else if(is_array($fields)) {
            $fields = implode(",", $fields);
            $this->CI()->db->select($fields);
        } else {
            throw new Exception("Invalid fields type.");
        }

        if(!isset($params) || $params == NULL){
            $query = $this->CI()->db->get($this->table);
        } else if(is_scalar($params)) {
            $query = $this->CI()->db->get_where($this->table, array($this->primary_key => $params));
            $this->id = $params;
        } else if(is_array($params) || is_object($params)) {
            $query = $this->CI()->db->get_where($this->table, (array)$params);
        } else {
            throw new Exception("Invalid primary key type.");
        }

        if($query->num_rows > 0){
            $results = $query->result_array();
            $objects = array();

            foreach($results as $result){
                if($class = get_called_class()) {
                    $obj = new $class($result);

                    $objects[] = $obj;
                } else {
                    throw new Exception("Model class not found.");
                }
            }

            return $objects;
        } else {
            return false;
        }
    }

    /**
     * Return an object containing one result based on the given query.
     *
     * @return object
     * @access public
     */
    public function find($params = NULL, $fields = NULL){
        if(!isset($fields) || $fields == NULL || $fields == "*"){
            $fields = "*";
            $this->CI()->db->select($fields);
        } else if(is_string($fields)) {
            $this->CI()->db->select($fields);
        } else if(is_array($fields)) {
            $fields = implode(",", $fields);
            $this->CI()->db->select($fields);
        } else {
            throw new Exception("Invalid fields type.");
        }

        if(!isset($params) || $params == NULL){
            $query = $this->CI()->db->order_by($this->primary_key." DESC")->limit(1)->get($this->table);
        } else if(is_scalar($params)) {
            $query = $this->CI()->db->get_where($this->table, array($this->primary_key => $params));
            $this->id = $params;
        } else if(is_array($params) || is_object($params)) {
            $query = $this->CI()->db->get_where($this->table, (array)$params);
        } else {
            throw new Exception("Invalid primary key type.");
        }
       
        if($query->num_rows > 0){
            $result = $query->result_array();
            $result = $result[0];

            if($class = get_called_class()) {
                $obj = new $class($result);

                return($obj);
            } else {
                throw new Exception("Model class not found.");
            }
        } else {
            return false;
        }
    }

    /**
     * Set data array values.
     * Reference: http://php.net/manual/en/language.oop5.overloading.php
     *
     * @access public
     */
    public function __set($name, $value) {
        if(array_search($name, $this->fields) !== FALSE) {
            $this->vals[$name] = $value;

            if($name == $this->primary_key)
                $this->id = $value;

            return;
        }

        $this->$name = $value;
    }

    /**
     * Get values from the data array.
     * Reference: http://www.php.net/manual/en/language.oop5.overloading.php#97918
     *
     * @return reference value
     * @access public
     */
    public function &__get($name) {
        $f = null;

        if(array_search($name, $this->fields) !== FALSE) {
            return $this->vals[$name];
        } else {
            return $f;
        }
    }
}
```

## Usage

The usage of this model class is very simple. The first step is to create a CodeIgniter model. The simplest version of this is shown below.

```php
<?php

class SampleModel extends MY_Model{
    protected $_table = 'mysql_table';
}
```

It is important that your model extends `MY_Model`, not `CI_Model`. After the model has been created, you can load it just like any other model in CodeIgniter.

```php
<?php

$this->load->model('SampleModel');
```

Using the model is very simple as well, here is a list of functionality contained within this model class.

```php
<?php

// Insert values into table.
$sample = $this->SampleModel->insert(array('column_name'=>'value_1', 'column_name_2'=>'value_2));

// Modify inserted value.
$sample->column_name = 'new_value;
$sample->save();

// Find one record matching a specific criteria. Returns one object.
$sample = $this->SampleModel->find(array('column_name'=>'value_1'));

// Delete a record.
$sample->delete();

// Find all records matching a specific criteria. Returns array of objects.
$sample = $this->SampleModel->findAll(array('column_name'=>'value_1'));

// Count all records matching a specific criteria. Returns an integer.
$count = $this->SampleModel->findCount(array('column_name'=>'value_1'));
```