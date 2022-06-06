---
author: user
title: Script to Reset Fedlet Demo
slug: script-to-reset-fedlet-demo
id: 343
date: '2008-10-27 10:06:42'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](https://opensso.dev.java.net/images/logo.gif)](http://opensso.org/)</span>

If you find yourself demonstrating [the Fedlet](http://blogs.sun.com/raskin/entry/the_fedlet_has_arrived_check) (and, let's face it, who doesn't?), you should find [this script](images/reset.sh) useful. Assuming you've deployed [OpenSSO](http://opensso.org/) to [Glassfish](http://glassfish.org/) via the [autodeploy directory](http://docs.sun.com/app/docs/doc/819-3660/6n5s7klpb?a=view#beaea) and created and deployed the Fedlet, it undeploys both, restarts Glassfish (not that you should really need to, but it's good to start from a safe, known base) and removes the OpenSSO and Fedlet configuration directories. Now you'll be ready to go round the loop again, without any JavaOne 2008-style hiccups :-)

Anyone working with OpenSSO and/or Glassfish might find some aspects of the script useful; particularly the way it waits until the apps are undeployed before restarting Glassfish. Autodeploy is one of my favorite Glassfish features. Here's the output from the script:

> pat-pattersons-computer:~ pat$ ./reset.sh
>     Undeploying the fedlet..Done
>     Undeploying OpenSSO........Done
>     Domain domain1 stopped.
>     Removing Fedlet config directory
>     Removing OpenSSO config directory
>     Starting Domain domain1, please wait.
>     Log redirected to /Applications/NetBeans/glassfish-v2ur2/domains/domain1/logs/server.log.
>     Redirecting output to /Applications/NetBeans/glassfish-v2ur2/domains/domain1/logs/server.log
>     Domain domain1 is ready to receive client requests. Additional services are being started in background.
>     Domain [domain1] is running [Sun Java System Application Server 9.1_02 (build b04-fcs)] with its configuration and logs at: [/Applications/NetBeans/glassfish-v2ur2/domains].
>     Admin Console is available at [http://localhost:4848].
>     Use the same port [4848] for "asadmin" commands.
>     User web applications are available at these URLs:
>     [http://localhost:8080 https://localhost:8181 ].
>     Following web-contexts are available:
>     [/web1  /__wstx-services ].
>     Standard JMX Clients (like JConsole) can connect to JMXServiceURL:
>     [service:jmx:rmi:///jndi/rmi://pat-pattersons-computer.local:8686/jmxrmi] for domain management purposes.
>     Domain listens on at least following ports for connections:
>     [8080 8181 4848 3700 3820 3920 8686 ].
>     Domain does not support application server clusters and other standalone instances.