---
author: user
title: Zero-Copy in Linux with sendfile() and splice()
slug: zero-copy-in-linux-with-sendfile-and-splice
id: 1071
date: '2010-06-01 11:23:15'
layout: single
categories:
  - Linux
tags:
  - linux
  - sendfile
  - splice
  - zerocopy
---

[![A Splice](images/splice240.jpg "A Splice"){: .align-left}](http://en.wikipedia.org/wiki/File:Kurzspleiss.jpg)

After [my recent excursion](http://blog.superpat.com/2010/05/04/a-simple-block-driver-for-linux-kernel-2-6-31/) to Kernelspace, I'm back in Userland working on a server process that copies data back and forth between a file and a socket. The traditional way to do this is to copy data from the source file descriptor to a buffer, then from the buffer to the destination file descriptor - like this:

```
// do_read and do_write are simple wrappers on the read() and 
// write() functions that keep reading/writing the file descriptor
// until all the data is processed.
do_read(source_fd, buffer, len);
do_write(destination_fd, buffer, len);

```

While this is very simple and straightforward, it is somewhat inefficient - we are copying data from the kernel buffer for source_fd into a buffer located in user space, then immediately copying it from that buffer to the kernel buffers for destination_fd. We aren't examining or altering the data in any way - buffer is just a bit bucket we use to get data from a socket to a file or vice versa. While working on this code, a colleague clued me in to a better way of doing this - [zero-copy](http://en.wikipedia.org/wiki/Zero_copy).

As its name implies, zero-copy allows us to operate on data without copying it, or, at least, by minimizing the amount of copying going on. [Zero Copy I: User-Mode Perspective](http://www.linuxjournal.com/article/6345) describes the technique, with some nice diagrams and a description of the [`sendfile()`](http://linux.die.net/man/2/sendfile) system call.

Rewriting my example above with sendfile() gives us the following:

```
ssize_t do_sendfile(int out_fd, int in_fd, off_t offset, size_t count) {
    ssize_t bytes_sent;
    size_t total_bytes_sent = 0;
    while (total_bytes_sent < count) {
        if ((bytes_sent = sendfile(out_fd, in_fd, &offset,
                count - total_bytes_sent)) <= 0) {
            if (errno == EINTR || errno == EAGAIN) {
                // Interrupted system call/try again
                // Just skip to the top of the loop and try again
                continue;
            }
            perror("sendfile");
            return -1;
        }
        total_bytes_sent += bytes_sent;
    }
    return total_bytes_sent;
}

//...

// Send 'len' bytes starting at 'offset' from 'file_fd' to 'socket_fd'
do_sendfile(socket_fd, file_fd, offset, len);

```

Now, as the man page states, there's a limitation here: "Presently (Linux 2.6.9 [and, in fact, as of this writing in June 2010]): in_fd, must correspond to a file which supports mmap()-like operations (i.e., it cannot be a socket); and out_fd must refer to a socket.". So, we can only use sendfile() for reading data _from_ our file and sending it _to_ the socket.

It turns out that sendfile() significantly outperforms read()/write() - I was seeing about 8% higher throughput on a fairly informal read test. Great stuff, but our write operations are still bouncing unnecessarily through userland. After some googling around, I came across [splice()](http://linux.die.net/man/2/splice), which turns out to be the primitive underlying sendfile(). An [lkml](http://www.tux.org/lkml/) thread back in 2006 carries [a detailed explanation of splice() from Linus himself](http://kerneltrap.org/node/6505), but the basic gist is that splice() allows you to move data between kernel buffers (via a pipe) with no copy to userland. It's a more primitive (and therefore flexible) system call than sendfile(), and requires a bit of wrapping to be useful - here's my first attempt to write data _from_ a socket _to_ a file:

```

// Our pipe - a pair of file descriptors in an array - see [pipe()](http://linux.die.net/man/2/pipe)
static int pipefd[2];

//...

ssize_t do_recvfile(int out_fd, int in_fd, off_t offset, size_t count) {
    ssize_t bytes, bytes_sent, bytes_in_pipe;
    size_t total_bytes_sent = 0;

    // Splice the data from in_fd into the pipe
    while (total_bytes_sent < count) {
        if ((bytes_sent = splice(in_fd, NULL, pipefd[1], NULL,
                count - total_bytes_sent, 
                SPLICE_F_MORE | SPLICE_F_MOVE)) <= 0) {
            if (errno == EINTR || errno == EAGAIN) {
                // Interrupted system call/try again
                // Just skip to the top of the loop and try again
                continue;
            }
            perror("splice");
            return -1;
        }

        // Splice the data from the pipe into out_fd
        bytes_in_pipe = bytes_sent;
        while (bytes_in_pipe > 0) {
            if ((bytes = splice(pipefd[0], NULL, out_fd, &offset, bytes_in_pipe,
                    SPLICE_F_MORE | SPLICE_F_MOVE)) <= 0) {
                if (errno == EINTR || errno == EAGAIN) {
                    // Interrupted system call/try again
                    // Just skip to the top of the loop and try again
                    continue;
                }
                perror("splice");
                return -1;
            }
            bytes_in_pipe -= bytes;
        }
        total_bytes_sent += bytes_sent;
    }
    return total_bytes_sent;
}

//...

// Setup the pipe at initialization time
if ( pipe(pipefd) < 0 ) {
    perror("pipe");
    exit(1);
}

//...

// Send 'len' bytes from 'socket_fd' to 'offset' in 'file_fd'
do_recvfile(file_fd, socket_fd, offset, len);

```

This _almost_ worked on my system, and it may work fine on yours, but there is a [bug in kernel 2.6.31](http://permalink.gmane.org/gmane.linux.network/138828) that makes the first splice() call hang when you ask for all of the data on the socket. The [Samba](http://www.samba.org/) guys [worked around this](http://git.samba.org/?p=samba.git;a=commitdiff;h=e1459a237948c2c9b7da94e4ba0acc79b1cd8eca) by simply limiting the data read from the socket to 16k. Modifying our first splice call similarly fixes the issue:

```
    if ((bytes_sent = splice(in_fd, NULL, pipefd[1], NULL,
            MIN(count - total_bytes_sent, 16384), 
            SPLICE_F_MORE | SPLICE_F_MOVE)) <= 0) {

```

I haven't benchmarked the 'write' speed yet, but, on reads, splice() performed just a little slower than sendfile(), which I attribute to the additional user/kernel context switching, but, again, significantly faster than read()/write().

As is often the case, I'm merely [standing on the shoulders of giants](http://en.wikipedia.org/wiki/Standing_on_the_shoulders_of_giants) here, collating hints and fragments, but I hope you find this post useful!