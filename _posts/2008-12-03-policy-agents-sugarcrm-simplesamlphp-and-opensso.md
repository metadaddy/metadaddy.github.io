---
author: user
title: 'Policy Agents, SugarCRM, simpleSAMLphp and OpenSSO'
slug: policy-agents-sugarcrm-simplesamlphp-and-opensso
id: 325
date: '2008-12-03 22:19:42'
layout: single
categories:
  - OpenSSO
---

<div style="margin: 5px; float: right;">[![](http://blog.superpat.com/wp-content/uploads/2009/09/SugarCRM_logo.gif)](http://developers.sun.com/identity/reference/techart/index.jsp)</div>

A couple of great articles from [Sun Developer Network](http://developers.sun.com/) over the past two weeks... First on the roster, Sean Brydon and [Aravindan Ranganathan](http://blogs.sun.com/aravind/) team up with the ever-present [Marina Sum](http://weblogs.java.net/blog/marinasum/) for a short series entitled 'Protecting Applications With Java EE Policy Agents'. [Part 1:Basic Steps](http://developers.sun.com/identity/reference/techart/policyagents.html) provides an excellent grounding in just what a policy agent does, and how to deploy and configure one with [OpenSSO](http://opensso.org/). Download the sample Java EE web application and [work through the example that Sean and Aravindan present](http://developers.sun.com/identity/reference/techart/policyagents.html).

Next up, Thomas Varghese and Marina tackle [Single Sign-On for SugarCRM Through a SAML-Based Integration of OpenSSO and simpleSAMLphp](http://developers.sun.com/identity/reference/techart/sugarCRM.html). Regular readers will know that I have a soft spot for [simpleSAMLphp](http://rnd.feide.no/simplesamlphp/), since it evolved from the '[Lightbulb](http://blogs.sun.com/superpat/entry/switching_on_the_lightbulb)' SAML/PHP code that I wrote as a proof of concept many (Internet) years ago. Here, Thomas uses simpleSAMLphp as a lightweight bridge between the PHP-based [SugarCRM](http://sugarcrm.com/) and OpenSSO, showing how a fictitious SugarCRM hosting company provides single sign-on to its enterprise customers. In this context, simpleSAMLphp is effectively a PHP [Fedlet](http://blogs.sun.com/raskin/entry/the_fedlet_has_arrived_check), or perhaps the Fedlet is a Java simpleSAMLphp :-) . Either way - go [read all about it at SDN](http://developers.sun.com/identity/reference/techart/sugarCRM.html).