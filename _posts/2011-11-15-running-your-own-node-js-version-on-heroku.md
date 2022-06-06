---
author: user
title: Running Your Own Node.js Version on Heroku
slug: running-your-own-node-js-version-on-heroku
id: 1370
date: '2011-11-15 22:02:45'
layout: single
categories:
  - Uncategorized
tags:
  - heroku
  - node.js
---

**UPDATE** (3/3/12) - there's a **much** easier way of doing this now - see '[Specifying a version of Node.js / npm](http://devcenter.heroku.com/articles/nodejs-versions)' in the [Heroku Dev Center](http://devcenter.heroku.com/). The mechanism described below still works, but you should only go to all this trouble if you want something _really_ custom. Here's a completely unofficial, unsupported recipe for running your own [Node.js](http://nodejs.org/) version on [Heroku](http://www.heroku.com/). These instructions are based on those at the [Heroku Node.js Buildpack repository](https://github.com/heroku/heroku-buildpack-nodejs), with some extra steps that I found were necessary to make the process work. Note that buildpack support at Heroku is still evolving and the process will likely change over time. Please leave a comment if you try the instructions here and they don't work - I'll do my best to keep them up to date. Before you start, update the heroku gem, so it recognizes the `--buildpack` option:

```
gem update heroku
```

(Thanks to 'tester' for [leaving a comment](http://blog.superpat.com/2011/11/15/running-your-own-node-js-version-on-heroku/#comment-37640) reminding me that using an out of date heroku gem can result in the error message `! Name must start with a letter and can only contain lowercase letters, numbers, and dashes`.) **Note**: If you just want to try out a completely unofficial, unsupported Node.js 0.6.1 on Heroku, just create your app with my buildpack repository:

```
$ heroku create --stack cedar --buildpack http://github.com/metadaddy-sfdc/heroku-buildpack-nodejs.git
```

Otherwise, read on to learn how to create your very own buildpack... First, you'll need to fork [https://github.com/heroku/heroku-buildpack-nodejs](https://github.com/heroku/heroku-buildpack-nodejs). Now, before you follow the instructions in the README to create a custom Node.js buildpack, you'll have to create a build server (running on Heroku, of course!) with [vulcan](https://github.com/ddollar/vulcan) and make it available to the buildpack scripts. You'll have to choose a name for your build server that's not already in use by another Heroku app. If `vulcan create` responds with '`Name is already taken`', just pick another name.

```
$ gem install vulcan
$ vulcan create YOUR-BUILD-SERVER-NAME
```

Now you can create your buildpack. You'll need to set up environment variables for working with S3:

```
$ export AWS_ID=YOUR-AWS-ID AWS_SECRET=YOUR-AWS-SECRET S3_BUCKET=AN-S3-BUCKET-NAME
```

Create an S3 bucket to hold your buildpack. I used the S3 console, but, if you have the command line tools installed, you can use them instead. Next you'll need to package Node.js and [NPM](http://npmjs.org/) for use on Heroku. I used the current latest, greatest version of Node.js, 0.6.1, and NPM, 1.0.105:

```
$ support/package_node 0.6.1
$ support/package_npm 1.0.105
```

Open `bin/compile` in your editor, and update the following lines:

```
NODE_VERSION="0.6.1"
NPM_VERSION="1.0.105"
S3_BUCKET=AN-S3-BUCKET-NAME
```

Now commit your changes and push the file back to GitHub:

```
$ git commit -am "Update Node.js to 0.6.1, NPM to 1.0.105"
$ git push
```

You can now create a Heroku app using your custom buildpack. You'll also need to specify the Cedar stack:

```
$ heroku create --stack cedar --buildpack http://github.com/YOUR-GITHUB-ID/heroku-buildpack-nodejs.git
```

When you push your app to Heroku, you should see the custom buildpack in action:

```
$ cd ../node-example/
$ git push heroku master
Counting objects: 11, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (8/8), done.
Writing objects: 100% (11/11), 4.02 KiB, done.
Total 11 (delta 1), reused 0 (delta 0)

-----> Heroku receiving push
-----> Fetching custom build pack... done
-----> Node.js app detected
-----> Fetching Node.js binaries
-----> Vendoring node 0.6.1
-----> Installing dependencies with npm 1.0.105

Dependencies installed
-----> Discovering process types
Procfile declares types -> web
-----> Compiled slug size is 3.3MB
-----> Launching... done, v6
http://strong-galaxy-8791.herokuapp.com deployed to Heroku

To git@heroku.com:strong-galaxy-8791.git
cd3c0e2..33fdd7a  master -> master
$ curl http://strong-galaxy-8791.herokuapp.com
Hello from Node.js v0.6.1
```

[w00t!](http://en.wikipedia.org/wiki/W00t) **Note**: Due to an [incompatibility](http://superuser.com/questions/318809/linux-macos-tar-incompatibility-tarballs-created-on-macos-give-errors-when-u) between the default BSD tar on my Mac and GNU tar on Heroku, I saw many warnings while pushing my Node.js app to Heroku, of the form

```
tar: Ignoring unknown extended header keyword `SCHILY.dev'
tar: Ignoring unknown extended header keyword `SCHILY.ino'
tar: Ignoring unknown extended header keyword `SCHILY.nlink'
```

These are annoying, but benign - the push completes successfully. If you're on a Mac and you want to get rid of them, add the line

```
alias tar=gnutar
```

just after the opening `#!/bin/sh` in both package scripts.