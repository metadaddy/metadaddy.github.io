---
author: user
title: The Fedlet Lives!!!
slug: the-fedlet-lives
id: 405
date: '2008-05-01 15:19:37'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://blogs.sun.com/raskin/resource/Daniel_images/Piglet_Teaser.jpg) ](http://opensso.org/)</span> 

If you're following [OpenSSO](http://opensso.org/) at all, you can't have failed to notice the recent buzz around the [Fedlet](http://blogs.sun.com/raskin/entry/identity_buzz_podcast_the_fedlet) - from [Daniel (complete with screencast)](http://blogs.sun.com/raskin/entry/the_fedlet_has_arrived_check), [Eve](http://www.xmlgrrl.com/blog/archives/2008/04/24/federation-in-the-diminutive/) [Mark D](http://blogs.sun.com/identity/entry/the_fedlet_has_arrived), [Mark H](http://blogs.sun.com/musings/entry/latest_news_on_the_fedlet), [Tatsuo](http://blogs.sun.com/tkudo/entry/fedlet_implementation_available_in_opensso), [Derrick](http://blogs.sun.com/harcey/entry/fedlet_comes_out_with_a), [Marina](http://weblogs.java.net/blog/marinasum/archive/2008/04/how_to_effect_i.html) and [Daniel](http://blogs.sun.com/idmbuzz/entry/finally_the_fedlet_has_arrived) at Sun to [Coté](http://www.redmonk.com/cote/2008/04/24/the-fedlet-sun-identity-buzz-episode/) at [RedMonk](http://redmonk.com/) and [Enrico](http://www.tenthline.com/blog/2008/04/30/the-fedlet-federated-sso-made-easy/) at [Tenthline](http://www.tenthline.com/).

Briefly, the 'Fedlet' is a package that a SAML 2.0 identity provider can create to quickly federation-enable a small service provider. The idea is that, if you're running a single web application, you're not going to want to deploy a whole 'nother server to run a standalone service provider. What you want is a little package of code and configuration to federation-enable your web app. You want the Fedlet.

I've been wrapped up in demos and travel for the past month or so, so I haven't had much of a chance to play with the Fedlet. Since I'm planning to demo it in my session at CommunityOne on Monday, I thought I'd better do so - I set aside this afternoon to get it working. Turns out I was a little pessimistic there - here's what I did, in less than an hour:

*   Update from OpenSSO CVS (`cvs -q update -dP`)``
``*   Cleaned out previous build detritus and built the WAR file (`ant clean && ant server-war`)````*   Deployed onto [Glassfish](http://glassfish.org/) (don't forget to change GF's `-client` JVM option to `-server`, [as detailed in the release notes](http://download.java.net/general/opensso/stable/openssov1-build4/B4-ReleaseNotes.html)!)*   Pointed [Flock](http://flock.com/) (my preferred web browser _du jour_) at the newly deployed OpenSSO at http://demo.example.com:8000/opensso (I alias demo.example.com to 127.0.0.1 in /etc/hosts), configured OpenSSO to use the embedded [OpenDS](http://opends.org/) instance for its configuration and user stores.*   Logged in as amadmin, created a SAML 2.0 identity provider and a Fedlet.*   Unzipped the Fedlet, deployed it into Glassfish.*   Ran the Federation validator to check that SSO is operational.*   And...  
    [![](http://blog.superpat.com/Validated.png)](http://blog.superpat.com/Validated.png)````

 ``When you spend your time in the weeds of a project, you always half expect any given step to fail due to some issue or another. Perhaps some recent fix destabilized something; perhaps some errant process has eaten my laptop's memory; whatever. So it was extremely gratifying when all of the above passed off without a hitch. I won't tell you what I muttered under my breath as the federation validator completed and gave me the thumbs up, but the second word was "cool!" ![](http://blogs.sun.com/images/smileys/smile.gif)``