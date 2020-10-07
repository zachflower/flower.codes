---
layout: post
title:  "Introducing Eloquent Interactions: A Command Pattern Implementation for Laravel"
date:   2018-03-09 10:00:00
permalink: introducing-eloquent-interactions-a-command-pattern-implementation-for-laravel
---

A couple years ago, I was working on a monolithic Ruby on Rails codebase that was fast approaching unmaintainability. In a month-long sprint of desperation, we hit the books and decided to come up with a plan. The solution to our problem arrived in the form of [ActiveInteraction](https://github.com/AaronLasseigne/active_interaction), a Ruby implementation of the command pattern. For the uninitiated, the command pattern is a "behavioral design pattern in which an object is used to encapsulate all information needed to perform an action or trigger an event at a later time." _Thanks [Wikipedia](https://en.wikipedia.org/wiki/Command_pattern)!_ In other words, small, discrete chunks of business logic are encapsulated into single-purpose singleton objects (e.g. there is only one `ConvertMetersToMiles` object).

Well, it's been a few years, and I am no longer a Ruby developer, but I still yearn for the simplicity ActiveInteraction created. To help scratch that itch, I decided to create a simple port of ActiveInteraction for the Laravel PHP framework called [Eloquent Interactions](https://github.com/zachflower/eloquent-interactions). But, before we dig into Eloquent Interactions, let's first take a look at "the problem" as I see it.

## The Problem

The major advantage to the command pattern is that it encourages the creation of highly testable units of code. Rather than writing tests for each method in a bloated model, or something more all encompassing in a too-big-to-not-fail controller, discrete and detailed tests can be written for each individual command—or interaction, in the language of the ActiveInteraction library. By abstracting core business logic out of the models and controllers, the codebase becomes immediately slimmer and more readable.

### The Too-Big-To-Not-Fail Controller

As an example, let's take a look at a _very_ basic Laravel account registration controller that accepts some basic user information, generates a unique affiliate ID for the new user, and then creates the new user account:

```php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Cookie;
use App\Models\User;

class BasicController extends Controller {

  /**
   * @return \Illuminate\Http\Response
   */
  public function register(Request $request) {
    $request->validate($request, [
      'name' => 'required|string|max:255',
      'email' => 'required|string|email|max:255|unique:users',
      'password' => 'required|string|min:6',
      'dob' => 'required|date|before:18 years ago'
    ]);

    do {
      $affiliate_id = str_random(10);
    } while ( User::where('affiliate_id', $affiliate_id)->first() );

    $user = User::create([
      'name' => $data['name'],
      'email' => $data['email'],
      'password' => bcrypt($data['password']),
      'dob' => Carbon::parse($data['dob']),
      'affiliate_id' => $affiliate_id,
    ]);

    return [
      'success' => TRUE,
      'user' => $user
    ];
  }
}
```

It's not _too_ complicated, right?

Well, imagine if you have to add more "steps" to the process (for whatever reason). Maybe we want to track the referring user here and then shoot off a notification to them, or we need to register the user's email with a third-party CRM. This relatively basic controller can grow pretty quickly, and the more logic added to it, the more difficult it is to test it. And sure, while you can abstract these pieces of functionality into `private` or `protected` controller methods, that doesn't make them very testable—and isn't exactly very DRY either, if you have to make the same calculations elsewhere. While you _can_ find a workaround, the ultimate problem is that **business logic just doesn't belong in the controller**. Controllers should be used to "control" (see what I did there?) the flow of execution and not get involved with the actual work being done.

### The Bloated Model

Now, let's say that the basic controller above _already_ feels a bit too chunky. One practice that happens quite often is abstracting the business logic out into relevant models. For example, the affiliate ID generation could be found in the `User` model:

```php
namespace App\Models;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Cookie;

class User extends Authenticatable {

    use Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['name', 'email', 'password', 'remember_token', 'dob', 'affiliate_id'];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
      'password', 'remember_token'
    ];

    /**
     * The attributes that should be mutated to dates.
     *
     * @var array
     */
    protected $dates = [
      'created_at',
      'updated_at',
      'deleted_at',
      'dob',
    ];

    /*
    |--------------------------------------------------------------------------
    | FUNCTIONS
    |--------------------------------------------------------------------------
    */

    public static function generateAffiliateId() {
      do {
        $affiliate_id = str_random(10);
      } while ( User::where('affiliate_id', $affiliate_id)->first() );

      return $affiliate_id;
    }
}
```

With these changes, our controller starts to look a _little_ less business logicky:

```php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class BasicController extends Controller {

  /**
   * @return \Illuminate\Http\Response
   */
  public function register(Request $request) {
    $request->validate($request, [
      'name' => 'required|string|max:255',
      'email' => 'required|string|email|max:255|unique:users',
      'password' => 'required|string|min:6',
      'dob' => 'required|date|before:18 years ago'
    ]);

    $user = User::create([
      'name' => $data['name'],
      'email' => $data['email'],
      'password' => bcrypt($data['password']),
      'dob' => Carbon::parse($data['dob']),
      'affiliate_id' => User::generateAffiliateId(),
    ]);

    return [
      'success' => TRUE,
      'user' => $user
    ];
  }
}
```

But, we can do better. One thing that hasn't been addressed here is validation. While the `Request` object has a built-in validator, those validations should be within the abstracted methods, not just the top-level controller. And while you may be thinking that Laravel has a `Validator` object that can be used on its own anywhere in the codebase, it can feel clunky to repeat it in every function definition, and still doesn't solve the problem if keeping the controllers as light as possible. Also, much like the controllers, **business logic does not belong in the model**. The model is intended to be an object-oriented representation of a dataset. That's all. Putting business logic in it may feel more organized, but it goes counter to the _intended_ use of these classes.

## Introducing Eloquent Interactions

Enter Eloquent Interactions. While this library is heavily inspired by ActiveInteraction, it solves the very same problem that I have with the Laravel codebase: the organization of business logic. Don't get me wrong, I love Laravel, but properly organizing monolithic codebases is _hard_, so a library implementation of a well-defined design pattern seemed like a no-brainer. To illustrate how Eloquent Interactions helps maintain clean controllers and models, let's refactor our example above into an interaction-based solution:

### The Interactions

First, let's consider the different interactions we are performing during our user creation example: generating an affiliate ID and creating a new user entry. While we could abstract the controller down into a few more interactions (hashing the password, for example), let's just stick with these two for now. To start, let's look at a simple interaction that generates an affiliate ID:

```php
namespace App\Interactions;

use EloquentInteractions\Interaction;
use App\Models\User;

class GenerateAffiliateId extends Interaction {

  /**
    * Execute the interaction
    *
    * @return void
    */
  public function execute() {
    do {
      $affiliate_id = str_random(10);
    } while ( User::where('affiliate_id', $affiliate_id)->first() );

    return $affiliate_id;
  }
}
```

Simple enough, right?

Now, let's create an interaction that actually creates the user account (this one is only slightly more complicated):

```php
namespace App\Interactions;

use EloquentInteractions\Interaction;
use App\Model\User;

class CreateUser extends Interaction {

  /**
    * Parameter validations
    *
    * @var array
    */
  public $validations = [
    'name' => 'required|string|max:255',
    'email' => 'required|string|email|max:255|unique:users',
    'password' => 'required|string|min:6',
    'dob' => 'required|date|before:18 years ago',
    'affiliate_id' => 'required|unique:users,affiliate_id'
  ];

  /**
    * Execute the interaction
    *
    * @return void
    */
  public function execute() {
    return User::create([
      'name' => $this->name,
      'email' => $this->password,
      'password' => bcrypt($this->password),
      'dob' => $this->dob,
      'affiliate_id' => $this->affiliate_id,
    ]);
  }
}
```

As you can see, Eloquent Interactions takes advantage of Laravel's `Validator` class to provide built-in validation of all parameters passed into an interaction. This allows you to validate input _every_ time it is used in a clean, and consistent way, without having to double up request validation.

### The Controller

Given the interactions above, let's next look at how to clean up the controller with them:


```php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Interactions\GenerateAffiliateId;
use App\Interactions\CreateUser;

class BasicController extends Controller {

  /**
   * @return \Illuminate\Http\Response
   */
  public function register(Request $request) {
    $affiliate_id = GenerateAffiliateId::run([], TRUE);

    $outcome = CreateUser::run([
      'name' => $request->input('name'),
      'email' => $request->input('email'),
      'password' => $request->input('password'),
      'dob' => $request->input('dob'),
      'affiliate_id' => $affiliate_id,
    ]);

    if ( $outcome->valid ) {
      return [
        'success' => TRUE,
        'user' => $outcome->result
      ];
    }

    return [
      'success' => FALSE,
      'errors' => $outcome->errors->toArray()
    ];
  }
}
```

Okay, let's unpack this. As you can see, the `affiliate_id` is generated using the new `GenerateAffiliateId` interaction, but what are the parameters? Because PHP doesn't support Ruby's `!` method suffix, the second parameter passed to an interaction is a boolean that defines whether or not the interaction should be run "dangerously." Basically, when `TRUE`, the interaction will return the result directly, and throw errors as exceptions. This is a common pattern for interactions that shouldn't experience _any_ errors (or if the errors should halt all execution immediately).

The more common pattern is the `CreateUser` interaction. In a nutshell, every interaction returns an `Outcome` object that contains the following properties:

- `$valid` - `FALSE` if any validation errors were encountered, `TRUE` if not.
- `$result` - This is the return value from the interaction's `execute()` method. This will be `NULL` if any errors are returned.
- `$errors` - This is a collection of validation errors (if any). Check [the docs](https://github.com/zachflower/eloquent-interactions) for more details on how to add custom errors.

Now, one thing to note here is that while interactions can create more _lines of code_ in a controller, the controllers flow of execution will be significantly more readable. Interactions aren't exactly intended to make you write _less_ code (although it is a positive side effect of more complex controllers), but they are intended to help you write _smarter_ code.

## Conclusion

I've been using Eloquent Interactions privately for over a year now, and couldn't be more excited to finally have an open source release that others might find some value in as well. If you would like to contribute, check out the documentation, or raise an issue with the library, head on over to [Eloquent Interactions on GitHub](https://github.com/zachflower/eloquent-interactions).