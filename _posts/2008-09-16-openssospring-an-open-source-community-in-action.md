---
author: user
title: OpenSSO+Spring - an Open Source Community in Action
slug: openssospring-an-open-source-community-in-action
id: 371
date: '2008-09-16 06:04:16'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://blog.superpat.com/wp-content/uploads/2009/09/springseraph.png)](https://opensso.dev.java.net/public/extensions/#authnproviders)</span>

On Friday morning, Jim Gellman of the [Institute for Systems Biology](http://systemsbiology.org/) [asked a question on the OpenSSO Users mailing list](https://opensso.dev.java.net/servlets/ReadMsg?listName=users&msgNo=4484) about [OpenSSO](http://opensso.org/)/[Spring Security](http://static.springframework.org/spring-security/site/index.html) (formerly known as Acegi) integration:

> We'd like to use opensso with an app that's using Spring Security currently, but we don't have the resources at the moment to develop a module to do this.
> 
> Instead we're hoping we can use Spring Security's container adapter for tomcat along with the OpenSSO agent. Does anyone know for sure whether this is a reasonable approach?

Just a few minutes later, Robert Dale of [CALGB](http://www.calgb.org/) [replied](https://opensso.dev.java.net/servlets/ReadMsg?listName=users&msgNo=4487):

> I actually have code based on acegi-security 1.0.3 that provides an AuthenticationProvider, LogoutHandler, AuthenticationProcessingFilter, and AuthenticationProcessingFilterEntryPoint. I would be more than happy to donate to OpenSSO extensions if they want it.

How can you refuse an offer like that? Actually, it turns out that Robert had also done some work with [Seraph](http://docs.atlassian.com/atlassian-seraph/latest/) ([Atlassian](http://www.atlassian.com/)'s security framework, used by [Jira](http://www.atlassian.com/software/jira/) and [Confluence](http://www.atlassian.com/software/confluence/)). So, this morning I created two new ['Authentication Provider' OpenSSO Extensions](https://opensso.dev.java.net/public/extensions/#authnproviders) - one for Spring and one for Seraph - and Robert checked in his code. If you've been scratching your head, wondering how to integrate OpenSSO with Spring or Seraph, [go check 'em out!](https://opensso.dev.java.net/public/extensions/#authnproviders)