---
author: user
title: Node.js Chat Demo on Heroku
slug: node-js-chat-demo-on-heroku
id: 1329
date: '2011-06-14 14:46:35'
layout: single
categories:
  - Uncategorized
tags:
  - heroku
  - node.js
---

**STOP!** If you're just getting started with Node.js and/or Heroku, then go read James Ward's excellent [Getting Started with Node.js on The Cloud](http://www.jamesward.com/2011/06/21/getting-started-with-node-js-on-the-cloud/), then come back here... [Heroku](http://heroku.com/)'s [announcement of the public beta](http://blog.heroku.com/archives/2011/5/31/celadon_cedar/) of their [new 'Celadon Cedar' stack](http://devcenter.heroku.com/articles/cedar), including [Node.js](http://nodejs.org/) support, inspired me to try out [Ryan Dahl](https://twitter.com/#!/ryah)'s [Node Chat demo server](https://github.com/ry/node_chat) on Heroku. Getting it up and running was very straightforward - I went to GitHub, [forked](http://help.github.com/fork-a-repo/) Ryan's node_chat project to my own account and grabbed the source:

<pre style="white-space: pre-wrap;">ppatterson-ltm:tmp ppatterson$ git clone git://github.com/metadaddy-sfdc/node_chat.git
Cloning into node_chat...
remote: Counting objects: 183, done.
remote: Compressing objects: 100% (72/72), done.
remote: Total 183 (delta 117), reused 168 (delta 110)
Receiving objects: 100% (183/183), 50.07 KiB, done.
Resolving deltas: 100% (117/117), done.
```

Now I could create my Heroku app...

<pre style="white-space: pre-wrap;">ppatterson-ltm:tmp ppatterson$ cd node_chat/
ppatterson-ltm:node_chat ppatterson$ heroku create --stack cedar node-chat
Creating node-chat2... done, stack is cedar
http://node-chat2.herokuapp.com/ | git@heroku.com:node-chat.git
Git remote heroku added
```

...and add the couple of files that Heroku needs to run a Node.js app (see the [excellent Heroku docs](http://devcenter.heroku.com/articles/node-js) for more info):

<pre style="white-space: pre-wrap;">ppatterson-ltm:node_chat ppatterson$ echo "web: node server.js" > Procfile
ppatterson-ltm:node_chat ppatterson$ echo "{ \"name\": \"node-chat\", \"version\": \"0.0.1\" }" > package.json
ppatterson-ltm:node_chat ppatterson$ git add .
ppatterson-ltm:node_chat ppatterson$ git commit -m "Heroku-required files" Procfile package.json
[master a7617af] Heroku-required files
2 files changed, 2 insertions(+), 0 deletions(-)
create mode 100644 Procfile
create mode 100644 package.json
```

Now everything is ready to deploy:

<pre style="white-space: pre-wrap;">ppatterson-ltm:node_chat ppatterson$ git push heroku master
Counting objects: 187, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (67/67), done.
Writing objects: 100% (187/187), 50.40 KiB, done.
Total 187 (delta 118), reused 182 (delta 117)

-----> Heroku receiving push
-----> Node.js app detected
-----> Vendoring node 0.4.7
-----> Installing dependencies with npm 1.0.8

Dependencies installed
-----> Discovering process types
Procfile declares types -> web
-----> Compiled slug size is 2.9MB
-----> Launching... done, v4
http://node-chat.herokuapp.com deployed to Heroku

To git@heroku.com:node-chat2.git
* [new branch]      master -> master
ppatterson-ltm:node_chat ppatterson$ heroku ps
Process       State               Command
------------  ------------------  ------------------------------
web.1         starting for 3s     node server.js
ppatterson-ltm:node_chat ppatterson$ heroku ps
Process       State               Command
------------  ------------------  ------------------------------
web.1         up for 6s           node server.js
ppatterson-ltm:node_chat ppatterson$ heroku open
Opening http://node-chat.herokuapp.com/
```

And, just like that, my chat server is up and running and I see it in my browser. It all works nicely - I can hit the URL from a couple of browsers and see all the chat messages going back and forth. Only one problem, though - I'm seeing errors when the chat server is idle: [![](http://blog.superpat.com/wp-content/uploads/2011/06/node-chat1.png "node_chat - first attempt")](http://blog.superpat.com/wp-content/uploads/2011/06/node-chat1.png) A look at the logs reveals that connections are timing out.

<pre style="white-space: pre-wrap;">2011-06-14T19:10:44+00:00 app[web.1]: <Pat2> Hi there
2011-06-14T19:10:44+00:00 heroku[router]: GET node-chat2.herokuapp.com/send dyno=web.1 queue=0 wait=0ms service=6ms bytes=16
2011-06-14T19:10:44+00:00 heroku[router]: GET node-chat2.herokuapp.com/recv dyno=web.1 queue=0 wait=0ms service=3520ms bytes=102
2011-06-14T19:10:53+00:00 app[web.1]: <Pat> Now I can talk to myself - woo hoo!
2011-06-14T19:10:53+00:00 heroku[router]: GET node-chat2.herokuapp.com/send dyno=web.1 queue=0 wait=0ms service=2ms bytes=16
2011-06-14T19:10:53+00:00 heroku[router]: GET node-chat2.herokuapp.com/recv dyno=web.1 queue=0 wait=0ms service=9185ms bytes=128
2011-06-14T19:10:53+00:00 heroku[router]: GET node-chat2.herokuapp.com/recv dyno=web.1 queue=0 wait=0ms service=9203ms bytes=128
2011-06-14T19:11:24+00:00 heroku[router]: Error H12 (Request timeout) -> GET node-chat2.herokuapp.com/recv dyno=web.1 queue= wait= service=30000ms bytes=
2011-06-14T19:11:24+00:00 heroku[router]: Error H12 (Request timeout) -> GET node-chat2.herokuapp.com/recv dyno=web.1 queue= wait= service=30000ms bytes=
```

So what's up? The answer is in the [Heroku docs for the new HTTP 1.1 stack](http://devcenter.heroku.com/articles/http-routing#timeouts):

> The herokuapp.com routing stack will terminate connections after 60 seconds on inactivity. If your app sends any data during this window, you will have a new 60 second window. This allows long-polling and other streaming data response.

From the logs, it looks like the connection is being dropped after only 30 seconds, but, no matter, the principle is the same - I need to periodically send some data to keep the connections open. The solution I settled on was having each client set a 20 second timer after it starts its long poll; on the timer firing the client sends a 'ping' message (effectively an empty message) to the server, which, in turn, forwards the ping to all attached clients, causing them to cancel their ping timers and iterate around the long polling loop. Normal chat traffic also causes the timer to be cancelled, so the pings are only sent during periods of inactivity. [You can see the diffs here](https://github.com/metadaddy-sfdc/node_chat/commit/f18b28961099dc8984f4e0a8f3058dc4a5eb8777). Now my chat server stays up for hours without an error: [![](http://blog.superpat.com/wp-content/uploads/2011/06/node-chat2.png "node_chat - working now")](http://blog.superpat.com/wp-content/uploads/2011/06/node-chat2.png) If you [grab my fork from GitHub](https://github.com/metadaddy-sfdc/node_chat), you'll see I also added message persistence, using [Brian Carlson's node-postgres module](https://github.com/brianc/node-postgres) - mostly because I just wanted to see how easy it was to access PostgreSQL from Node.js on Heroku. The answer? [Trivially easy](https://github.com/metadaddy-sfdc/node_chat/commit/2ced3d496d5fb8d6a82a317550c846f0b926d3e0) :-) As Jeffrey mentions in the comments, apart from those code changes, I also needed to add the 'pg' module in package.json and the shared-database addon. The new package.json looks like this:

```
{
  "name": "node-chat",
  "version": "0.0.1",
  "dependencies": {
    "pg": "0.5.0"
  }
}
```

The command to install the shared-database addon is:

```
heroku addons:add shared-database
```

Disclosure - [I am a salesforce.com employee](http://blog.superpat.com/2010/11/01/salesforce-com-%e2%80%93-two-weeks-in/), so I'm definitely a little biased in favor of my Heroku cousins, but, I have to say, I remain hugely impressed by Heroku. It. Just. Works.