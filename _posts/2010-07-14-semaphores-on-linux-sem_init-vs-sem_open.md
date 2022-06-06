---
author: user
title: Semaphores on Linux - sem_init() vs sem_open()
slug: semaphores-on-linux-sem_init-vs-sem_open
id: 1113
date: '2010-07-14 13:57:15'
layout: single
categories:
  - Linux
tags:
  - linux
  - semaphores
---

[!["Semaphore"](http://blog.superpat.com/wp-content/uploads/2010/07/200px-Semaphore_Papa.png "Credit to Denelson83 for the image - click for the original"){: .align-left}](http://en.wikipedia.org/wiki/File:Semaphore_Papa.svg) Regular readers will know that I'm working on a Linux server daemon that, amongst other things, [moves data back and forth between sockets and files without it appearing in user space](http://blog.superpat.com/2010/06/01/zero-copy-in-linux-with-sendfile-and-splice/), and even ['tees' that data to a second destination, again without a copy to a user space buffer](http://blog.superpat.com/2010/07/08/a-cup-of-tee-and-a-splice-of-cake/). Now I have multiple instances of my server running, and they need to synchronize access to shared data structures. The standard mechanism for this is the [semaphore](http://en.wikipedia.org/wiki/Semaphore_%28programming%29). I won't get into a deep discussion of semaphores here, the Wikipedia article linked in the preceding sentence gives a good description. Basically, if you want to ensure that no more than one thread (ok, 'n' threads in the general case) has access to some resource concurrently, you use a semaphore. Looking for an example of semaphores on Linux, I found the aptly named [Semaphores in Linux](http://linuxdevcenter.com/pub/a/linux/2007/05/24/semaphores-in-linux.html), by Vikram Shukla, on the [O'Reilly Linux DevCenter](http://linuxdevcenter.com/). This is a very useful article, explaining the general semaphore concept and comparing the System V and POSIX semaphore implementations. Guided by the article, in particular, the '[Related Process](http://linuxdevcenter.com/pub/a/linux/2007/05/24/semaphores-in-linux.html?page=5)' example, which closely matched my use case, I wrote a quick test program using the POSIX [sem_init()](http://linux.die.net/man/3/sem_init) call to initialize a semaphore and [sem_wait()](http://linux.die.net/man/3/sem_wait)/[sem_post()](http://linux.die.net/man/3/sem_post) to decrement/increment the semaphore respectively. Only one problem. It didn't work - my processes had concurrent access to the shared resource! Going back to Vikram's example, and reading the sem_init() man page very carefully, the issue seems to be that the semaphore is created on the stack of the parent process. When the child is forked, it gets a copy of the semaphore, not a reference to the parent's semaphore. Adding a few sleep()'s and printf()'s to the example highlights the problem:

```
#include <semaphore.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>

int main(int argc, char **argv)
{
  int fd, i,count=0,nloop=10,zero=0,*ptr;
  sem_t mutex;

  //open a file and map it into memory

  fd = open("log.txt",O_RDWR|O_CREAT,S_IRWXU);
  write(fd,&zero,sizeof(int));
  ptr = mmap(NULL,sizeof(int),PROT_READ |PROT_WRITE,MAP_SHARED,fd,0);
  close(fd);

  /* create, initialize semaphore */
  if( sem_init(&mutex,1,1) < 0)
    {
      perror("semaphore initilization");
      exit(0);
    }
  if (fork() == 0) { /* child process*/
    for (i = 0; i < nloop; i++) {
      sem_wait(&mutex);
      printf("child entered crititical section: %d\n", (*ptr)++);
      sleep(2);
      printf("child leaving critical section\n");
      sem_post(&mutex);
      sleep(1);
    }
    exit(0);
  }
  /* back to parent process */
  for (i = 0; i < nloop; i++) {
    sem_wait(&mutex);
    printf("parent entered critical section: %d\n", (*ptr)++);
    sleep(2);
    printf("parent leaving critical section\n");
    sem_post(&mutex);
    sleep(1);
  }
  exit(0);
}
```

Running this shows that _both the parent and the child are in the critical section at the same time_:

```
child entered critical section: 0
parent entered critical section: 1
parent leaving critical section
child leaving critical section
parent entered critical section: 2
child entered critical section: 3
...
```

The explanation is in the [sem_init() man page](http://linux.die.net/man/3/sem_init):

> If _pshared_ is non-zero, then the semaphore is shared between processes, and should be located in a region of shared memory (see [shm_open](http://linux.die.net/man/3/shm_open)(3), [mmap](http://linux.die.net/man/2/mmap)(2), and [shmget](http://linux.die.net/man/2/shmget)(2)). (Since a child created by [fork](http://linux.die.net/man/2/fork)(2) inherits its parent's memory mappings, it can also access the semaphore.) Any process that can access the shared memory region can operate on the semaphore using [sem_post](http://linux.die.net/man/3/sem_post)(3), [sem_wait](http://linux.die.net/man/3/sem_wait)(3), etc.

The key here is that the semaphore _must_ be in a region of shared memory, even if you're accessing it from related processes such as a parent and its child. There are two ways of fixing the problem. The first is to use [shm_open()](http://linux.die.net/man/3/shm_open), [ftruncate()](http://linux.die.net/man/2/ftruncate) and [mmap()](http://linux.die.net/man/2/mmap) to create a shared memory region and obtain a pointer to it:

```
  int shm;
  sem_t * mutex;

  ...

  if ((shm = shm_open("myshm", O_RDWR | O_CREAT, S_IRWXU))   0) {
    perror("shm_open");
    exit(1);
  }

  if ( ftruncate(shm, sizeof(sem_t)) < 0 ) {
    perror("ftruncate");
    exit(1);
  }

  if ((mutex = mmap(NULL, sizeof(sem_t), PROT_READ | PROT_WRITE,
      MAP_SHARED, shm, 0)) == MAP_FAILED) {
    perror("mmap");
    exit(1);
  }

  if (sem_init(mutex, 1, 1) < 0) {
    perror("semaphore initialization");
    exit(1);
  }

  ...
```

The other, simpler, solution is to just use [sem_open()](http://linux.die.net/man/3/sem_open), which Vikram describes in the next section of the article:

```
  if ((mutex = sem_open("mysemaphore", O_CREAT, 0644, 1)) == SEM_FAILED) {
    perror("semaphore initilization");
    exit(1);
  }
```

Either of these approaches gives the desired result:

```
child entered crit section: 0
child leaving crit section
parent entered crit section: 1
parent leaving crit section
child entered crit section: 2
child leaving crit section
parent entered crit section: 3
...
```

Postscript: this is a minor flaw in an otherwise excellent and very useful article. I address it here, rather than in a comment on the article, due to the amount of space required for a full explanation.