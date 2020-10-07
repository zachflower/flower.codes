---
layout: post
title:  "Writing Messages on the GitHub Calendar"
date:   2016-07-14 12:00:00
permalink: writing-messages-on-the-github-calendar
---
You know the contributions calendar grid on GitHub profiles? The one with all the pretty green squares? What if you could write a message within that box? That’s exactly what a friend of mine asked me a few months ago.

At first, it seemed like a silly question, because even if you could backdate commit messages in Git (which, it turns out, you could), GitHub surely only considers the date commits are pushed, not when they are created.

Well... I was wrong.

## tl;dr

If you’d rather just skip this writeup and check out the code, head on over to the public GitHub project page at [https://github.com/zachflower/marquee](https://github.com/zachflower/marquee).

## Initial Tests

The first thing I did to answer the initial question was to determine if I could backdate commit messages in git. After some basic Google-fu, I came across this little snippet:

```
GIT_AUTHOR_DATE=’YYYY-MM-DD’ GIT_COMMITTER_DATE=’YYYY-MM-DD’ git commit
```

Basically, what that line does is set the date of a commit message before actually committing. Knowing that I could backdate commits, my next step was to determine if GitHub honors historical commit dates. So, I ran some tests on a fresh GitHub repository, choosing a date in the past that had no commits associated with it.

And, guess what? It worked! Any backdated commits are properly processed and drawn on the corresponding date on the GitHub calendar matrix. Furthermore, when deleting a repository, the graph is properly updated (which let me run a ton of tests without mucking up the graph too much).

So, knowing that I could color in any square on the contributor graph that I want, I knew that writing messages to the graph is not only possible, it’s relatively easy!

## Problem Solving

Writing messages to the GitHub contributor graph is accomplished in 3 steps: create the calendar matrix, parse the message into a 5×7 typeface, and write out commit messages for the corresponding graph message.

### Calendar Matrix

The first step is building a calendar matrix that maps to the GitHub calendar perfectly. There are a few rules to this, the first being that the GitHub calendar encompasses exactly one year and one day. Knowing this, all we have to do is grab the dates for the last year, and map them to a multidimensional array with the same number of columns and rows as the GitHub calendar.

```javascript
function setupCalendar() {
  var today = new Date();
  var start = new Date();

  start.setYear(today.getFullYear() - 1);

  var dates = [];

  // if the first day on the grid isn't sunday, start with the following sunday
  if ( start.getDay() !== 0 ) {
    start.setDate(start.getDate() - (start.getDay() + 1) + 7);
  }

  for ( var w = 0; w < 52; w++ ) {
    for ( var d = 0; d < 7; d++ ) {
      if ( typeof dates[d] === 'undefined' ) {
        dates[d] = [];
      }

      dates[d][w] = new Date(start.setDate(start.getDate() + 1));
    }
  }

  return dates;
}
```

If you read the code above carefully, you’ll see that I skip the first week if the first date isn’t a Sunday. The reason I do this is that I don’t want any text I’m writing to be cut off by a half-week (GitHub doesn’t show the cells of the grid earlier than one year ago, so they can’t be colored in).

### Message Parsing

Parsing the message itself is trivial, but the biggest challenge was creating a typeface to accommodate an array of 5×7 cells. After some research, I came across the [TI-84 Calculator Typeface](http://fontstruct.com/fontstructions/show/ti_84_basic_calculator), which I then created a [character map object](https://github.com/zachflower/marquee/blob/master/charmap.js) that maps input characters to a corresponding 5×7 matrix display. To keep things readable, I chose to mark “on” cells as 1, and “off” cells as 0.

After mapping input text to the new typeface, I needed to then map the message to a matrix of the same size as the calendar grid.

```javascript
function parseMessage(message) {
  var grid = [
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
  ];

  // split the message into an array of characters
  message = message.split("");
  var pos = 0;

  for ( var l = 0; l < message.length; l++ ) {
    var character = message[l];

    // only write out characters in the charmap
    if ( typeof charmap[character] === 'undefined' ) {
      continue;
    }

    for ( var x = 0; x < 5; x++ ) {
      for ( var y = 0; y < 7; y++ ) {
        if ( typeof grid[y][pos] !== 'undefined' ) {
          grid[y][pos] = charmap[character][y][x];
        }
      }
      pos++;
    }
    // skip a column after every character for readability
    pos++;
  }

  return grid;
}
```

As you can see, I simply built a grid in a similar fashion as the character map, with 0 cells meaning “off” and 1 cells meaning “on.” After mapping a character to the grid, I then skip one column in order to increase readability of the message.

### Writing Commits

Now that we have a calendar matrix, and a message matrix, the next and final step is to simply find the intersection of the two matrices. The basic idea is that whenever a cell in the message matrix is 1, we should grab the date from the corresponding cell in the calendar matrix and perform a commit using the custom date method mentioned above.

```javascript
function writeCommits(message) {
  var dates = setupCalendar();
  var grid = parseMessage(message);

  exec("git init");

  for ( var i = 0; i < 7; i++ ) {
    for ( var j = 0; j < grid[i].length; j++ ) {
      if ( grid[i][j] == 1 ) {
        fs.writeFileSync("marquee.log", dates[i][j] + "\n", {'flag':'a'});
        exec("git add marquee.log");
        exec("GIT_AUTHOR_DATE='" + dates[i][j] + "' GIT_COMMITTER_DATE='" + dates[i][j] + "' git commit -m '" + dates[i][j] + "'");
      }
    }
  }
}
```

Because this is a git repository, some sort of file needs to change, so I set the script to write the “on” dates to a log file and commit the file after every change (which had the added benefit of allowing me to do some quick debugging of the date mapping as I went).

## Putting It All Together

Now that I have a script that I can use to write messages to the GitHub matrix, I needed to put it all together into a relatively easy-to-use script that I could use to write any message I want. I chose Node.js because, well, I wanted to learn how to create and publish a command line app in Node.js. After setting up my package and publishing it, I was left with an application with simple syntax:

```
marquee 'Hi there'
```

Which resulted in a neat little update to my personal GitHub calendar matrix like so:

![Hi there]({{ site.url }}/assets/posts/hi-there.png)


If you’d like to try this on your own GitHub account, simply install using the following command:

```
npm install github-marquee
```

Keep in mind that it would be a **really bad idea** to run this command on an existing git repository. You should always create a new repository in GitHub, as this will muck with the commit history of any existing one.
