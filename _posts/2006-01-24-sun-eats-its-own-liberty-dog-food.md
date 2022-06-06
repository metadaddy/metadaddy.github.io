---
author: user
title: Sun Eats Its Own Liberty Dog Food
slug: sun-eats-its-own-liberty-dog-food
id: 716
date: '2006-01-24 22:27:00'
layout: single
categories:
  - Federation
---

![](http://bipac.org/images/logo.gif){: .align-left} One question that I'm often asked by customers is "How is Sun using the [Liberty Alliance Project](http://www.projectliberty.org) specifications?". Well, my stock answer is 'BIPAC'. The [Business Industry Political Action Committee](http://bipac.org/) provides expert policy analysis, research and communications on campaigns and elections, and fosters business participation in the political process. Sun employees can access political information on the BIPAC website - who their elected representatives are, their voting record etc.

Now, this is obviously sensitive stuff, with huge implications for privacy. The 'old way' of accessing BIPAC would have involved a regular batch process to synchronize identity information from Sun to BIPAC; Sun employees would authenticate at BIPAC with their Sun ID and a BIPAC-specific password. In this old model, BIPAC would know exactly who I was and would be able to build a profile of my activity on the site. Not only that, I'd have another password to <s>write on a post-it note and stick to my monitor</s> remember.

The 'new way' of accessing BIPAC authenticates employees at Sun (using [Sun Java System Access Manager](http://www.sun.com/software/products/access_mgr/index.xml)) and uses [Liberty ID-FF](http://www.projectliberty.org/resources/specifications.php#ID-FF_Specs) to give employees single sign-on to BIPAC. Now - here's the clever bit - **no personal information is transmitted in the single sign-on process**. BIPAC have no idea who I am - all they know is that I am an authenticated Sun employee. BIPAC can then use [ID-WSF](http://www.projectliberty.org/resources/specifications.php#ID-WSF_Specs) to retrieve a strictly limited set of attributes, including my zip code. So now, all Sun know is that I am a Sun employee in 90210 (well, I can dream). They have everything they need to tell me who my elected representatives are at every level up to Dubya, but no more. They don't know _who_ I am, since they don't _need_ to know who I am. [This document](http://www.sun.com/software/products/identity/ss_bipac_sun_id_mgmt.pdf) gives some more detail on the deployment. Here I am demonstrating the system at a Liberty eGovernment Forum last year in Dublin:

![](http://blog.superpat.com/wp-content/uploads/2009/09/BIPACDemo.gif)

Looking at the wider context, this was an ideal first deployment of Liberty for Sun. A real need for Liberty's privacy features combined with low risk - BIPAC is a valuable service, but not critical to Sun's core business. Watch this space for news as we roll Liberty and SAML out across Sun's other business partners, and, if you're at the RSA Conference next month, be sure to catch Sun's Yvonne Wilson at [IMP-101 'Implementing Federated Identity: What Products Do You Need?'](https://cm.rsaconference.com/US06/catalog/profile.do?SESSION_ID=2174). Yvonne is an architect in Sun IT and will be covering our BIPAC integration in her presentation.