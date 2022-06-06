---
author: user
title: Tomcat on Ubuntu Feisty
slug: tomcat-on-ubuntu-feisty
id: 539
date: '2007-05-03 11:26:48'
layout: single
categories:
  - General
---

<span style="margin: 5px; float: right;">[![](http://tomcat.apache.org/images/tomcat.gif)](http://tomcat.apache.org/)</span>

[A while ago, I blogged about](http://blogs.sun.com/superpat/entry/opensso_on_tomcat_in_ubuntu) running [OpenSSO](https://opensso.dev.java.net/) on [Tomcat](http://tomcat.apache.org/) in [Ubuntu](http://www.ubuntu.com/). I recently upgraded Ubuntu to [7.04 'Feisty Fawn'](https://wiki.ubuntu.com/FeistyFawn), which, while most things work great, seems to have caused some issues with Tomcat...

The first is [this bug](https://bugs.launchpad.net/ubuntu/+source/tomcat5.5/+bug/97096) - when you start Tomcat, it just hangs. Apparently it's to do with `/var/lib/tomcat5.5/logs/catalina.out` being a named pipe. The workaround that works for me is to add the following line (shown in **bold**) to the start block in `/etc/init.d/tomcat5.5`

```
$DAEMON -user "$TOMCAT5_USER" -cp "$JSVC_CLASSPATH" \
-outfile "$LOGFILE"  -errfile '&1' \
-pidfile "$CATALINA_PID" $JAVA_OPTS "$BOOTSTRAP_CLASS"
**cat /var/log/tomcat5.5/catalina.out > /dev/null &**
else
log_progress_msg "(already running)"
fi

```

The second issue is that Tomcat seems to have changed where it puts its web applications. They were in `/usr/share/tomcat5.5/webapps`; they are now in `/var/lib/tomcat5.5/webapps`. This breaks the security policy [I blogged about last time](http://blogs.sun.com/superpat/entry/opensso_on_tomcat_in_ubuntu) - you now need to add the following to `/etc/tomcat5.5/policy.d/50user.policy`:

```
grant codeBase "file:${catalina.base}/webapps/openfm/-" {
permission java.security.AllPermission;
};

```

(i.e. switch from `${catalina.home}` to `${catalina.base}`)

And before anyone asks "Why aren't you using [Glassfish](https://glassfish.dev.java.net/)?" - I am, I'm just using Tomcat as well, since a lot of the [OpenSSO](https://opensso.dev.java.net/) contributors use it. Their pain is my pain ![](http://blogs.sun.com/images/smileys/smile.gif)