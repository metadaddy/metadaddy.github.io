---
author: user
title: Customer Sabotage - Just What You Need in a Proof of Concept!
slug: customer-sabotage-just-what-you-need-in-a-proof-of-concept
id: 679
date: '2006-04-06 15:47:11'
layout: single
categories:
  - Access Manager
---

![](http://blog.superpat.com/wp-content/uploads/2009/09/1-CrossDomainSSO.gif){: .align-left} We conducted a proof-of-concept this week for a 'major manufacturer' (let's call them MM for short), showing Access Manager integrating with [Active Directory Federation Services](http://www.microsoft.com/windowsserver2003/techinfo/overview/adfsoverview.mspx) (ADFS) via WS-Federation. Briefly, the mechanism is that you attempt to access a protected resource and, if you don't have [Access Manager](http://www.sun.com/software/products/access_mgr/index.xml )'s SSO token (as a cookie), you are redirected to ADFS for authentication. ADFS authenticates you then sends a SAML assertion back to a servlet at Access Manager via the [HTML form POST/Javascript/onLoad trick*](#trick). The servlet validates the SAML assertion and, if all is well, issues an Access Manager SSO token as a cookie and redirects back to the originally requested resource and all proceeds according to the [regular Access Manager logic](http://docs.sun.com/app/docs/doc/819-2135/6n4ep9bvd?a=view). The neat thing is that, if you're logged into a Windows domain, ADFS can authenticate you without any interaction, so all of the above magically happens in the blink of an eye, and you get the resource you asked for according to the AM policy in force. Kind of like the [SPNEGO](http://blogs.sun.com/roller/page/superpat?entry=sun_java_system_access_manager) we all know and love, but all at a higher level, so it works better in large, complex multi-forest environments.

So - we get this all working (I'm remote at Sun's offices in Santa Clara, the PoC is at - uh - a secret location) and everyone there breaks for lunch. After lunch I get a slightly panicky call from the SE onsite (Hi, Bob!) saying that, inexplicably, it's no longer working. The browser isn't being forwarded to ADFS via AM's WS-Fed servlet - it's just going to the regular AM login page instead. Weird. I `tail -f` the logs, have them try again, and sure enough, the WS-Fed servlet is unmolested by traffic. I turn on the debug flag on the agent, `tail -f` the logs again and have them click the link. Whah!? The agent on the protected web server is redirecting to the [_CDSSO_](http://docs.sun.com/app/docs/doc/819-2135/6n4ep9bvf?a=view) servlet? Why? A glance in the agent config shows that, somehow, magically, CDSSO has been enabled.

As Bob and I try to figure out just what has happened, I hear a voice in the background saying something like "Uh - Oh - Um". One of MM's senior technical staff is ex-Sun. He's had a little tinker over lunch, applying his AM knowledge and trying one or two things out. And left CDSSO enabled. Which tells the agent to redirect to the CDSSO servlet instead of my nifty new WS-Federation servlet. `s/true/false/` on the 'enable CDSSO' property and all is working again. Phew!

Moral of the story. Never leave the customer alone in the PoC room with a logged in machine. Especially if they know enough to be dangerous!

<a name="trick"></a>* In case you don't know this one, it goes like this. Server A returns an HTML page with a form containing one or more hidden elements - one might be, for instance, an XML document - and whose action is to POST to Server B. The page also contains a JavaScript onLoad event handler that submits the form. The result is a little like a 302 redirect, except that you get to send a bunch more data than you can cram into a URL.