---
author: user
title: More on ActivIdentity 4TRESS and OpenSSO
slug: more-on-actividentity-4tress-and-opensso
id: 443
date: '2008-02-15 13:18:31'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://blogs.sun.com/theaquarium/resource/ai_logo.gif)](http://developers.sun.com/identity/reference/techart/4tress.html)</span>

Marc Puverel at [ActivIdentity](http://www.actividentity.com/) emailed me today to point out that ActivIdentity provides an online service for 4TRESS evaluation. As Marc says, [it's all in the docs](https://opensso.dev.java.net/source/browse/*checkout*/opensso/extensions/authn4tress/doc/Installation%20Guide.html?rev=1.1):

> ActivIdentity provides an online service that you may use to evaluate the Sun OpenSSO integration with ActivIdentity 4TRESS Authentication Server. In such case make sure your platform has access to Internet, then you can use the following settings:
> 
> *   4Tress URL Endpoint: http://66.126.185.111:9090/4TRESSSoap/services/Authenticator-11
> *   4Tress Channel Code: CH_WEB
> *   4Tress Authentication Type Code: DYNMC_AUTH
> *   4Tress Authentication Mode Synchronous : SYNCH
> *   4Tress Security Domain: DOMAIN1
> 
> You will have to log out of AM as the administrator before you can test the login module.
> 
> To test the login Module, use the URL http://<FAM_HOST>:<FAM_PORT>/opensso/UI/Login?module=<MODULE_NAME>. You should see the following login page:[![4Tress LoginPage](https://opensso.dev.java.net/source/browse/*checkout*/opensso/extensions/authn4tress/doc/4TRESSOTPDiagramFigure3.png)](https://opensso.dev.java.net/source/browse/*checkout*/opensso/extensions/authn4tress/doc/4TRESSOTPDiagramFigure3.png)  
> 
> If you use ActivIdentity 4TRESS Online service you can use the following credentials to test user authentication:
> 
> *   Username: CUSTOMER
> *   Password: OpenSSO
> 
> You may want to evaluate Sun Access Manager authentication using Strong Authentication. Send an email to [OpenSSO@ActivIdentity.com](mailto:OpenSSO@ActivIdentity.com) with the following information:
> 
> *   Company
> *   First Name
> *   Last Name
> *   Email
> *   Telephone
> *   Country
> 
> ActivIdentity will provide you a personal user account and a list of One Time Passwords. You may use these pre-generated One Time Password to have an overview of the end user experience and the associated security.

So, you can give the new authentication module a try, even if you _don't_ have 4TRESS installed.