---
author: user
title: Best week / worst week
slug: best-week-worst-week
id: 708
date: '2006-02-09 09:07:00'
layout: single
categories:
  - General
---

I started this as a comment on a [post](http://jroller.com/page/jaimec?entry=can_i_be_fired_please) by [Jaime Cardoso](http://jroller.com/page/jaimec). It grew and grew, so I'm posting it here...

Back in prehistory (1998), when I was working for the tiny startup company in London that would be acquired by Sun in 2000, we were building a smartcard demo to be shown on the Sun stand at Cartes 98 - a major smartcard conference in Paris. We built a demo that ran on 5 [JavaStation](http://en.wikipedia.org/wiki/Javastation)s (remember those?) showing an 'ATM' that moved cash from your back account to the card, then you went to the travel agent machine and bought an airline ticket with that cash, the ticket being stored on the card. The you went to the checkin at the airport and, you guessed it, exchanged the ticket for a boarding card. Finally you went to the gate and the boarding card was removed from the smartcard. The fifth machine was a home banking terminal that showed you what was on the card at any stage in the demo, so you could see that it was all real - no smoke or mirrors.

Anyway - we spent weeks building this thing. Then, less than two days before the Sun guy arrived from California to do the acceptance test, we had a break in. They stole the server running the demo. Arse.

Luckily, the server had an external SCSI disk pack that was left intact. We waited ALL DAY for a replacement 'pizza box' and worked through the night to re-install Oracle (the runtimes were on the root partition of the stolen box, but the tables were on the disk pack) and get everything working.

Sun guy arrived the next day (Hi Eric M!) and did the acceptance test about 30 minutes after we finished rebuilding the demo. It worked great! Then, with the project manager clucking around like a chicken, insisting we make a backup, and with no sleep for 28 hours, I messed up a zip command and zipped each file in the root file system in place. Solaris REALLY doesn't like it when you do that, especially when you hit directories like /etc.

I'm not ashamed to say that I was in tears. This was Friday morning - we were taking the server to Paris on Sunday. I went home, slept for a bit. One of the office heros reinstalled Solaris onto the root partition, so that night I dialled in from home, installing Oracle again and rebuilding the demo. I was getting pretty good at this by now :-)

So - we got it all working again, got the train to Paris and worked another night 'polishing' the now-functional demo. Three overnights in one week. Best week of my professional life, worst week of my professional life :-)