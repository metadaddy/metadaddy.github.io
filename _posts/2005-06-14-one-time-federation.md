---
author: user
title: One-time Federation
slug: one-time-federation
id: 766
date: '2005-06-14 14:13:40'
layout: single
categories:
  - Federation
---

I had a question today from a Sun contractor in Europe. He was asking how Liberty provides for federation where the user does not have an account at the service provider - the 'SAML 1.1' case. The answer is _one-time federation_, described in section 1.2 of [Liberty ID-FF Protocols and Schema Specification](http://www.projectliberty.org/specs/draft-liberty-idff-protocols-schema-1.2-errata-v3.0.pdf). The spec says "service providers can [...] request a non-persistent, one-time only, anonymous name identifier for the Principal." You can search that PDF for 'onetime' to find out more.  
While googling for this information (I find Google is the quickest way to find stuff hidden away in PDFs) I found a very useful document at Entrust - [Liberty Example Scenario - Anonymous B2B](http://www.entrust.com/resources/download.cfm/21322/liberty-scenario.pdf) - that does a great job of explaining exactly this scenario, including how the service provider can obtain more than just the one-time name identifier by using ID-WSF to request attributes or by pre-arranging for attributes to be present in the ID-FF assertion. Three cheers to Entrust for a very lucid description of one-time federation.