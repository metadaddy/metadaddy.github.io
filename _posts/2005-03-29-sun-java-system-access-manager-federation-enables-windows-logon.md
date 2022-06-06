---
author: user
title: Sun Java System Access Manager Federation-Enables Windows Logon
slug: sun-java-system-access-manager-federation-enables-windows-logon
id: 791
date: '2005-03-29 08:44:30'
layout: single
categories:
  - Federation
---

Nice to see Ping Identity [catching up with](http://www.pingidentity.com/news/showPressRelease.action?id=51) functionality that Access Manager has provided for a whole year now. Access Manager 6.2 (released in 2004Q2) introduced Windows Logon authentication via SPNEGO tokens over HTTP - the protocol is [described by Microsoft here](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnsecure/html/http-sso-1.asp). Access Manager federation-enables [_all_ of its authentication modes](http://docs.sun.com/source/817-7647/enabauth.html), from username/password against LDAP through Windows Logon to smartcards and other hardware tokens.  
We don't stop there, either. From the current version (6.3, aka 2005Q1), Access Manager generalises the mechanism to any other platform that can provide a Kerberos ticket via a compliant browser (for example, Mozilla/Firefox), so you can authenticate to the Solaris or Linux desktop and access protected resources wherever they may be.  
Beat that, Ping.