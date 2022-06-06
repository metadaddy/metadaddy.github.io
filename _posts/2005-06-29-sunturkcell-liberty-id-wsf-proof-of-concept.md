---
author: user
title: Sun/Turkcell Liberty ID-WSF Proof of Concept
slug: sunturkcell-liberty-id-wsf-proof-of-concept
id: 761
date: '2005-06-29 19:59:50'
layout: single
categories:
  - Federation
---

Great news in my inbox today: [Sun](http://www.sun.com) and [Turkcell](http://www.turkcell.com.tr/) ([English-language version of Turkcell site](http://www.turkcell.com.tr/index/0,1028,300427,00.html)) have [published a paper](http://www.projectliberty.org/resources/whitepapers/turkcell_sun.pdf) on a recent proof of concept. Turkcell used Liberty's <acronym title="Identity Web Services Framework">ID-WSF</acronym> to implement an SMS service fulfilling three key requirements:  
![](images/2005_06_29_20-34-10-948_n2.jpg)

*   Protect subscriber privacy - subscribers' cellphone numbers (referred to as MSISDNs in the document) must not be revealed to 3rd party service providers.
*   Leverage subscriber location, again, while protecting subscriber privacy.
*   Use standards and off-the-shelf products wherever possible.

Turkcell used [Sun Java System Access Manager](http://www.sun.com/software/products/access_mgr/index.xml) as their identity provider, with an early access release of [Sun Java System Federation Manager](http://www.sun.com/software/products/federation_mgr/index.xml) at the service provider. According to the document, "[Turkcell] successfully conducted a PoC project that has resulted with the accomplishment of all pre-defined requirements." Also, "We have found that the Liberty Alliance Specifications are brilliantly matching our needs and even exceeding in some ways."   
In the use case scenario, a GSM user sends a service request via SMS to a service provider to discover restaurants near the user's location. The service provider leverages the wireless operator's geo-location service, customizes content, and returns a corresponding list of restaurants back to the user.  
Go read the paper and discover exactly how Sun's federation products and Liberty ID-WSF met Turkcell's requirements, and then some.