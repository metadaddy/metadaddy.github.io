---
author: user
title: A Cup of tee() and a splice() of Cake
slug: a-cup-of-tee-and-a-splice-of-cake
id: 1092
date: '2010-07-08 17:13:33'
layout: single
categories:
  - Linux
tags:
  - linux
  - splice
  - tee
  - zerocopy
---

[!["A Cup of Tea and a Slice of Cake"](images/teacake.jpg "Credit to dajobe for the photo - click the image for the original"){: .align-left}](http://www.flickr.com/photos/dajobe/145598710/) Apologies for the terrible pun in the title - I just couldn't resist :-) I was hard at work on my current project the other day, a user-mode Linux server daemon, when I realized that I would need to both copy incoming data to disk _and_ forward it to another daemon via a socket. This caused me a moment's consternation, since I was using [splice()](http://blog.superpat.com/2010/06/01/zero-copy-in-linux-with-sendfile-and-splice/) to move incoming data from a socket to a file without needing an intermediate copy in a user-mode buffer, but then I remembered [mention of tee(), a companion to splice()](http://kerneltrap.org/node/6505). Where splice() moves data directly from a socket (or file) to a pipe (or vice versa), tee() copies data from one pipe to another _leaving the data intact in the source pipe_. You can then use splice() again to move the data from tee()'s destination pipe to another file descriptor.

It was the work of a few minutes to code up a quick sample app to test this. Since it's short, and there seems to be a dearth of tee()/splice() examples, here it is in its entirety:

```
#define _GNU_SOURCE // needed for splice
#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

static void test_splice(int in, int out, int out2, int number_of_bytes) {
    int rcvd = 0, sent = 0, teed = 0, remaining = number_of_bytes;
    int pipe1[2], pipe2[2];

    if (pipe(pipe1) < 0) {
        perror("pipe");
        exit(EXIT_FAILURE);
    }

    if (pipe(pipe2) < 0) {
        perror("pipe");
        exit(EXIT_FAILURE);
    }

    while (remaining > 0) {
        if ((rcvd = splice(in, NULL, pipe1[1], NULL, remaining,
                SPLICE_F_MORE | SPLICE_F_MOVE)) < 0) {
            perror("splice");
            exit(EXIT_FAILURE);
        }

        if (rcvd == 0) {
            printf("Reached end of input file\n");
            break;
        }

        printf("Wrote %d bytes to pipe1\n", rcvd);

        if ((teed = tee(pipe1[0], pipe2[1], rcvd, 0)) < 0) {
            perror("tee");
            exit(EXIT_FAILURE);
        }

        printf("Copied %d bytes from pipe1 to pipe2\n", teed);

        if ((sent = splice(pipe1[0], NULL, out, NULL, rcvd, SPLICE_F_MORE
                | SPLICE_F_MOVE)) < 0) {
            perror("splice");
            exit(EXIT_FAILURE);
        }

        printf("Read %d bytes from pipe1\n", sent);

        if ((sent = splice(pipe2[0], NULL, out2, NULL, teed, SPLICE_F_MORE
                | SPLICE_F_MOVE)) < 0) {
            perror("splice");
            exit(EXIT_FAILURE);
        }

        printf("Read %d bytes from pipe2\n", sent);

        remaining -= rcvd;
    }
}

int main(int argc, char *argv[]) {
    int infile, outfile1, outfile2, number_of_bytes = INT_MAX;

    if (argc < 4) {
        fprintf(stderr,
                "Usage: %s infile outfile1 outfile2 [number_of_bytes]\n",
                argv[0]);
        exit(EXIT_FAILURE);
    }

    if ((infile = open(argv[1], O_RDONLY)) < 0) {
        fprintf(stderr, "Can't open %s for reading\n", argv[1]);
        exit(EXIT_FAILURE);
    }

    if ((outfile1 = open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, 0644)) < 0) {
        fprintf(stderr, "Can't create/open %s for writing\n", argv[2]);
        exit(EXIT_FAILURE);
    }

    if ((outfile2 = open(argv[3], O_WRONLY | O_CREAT | O_TRUNC, 0644)) < 0) {
        fprintf(stderr, "Can't create/open %s for writing\n", argv[3]);
        exit(EXIT_FAILURE);
    }

    if (argc > 4) {
        number_of_bytes = atoi(argv[4]);
    }

    test_splice(infile, outfile1, outfile2, number_of_bytes);

    return EXIT_SUCCESS;
}

```

The example doesn't need much explanation; I added the '`number_of_bytes`' parameter so that you can copy a limited amount of data from an infinite source such as `/dev/zero` or `/dev/urandom`. Note that a 'real' implementation needs a bit more code, since it's not safe to assume that all the bytes get moved to the destination pipes in one hit, but that would obscure the example :-)