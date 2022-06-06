---
author: user
title: OpenSSO on Tomcat in Ubuntu
slug: opensso-on-tomcat-in-ubuntu
id: 611
date: '2006-11-10 17:17:38'
layout: single
categories:
  - OpenSSO
---

[<span style="margin:10px;float:right;">![](https://opensso.dev.java.net/images/getit.gif)</span>](https://opensso.dev.java.net/public/use/index.html)

The 'single WAR' deployment of [OpenSSO](https://opensso.dev.java.net/) allows you to simply deploy a [WAR file](http://en.wikipedia.org/wiki/WAR_%28file_format%29) into a [web container](http://en.wikipedia.org/wiki/Web_container) such as [Glassfish](https://glassfish.dev.java.net/) or [Tomcat](http://tomcat.apache.org/). The first time you hit the OpenSSO URL, a configurator runs, collecting some basic parameters, saving them to configuration files and setting up OpenSSO for use. You can save this configuration anywhere in the file system; the configurator saves that location in a file in the home directory of user as which the web container is running (that's a really clumsy way to put it, but hopefully the meaning is almost clear).

[![](http://blog.superpat.com/OpenSSOConfigurator500.png)](http://blog.superpat.com/OpenSSOConfigurator.png)

[Numerous](http://blogs.sun.com/indira/entry/opensso_deployment_on_tomcat_requires) [folks](http://blogs.sun.com/tkudo/entry/opensso_nightly_build_installation_guide) are deploying OpenSSO on Tomcat. In a typical 'developer' installation, where you run Tomcat from the command line, all works well - you get a file named something like `AMConfig_localhost_opensso_` in your home directory. `AMConfig` is a constant prefix and `_localhost_opensso_` is OpenSSO's deployment location (`/localhost/opensso/`) with slashes replaced by underscores. Ubuntu installs Tomcat on '`localhost`', and I deployed the OpenSSO war file into `/opensso`, so I get a file called `AMConfig_localhost_opensso_` whose content is simply the path to the main configuration data. Your mileage _will_ vary!

Now - I'm running [Ubuntu](http://www.ubuntu.com) on my laptop, with the default Ubuntu distribution of Tomcat 5.5\. The first time I tried to deploy OpenSSO it failed - looking at Tomcat's logs, I could see

```
localhost_2006-11-03.log:java.security.AccessControlException: access denied (java.util.PropertyPermission user.home read)

```

Tomcat is running with the Security Manager and is denying access to the `user.home` property. From previous experience, the quickest way round this (short of completely disabling the security manager) is to grant your web application all rights. I added the following to `/etc/tomcat5.5/policy.d/99examples.policy`:

```
grant codeBase "file:${catalina.home}/webapps/opensso/-" {
permission java.security.AllPermission;
};

```

You could, of course, specify much more granular permissions, but this gets you going with the minimum fuss.

So - try again. This time, OpenSSO gets a little further, but fails again with

```
java.io.FileNotFoundException: /usr/share/tomcat5.5/AMConfig_localhost_opensso_ (Permission denied)

```

Although OpenSSO can now locate the user's home directory, it can't actually write to a file there, since, in this configuration, Tomcat is running as the tomcat5 user, whose home directory (`/usr/share/tomcat5.5`) is owned by root and is not writable by tomcat5\. One solution is to temporarily make that directory writable by all (`sudo chmod 777 /usr/share/tomcat5.5`), flipping it back after OpenSSO configures itself successfully (`sudo chmod 755 /usr/share/tomcat5.5`). A more elegant approach, and one which doesn't require you to go back and tidy up, is to do

```
sudo touch /usr/share/tomcat5.5/AMConfig_localhost_opensso_
sudo chown tomcat5 /usr/share/tomcat5.5/AMConfig_localhost_opensso_

```

Now, you just need to ensure that you give the configurator a directory that is writable by tomcat5 and all is well - a working OpenSSO and an interesting excursion through the mechanisms that Tomcat and Ubuntu use to prevent web applications from running arbitrary code.