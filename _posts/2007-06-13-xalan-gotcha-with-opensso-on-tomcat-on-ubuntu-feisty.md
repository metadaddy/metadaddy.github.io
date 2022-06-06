---
author: user
title: Xalan gotcha with OpenSSO on Tomcat on Ubuntu Feisty
slug: xalan-gotcha-with-opensso-on-tomcat-on-ubuntu-feisty
id: 528
date: '2007-06-13 12:32:10'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://tomcat.apache.org/images/tomcat.gif)](http://tomcat.apache.org/)</span>

I've been meaning to blog about this for a while, but haven't been able to scrape together a few minutes. Anyway, if you've been reading Superpatterns for a while you'll know that I use [Tomcat](http://tomcat.apache.org/) on [Ubuntu](http://www.ubuntu.com/) to run [OpenSSO](https://opensso.dev.java.net/). [I wrote a little while ago about some problems](http://blogs.sun.com/superpat/entry/tomcat_on_ubuntu_feisty) with Tomcat in Ubuntu [7.04 'Feisty Fawn'](https://wiki.ubuntu.com/FeistyFawn) - Ubuntu hanging at startup due to issues with catalina.out and security policy needing to be updated due to a change in where Tomcat keeps web applications on disk.

Another issue I've seen is the following stack trace when parsing XML:

```
javax.xml.transform.TransformerFactoryConfigurationError: Provider org.apache.xalan.processor.TransformerFactoryImpl not found
javax.xml.transform.TransformerFactory.newInstance(TransformerFactory.java:119)
com.sun.identity.shared.xml.XMLUtils.print(XMLUtils.java:674)
com.sun.identity.saml.assertion.Assertion.parseAssertionElement(Assertion.java:191)
com.sun.identity.saml.assertion.Assertion.<init>(Assertion.java:147)
com.sun.identity.wsfederation.profile.RequestSecurityTokenResponse.<init>(RequestSecurityTokenResponse.java:131)
com.sun.identity.wsfederation.profile.RequestSecurityTokenResponse.parseXML(RequestSecurityTokenResponse.java:62)
com.sun.identity.wsfederation.servlet.RPSigninResponse.process(RPSigninResponse.java:93)
com.sun.identity.wsfederation.servlet.WSFederationServlet.doPost(WSFederationServlet.java:143)
javax.servlet.http.HttpServlet.service(HttpServlet.java:709)
[...]</init></init> 
```

A quick Google turns up [this blog entry](http://blog.andrewbeacock.com/2006/12/xalan-classes-go-missing-once-java-is.html) from [Andrew Beacock](http://blog.andrewbeacock.com/) in the UK. The issue is that, previously, [Xalan](http://xml.apache.org/xalan-j/) was included in JDK 1.4, but since then, the Apache community has chosen [XSLTC](http://xml.apache.org/xalan-j/xsltc/) as the default processor for developing [XSLT 2.0](http://www.w3.org/TR/xslt20/), and [JDK 1.5 followed suit](http://java.sun.com/j2se/1.5.0/compatibility.html#4959783) for [JAXP](http://java.sun.com/webservices/jaxp/) 1.3\. I'm running Tomcat on Sun's 1.5.0_11-b03 JVM, hence the missing TransformerFactoryImpl. The bottom line is this: [grab Xalan for yourself](http://www.apache.org/dyn/closer.cgi/xml/xalan-j) and put it in your web app's WEB-INF/lib directory.

If you're working with OpenSSO, you can just copy xalan.jar, xercesImpl.jar, xml-apis.jar and serializer.jar from Xalan to opensso/products/extlib, rebuild the OpenSSO WAR and you should be good to go.

And, again, before anyone asks "Why aren't you using [Glassfish](https://glassfish.dev.java.net/)?" - I am, I'm just using Tomcat as well, since a lot of the [OpenSSO](https://opensso.dev.java.net/) contributors use it. Their pain is my pain ![](http://blogs.sun.com/images/smileys/smile.gif)