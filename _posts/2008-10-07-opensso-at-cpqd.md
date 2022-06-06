---
author: user
title: OpenSSO at CPqD
slug: opensso-at-cpqd
id: 358
date: '2008-10-07 22:00:15'
layout: single
categories:
  - OpenSSO
---

<span style="float: right;">[![](images/cpqd.png)](http://www.cpqd.com.br/)</span>

[CPqD](http://www.cpqd.com.br/) provides Operations Support and Business Support systems, training and consulting services to the telecommunications industry. [Mário Celso Teixeira](http://marioct.blogspot.com/), of CPqD's Brazilian facility, describes their [OpenSSO](http://opensso.org/) deployment in an email today to the users@opensso.dev.java.net mailing list:

> I want share with you that [CPqD](http://www.cpqd.com.br/) have deployed the OpenSSO as a single sign-on solution for 3000 users and 75 applications in October, 2008\.
> 
> After 4 months, 75 corporate applications was customizeds to use the single sign-on system where the user´s identity are provided for Windows Active Directory.
> 
> Primarily we went to install [CAS](http://www.ja-sig.org/products/cas/) server as a single sign-on product but, in April 2008, me ([Mario Celso Teixeira](http://marioct.blogspot.com/)) and [Gustavo Chaves](http://blog.gnustavo.com/) were at [FISL 9.0 in RS, Brasil](http://fisl.softwarelivre.org/9.0/www/) and saw the [Pat Patterson](http://blogs.sun.com/superpat/) [presentation](http://blogs.sun.com/superpat/entry/slides_from_opensso_presentation_at) and we decided test the solution.
> 
> The strategy adopted was to install the Policy Agents in the application servers that are used for our applications (IIS 6.0, Apache, Jboss, Tomcat) and not customize each one using Opensso API, to minimize implementation efforts.
> 
> After one week live in production, the users are very satisfied because, before, each user could have 15 different accounts and passwords to access the applications.
> 
> Next, we want to implement Federation and Identity Management

Wow. 75 applications in four months, across IIS, Apache, JBoss and Tomcat. That's impressive! Thank you for sharing your OpenSSO success story, Mário ![](http://blogs.sun.com/images/smileys/smile.gif)