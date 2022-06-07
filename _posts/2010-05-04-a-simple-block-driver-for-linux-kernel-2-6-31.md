---
author: user
title: A Simple Block Driver for Linux Kernel 2.6.31
slug: a-simple-block-driver-for-linux-kernel-2-6-31
id: 1051
date: '2010-05-04 09:02:38'
layout: single
categories:
  - Linux
tags:
  - driver
  - kernel
  - linux
---

[![Programming Amazon Web Services](https://images-na.ssl-images-amazon.com/images/I/51a6fTtCIoL._SX379_BO1,204,203,200_.jpg "Linux Device Drivers, 3rd Edition"){: .align-left}](http://www.amazon.com/exec/obidos/ASIN/0596005903/superpatterns-20) Linux Device Drivers, 3rd Edition[/caption] My current work involves writing my first Linux block device driver. Going to the web to find a sample, I discovered [Jonathan Corbet](http://ldn.linuxfoundation.org/blogs/jcorbet)'s [Simple Block Driver](http://lwn.net/Articles/58719/) article with its associated [block driver example code](http://lwn.net/Articles/58720/). It's a nice succinct implementation of a ramdisk - pretty much the simplest working block device. There's only one problem, though, the article was written in 2003, when kernel 2.6.0 was the new kid on the block. Trying to build it on openSUSE 11.2 with kernel 2.6.31 just produced a slew of compile errors. A bit of research revealed that [there were major changes to the kernel block device interface in 2.6.31](http://kernelnewbies.org/Linux_2_6_31#head-5a6f57dc036c513bd60426fba4c6f5c13eb6cee1), so I would have to port the example to get it working. About a day and a half of poring through the kernel source and the excellent [LDD3](http://lwn.net/Kernel/LDD3/) ([hardcopy](http://www.amazon.com/exec/obidos/ASIN/0596005903/superpatterns-20/ref=nosim/)) later, I had a running simple block driver for kernel 2.6.31\. I've also tested it successfully on SUSE 11 SP1 Beta, which uses kernel 2.6.32\. Here's the code, followed by instructions for getting it working. **sbd.c**

```
/*
 * A sample, extra-simple block driver. Updated for kernel 2.6.31.
 *
 * (C) 2003 Eklektix, Inc.
 * (C) 2010 Pat Patterson <pat at superpat dot com>
 * Redistributable under the terms of the GNU GPL.
 */

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>

#include <linux/kernel.h> /* printk() */
#include <linux/fs.h>     /* everything... */
#include <linux/errno.h>  /* error codes */
#include <linux/types.h>  /* size_t */
#include <linux/vmalloc.h>
#include <linux/genhd.h>
#include <linux/blkdev.h>
#include <linux/hdreg.h>

MODULE_LICENSE("Dual BSD/GPL");
static char *Version = "1.4";

static int major_num = 0;
module_param(major_num, int, 0);
static int logical_block_size = 512;
module_param(logical_block_size, int, 0);
static int nsectors = 1024; /* How big the drive is */
module_param(nsectors, int, 0);

/*
 * We can tweak our hardware sector size, but the kernel talks to us
 * in terms of small sectors, always.
 */
#define KERNEL_SECTOR_SIZE 512

/*
 * Our request queue.
 */
static struct request_queue *Queue;

/*
 * The internal representation of our device.
 */
static struct sbd_device {
	unsigned long size;
	spinlock_t lock;
	u8 *data;
	struct gendisk *gd;
} Device;

/*
 * Handle an I/O request.
 */
static void sbd_transfer(struct sbd_device *dev, sector_t sector,
		unsigned long nsect, char *buffer, int write) {
	unsigned long offset = sector * logical_block_size;
	unsigned long nbytes = nsect * logical_block_size;

	if ((offset + nbytes) > dev->size) {
		printk (KERN_NOTICE "sbd: Beyond-end write (%ld %ld)\n", offset, nbytes);
		return;
	}
	if (write)
		memcpy(dev->data + offset, buffer, nbytes);
	else
		memcpy(buffer, dev->data + offset, nbytes);
}

static void sbd_request(struct request_queue *q) {
	struct request *req;

	req = blk_fetch_request(q);
	while (req != NULL) {
		// blk_fs_request() was removed in 2.6.36 - many thanks to
		// Christian Paro for the heads up and fix...
		//if (!blk_fs_request(req)) {
		if (req == NULL || (req->cmd_type != REQ_TYPE_FS)) {
			printk (KERN_NOTICE "Skip non-CMD request\n");
			__blk_end_request_all(req, -EIO);
			continue;
		}
		sbd_transfer(&Device, blk_rq_pos(req), blk_rq_cur_sectors(req),
				req->buffer, rq_data_dir(req));
		if ( ! __blk_end_request_cur(req, 0) ) {
			req = blk_fetch_request(q);
		}
	}
}

/*
 * The HDIO_GETGEO ioctl is handled in blkdev_ioctl(), which
 * calls this. We need to implement getgeo, since we can't
 * use tools such as fdisk to partition the drive otherwise.
 */
int sbd_getgeo(struct block_device * block_device, struct hd_geometry * geo) {
	long size;

	/* We have no real geometry, of course, so make something up. */
	size = Device.size * (logical_block_size / KERNEL_SECTOR_SIZE);
	geo->cylinders = (size & ~0x3f) >> 6;
	geo->heads = 4;
	geo->sectors = 16;
	geo->start = 0;
	return 0;
}

/*
 * The device operations structure.
 */
static struct block_device_operations sbd_ops = {
		.owner  = THIS_MODULE,
		.getgeo = sbd_getgeo
};

static int __init sbd_init(void) {
	/*
	 * Set up our internal device.
	 */
	Device.size = nsectors * logical_block_size;
	spin_lock_init(&Device.lock);
	Device.data = vmalloc(Device.size);
	if (Device.data == NULL)
		return -ENOMEM;
	/*
	 * Get a request queue.
	 */
	Queue = blk_init_queue(sbd_request, &Device.lock);
	if (Queue == NULL)
		goto out;
	blk_queue_logical_block_size(Queue, logical_block_size);
	/*
	 * Get registered.
	 */
	major_num = register_blkdev(major_num, "sbd");
	if (major_num < 0) {
		printk(KERN_WARNING "sbd: unable to get major number\n");
		goto out;
	}
	/*
	 * And the gendisk structure.
	 */
	Device.gd = alloc_disk(16);
	if (!Device.gd)
		goto out_unregister;
	Device.gd->major = major_num;
	Device.gd->first_minor = 0;
	Device.gd->fops = &sbd_ops;
	Device.gd->private_data = &Device;
	strcpy(Device.gd->disk_name, "sbd0");
	set_capacity(Device.gd, nsectors);
	Device.gd->queue = Queue;
	add_disk(Device.gd);

	return 0;

out_unregister:
	unregister_blkdev(major_num, "sbd");
out:
	vfree(Device.data);
	return -ENOMEM;
}

static void __exit sbd_exit(void)
{
	del_gendisk(Device.gd);
	put_disk(Device.gd);
	unregister_blkdev(major_num, "sbd");
	blk_cleanup_queue(Queue);
	vfree(Device.data);
}

module_init(sbd_init);
module_exit(sbd_exit);
```

**Makefile**

```
obj-m := sbd.o
KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)
default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
```

There are two main areas of change compared with [Jonathan's original](http://lwn.net/Articles/58720/):

*   `sbd_request()` uses the `blk_fetch_request()`, `blk_rq_pos()`, `blk_rq_cur_sectors()` and `__blk_end_request_cur()` functions rather than `elv_next_request()`, `req->sector`, `req->current_nr_sectors` and `end_request()` respectively. The structure of the loop also changes so we handle each sector from the request individually. One outstanding task for me is to investigate whether `req->buffer` holds **all** of the data for the entire request, so I can handle it all in one shot, rather than sector-by-sector. My first attempt resulted in the (virtual) machine hanging when I installed the driver, so I clearly need to do some more work in this area!
*   The driver implements the `getgeo` operation (in `sbd_getgeo`), rather than `ioctl`, since blkdev_ioctl now handles `HDIO_GETGEO` by calling the driver's getgeo function. This is a nice simplification since it moves a `copy_to_user` call out of each driver and into the kernel.

Before building, ensure you have the kernel source, headers, gcc, make etc - if you've read this far, you likely have all this and/or know how to get it, so I won't spell it all out here. You'll also need to go to the kernel source directory and do the following to prepare your build environment, if you have not already done so:

```
cd /usr/src/`uname -r`
make oldconfig && make prepare
```

Now, back in the directory with the sbd source, you can build it:

```
make -C /lib/modules/`uname -r`/build M=`pwd` modules
```

You'll see a warning about 'Version' being defined, but not used, but don't worry about that :-). Now we can load the module, partition the ramdisk, make a filesystem, mount it, and create a file:

```
opensuse:/home/pat/sbd # insmod sbd.ko
opensuse:/home/pat/sbd # fdisk /dev/sbd0
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
Building a new DOS disklabel with disk identifier 0x5f93978c.
Changes will remain in memory only, until you decide to write them.
After that, of course, the previous content won't be recoverable.

Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)

Command (m for help): n
Command action
   e   extended
   p   primary partition (1-4)
p
Partition number (1-4): 1
First cylinder (1-16, default 1):
Using default value 1
Last cylinder, +cylinders or +size{K,M,G} (1-16, default 16):
Using default value 16

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.
opensuse:/home/pat/sbd # mkfs /dev/sbd0p1
mke2fs 1.41.9 (22-Aug-2009)
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
64 inodes, 504 blocks
25 blocks (4.96%) reserved for the super user
First data block=1
Maximum filesystem blocks=524288
1 block group
8192 blocks per group, 8192 fragments per group
64 inodes per group

Writing inode tables: done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 24 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
opensuse:/home/pat/sbd # mount /dev/sbd0p1 /mnt
opensuse:/home/pat/sbd # echo Hi > /mnt/file1
opensuse:/home/pat/sbd # cat /mnt/file1
Hi
opensuse:/home/pat/sbd # ls -l /mnt
total 13
-rw-r--r-- 1 root root     3 2010-04-29 07:04 file1
drwx------ 2 root root 12288 2010-04-29 07:04 lost+found
opensuse:/home/pat/sbd # umount /mnt
opensuse:/home/pat/sbd # rmmod sbd
```

Hopefully this all works for you, and is as useful for you as it has been for me. Many thanks to Jonathan for the original version and the excellent LDD3\. One final piece of housekeeping - although the comment at the top of sbd.c mentions only GPL, the MODULE_LICENSE macro specifies "Dual BSD/GPL". I am interpreting the original code as being under the dual GPL/BSD license and this version is similarly dual licensed. _UPDATE (Feb 5 2011)_ See the [comment by Michele regarding changes to logical_block_size](http://blog.superpat.com/2010/05/04/a-simple-block-driver-for-linux-kernel-2-6-31/comment-page-1/#comment-16760)! _UPDATE (Apr 23 2015)_ See the [comment by Sarge regarding changes for kernel 3.15-rc2 and later](http://blog.superpat.com/2010/05/04/a-simple-block-driver-for-linux-kernel-2-6-31/comment-page-2/#comment-148884)