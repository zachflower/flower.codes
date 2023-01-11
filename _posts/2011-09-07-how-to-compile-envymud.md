---
layout: post
title: How to Compile Envy MUD
date: 2011-09-07 12:00:00
---
I have always been fascinated with MUDs, also known as Multi-User Dungeons. They are the World of Warcraft before there was a world to craft war in. It’s an interesting mesh between computers and Dungeons and Dragons. Imagination is an important factor, and from my experience, they are a great place for beginning programmers to learn how to code. I first learned how to code in C by programming for a few MUDs.

Compiling your first MUD can be a scary experience, though. Many of the codebases are pre-y2k, thus making some of the processes obsolete. For this demonstration, I will be using the EnvyMUD source code. It is widely used enough that many people can relate to it, and being directly related to DIKUMUD, the processes will be very similar for other DIKU related subservers. The first step will be to download the MUD source code. You can get it from the [MUDBytes](http://www.mudbytes.net/file-172) codebase repository here. The version of Envy I will be using is **Envy 2.0** on a current Ubuntu server.

After downloading the Envy source code, you will need to un-tar and un-gzip it:

```sh
tar -xvzf envy-20.tar.gz
```

Next, navigate to the `src` directory:

```sh
cd ./Envy20/src/
```

Now the fun starts. Run the `make` command and see what happens:

```
$ make
gcc -c -O -Wall -g act_comm.c
gcc -c -O -Wall -g act_info.c
gcc -c -O -Wall -g act_move.c
act_move.c: In function 'move_char':
act_move.c:230: warning: suggest explicit braces to avoid ambiguous 'else'
gcc -c -O -Wall -g act_obj.c
gcc -c -O -Wall -g act_wiz.c
act_wiz.c: In function 'do_sset':
act_wiz.c:2296: warning: suggest explicit braces to avoid ambiguous 'else'
gcc -c -O -Wall -g comm.c
comm.c:162: error: conflicting types for 'accept'
/usr/include/sys/socket.h:214: note: previous declaration of 'accept' was here
comm.c:163: error: conflicting types for 'bind'
/usr/include/sys/socket.h:115: note: previous declaration of 'bind' was here
comm.c:165: error: conflicting types for 'getpeername'
/usr/include/sys/socket.h:133: note: previous declaration of 'getpeername' was here
comm.c:166: error: conflicting types for 'getsockname'
/usr/include/sys/socket.h:119: note: previous declaration of 'getsockname' was here
comm.c:169: error: conflicting types for 'read'
/usr/include/bits/unistd.h:35: note: previous definition of 'read' was here
comm.c:173: error: conflicting types for 'write'
/usr/include/unistd.h:363: note: previous declaration of 'write' was here
comm.c: In function 'init_socket':
comm.c:440: warning: ignoring return value of 'system', declared with attribute warn_unused_result
comm.c:490: warning: ignoring return value of 'system', declared with attribute warn_unused_result
comm.c: In function 'nanny':
comm.c:1829: warning: comparison with string literal results in unspecified behavior
make: *** [comm.o] Error 1
```

These errors are caused by prototype functions that are no longer needed. To fix this, open up `comm.c` in your favorite text editor and navigate to line 161. There, you will comment out the following lines:

```
$ make
gcc -c -O -Wall -g act_comm.c
gcc -c -O -Wall -g act_info.c
gcc -c -O -Wall -g act_move.c
act_move.c: In function 'move_char':
act_move.c:230: warning: suggest explicit braces to avoid ambiguous 'else'
gcc -c -O -Wall -g act_obj.c
gcc -c -O -Wall -g act_wiz.c
act_wiz.c: In function 'do_sset':
act_wiz.c:2296: warning: suggest explicit braces to avoid ambiguous 'else'
gcc -c -O -Wall -g comm.c
comm.c:162: error: conflicting types for 'accept'
/usr/include/sys/socket.h:214: note: previous declaration of 'accept' was here
comm.c:163: error: conflicting types for 'bind'
/usr/include/sys/socket.h:115: note: previous declaration of 'bind' was here
comm.c:165: error: conflicting types for 'getpeername'
/usr/include/sys/socket.h:133: note: previous declaration of 'getpeername' was here
comm.c:166: error: conflicting types for 'getsockname'
/usr/include/sys/socket.h:119: note: previous declaration of 'getsockname' was here
comm.c:169: error: conflicting types for 'read'
/usr/include/bits/unistd.h:35: note: previous definition of 'read' was here
comm.c:173: error: conflicting types for 'write'
/usr/include/unistd.h:363: note: previous declaration of 'write' was here
comm.c: In function 'init_socket':
comm.c:440: warning: ignoring return value of 'system', declared with attribute warn_unused_result
comm.c:490: warning: ignoring return value of 'system', declared with attribute warn_unused_result
comm.c: In function 'nanny':
comm.c:1829: warning: comparison with string literal results in unspecified behavior
make: *** [comm.o] Error 1
```

Run `make` again and you should get a successful build:

```
$ make
gcc -c -O -Wall -g comm.c
comm.c: In function 'init_socket':
comm.c:440: warning: ignoring return value of 'system', declared with attribute warn_unused_result
comm.c:490: warning: ignoring return value of 'system', declared with attribute warn_unused_result
comm.c: In function 'new_descriptor':
comm.c:870: warning: pointer targets in passing argument 3 of 'getsockname' differ in signedness
/usr/include/sys/socket.h:119: note: expected 'socklen_t * __restrict__' but argument is of type 'int *'
comm.c:871: warning: pointer targets in passing argument 3 of 'accept' differ in signedness
/usr/include/sys/socket.h:214: note: expected 'socklen_t * __restrict__' but argument is of type 'int *'
comm.c:914: warning: pointer targets in passing argument 3 of 'getpeername' differ in signedness
/usr/include/sys/socket.h:133: note: expected 'socklen_t * __restrict__' but argument is of type 'int *'
comm.c: In function 'nanny':
comm.c:1829: warning: comparison with string literal results in unspecified behavior
gcc -c -O -Wall -g const.c
gcc -c -O -Wall -g db.c
gcc -c -O -Wall -g fight.c
gcc -c -O -Wall -g handler.c
gcc -c -O -Wall -g interp.c
interp.c:436:50: warning: trigraph ??' ignored, use -trigraphs to enable
interp.c:437:50: warning: trigraph ??' ignored, use -trigraphs to enable
interp.c:438:55: warning: trigraph ??' ignored, use -trigraphs to enable
interp.c:439:56: warning: trigraph ??' ignored, use -trigraphs to enable
interp.c:440:56: warning: trigraph ??' ignored, use -trigraphs to enable
gcc -c -O -Wall -g magic.c
gcc -c -O -Wall -g save.c
save.c: In function 'load_char_obj':
save.c:406: warning: ignoring return value of 'system', declared with attribute warn_unused_result
gcc -c -O -Wall -g special.c
gcc -c -O -Wall -g update.c
rm -f envy
gcc -O -lcrypt -o envy act_comm.o act_info.o act_move.o act_obj.o act_wiz.o comm.o const.o db.o fight.o handler.o interp.o magic.o save.o special.o update.o
```

Now, we need to start the game up. If you are on a modern Ubuntu version like I am, run the following:

```sh
nohup ./startupSH &
```

That’s it! You have just started your first MUD on port 4000! To log into your game from the localhost, just type the following:

```sh
telnet localhost 4000
```

Congratulations! You are officially an implementor!