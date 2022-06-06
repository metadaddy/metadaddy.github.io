---
author: user
title: Amex's Michael Barrett on Sun Identity Management
slug: amexs-michael-barrett-on-sun-identity-management
id: 713
date: '2006-02-02 15:19:33'
layout: single
categories:
  - Identity
---

[James Governor](http://www.redmonk.com/jgovernor/) at [RedMonk](http://www.redmonk.com/) is my new analyst hero. Here's an excerpt from [his report](http://www.redmonk.com/jgovernor/archives/001246.html) from [Sun's Analyst Summit](http://www.sun.com/aboutsun/media/analyst/sas2006/) yesterday:

> Identity management is the key to Sun's software story. IBM and Sun are probably the only two players in the industry going to win customers planning to roll out tens of millions of identities. Oracle- maybe in a couple of years from an architectural and sales model perspective. Microsoft? AD is unproven at that scale. No - the kind of deals that we'll see more of - Orange and Amex - that is likely to be an IBM Sun shootout.
> 
> I talked to [Michael Barrett](http://www.windley.com/cgi-bin/printthis.pl?url=http://www.windley.com/archives/2004/03/the_need_for_id.shtml) from Amex this morning. He told me Sun's identity management tools were far and away the best in the market. This after a very thorough due diligence process. 100k enterprise identities, tens of millions of consumer identities, and millions on the B2B side - and that is a Sun win. Did I remember to say Michael likes the new Niagara servers? That is another customer that has [kicked the T-1's tyres](http://www.redmonk.com/jgovernor/archives/001156.html) and liked the feel. On a related not this puchasing decision also has to be great news for the [Liberty Alliance](http://www.projectliberty.org/). WS-I - What's that? Amex is evidently going to put its federation thinking into practice...

[Amex recently chose Sun's Java Enterprise System](http://www.sun.com/smi/Press/sunflash/2006-01/sunflash.20060125.2.html) as the environment for their distributed applications, identity management and web services - this snippet gives some insight into the reasoning behind that choice.

It's interesting that James picks up on scalability as a key concern - particularly when you're talking about consumer identities. Many of our customers have tens of millions of customers of their own. We test our identity management software in these kind of environments - here's an excerpt from the [Sun/Nokia white paper I mentioned about a year ago](http://blogs.sun.com/roller/page/superpat?entry=mobile_operator_federation_web_services):

> [[Sun Java System] Access Manager](http://www.sun.com/software/products/access_mgr/index.xml) has proved capable of being scaled up to meet operators’ needs – in a recent federation benchmark, Access Manager provided federated single-sign on to a simulated user population of 80 million, handling over two million federation transactions (SSO/link accounts/unlink accounts) per hour with response times below one second.
> 
> Finally, the Java System Access Manager extends and leverages the carrier grade [Sun Java System Directory Server](http://www.sun.com/software/products/directory_srvr_ee/index.xml), the most widely deployed general purpose LDAP Server in the operator market. The Sun Java System Directory Server has 1.5 billion entries deployed, it has been benchmarked with 160 million entries...

Now that Access Manager benchmark was done nearly 18 months ago. I wonder how it would do on some of the [new kickass](http://www.sun.com/servers/coolthreads/overview/index.jsp) [Sun hardware](http://www.sun.com/servers/index.jsp?cat=Sun%20Fire%20x64%20Servers&tab=3)...?