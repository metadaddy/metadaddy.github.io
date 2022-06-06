---
author: user
title: CDDL as a middle way
slug: cddl-as-a-middle-way
id: 481
date: '2007-10-08 11:22:23'
layout: single
categories:
  - General
---

In a [recent blog post](http://duckdown.blogspot.com/2007/09/thoughts-on-sun-cddl-license.html), [James McGovern](http://duckdown.blogspot.com/) reckoned that my "[perspective on CDDL is somewhat insular and indoctrinated](http://duckdown.blogspot.com/2007/09/thoughts-on-sun-cddl-license.html)". As I was wondering how to reply to this, there was some discussion on the [OAuth](http://oauth.net/) [mailing list](http://groups.google.com/group/oauth/) on the merits of different licenses. I posted this to the list this morning:

> As you survey the landscape of open source licenses ([http://opensource.org/licenses/alphabetical](http://opensource.org/licenses/alphabetical)), you should also consider whether CDDL ([http://opensource.org/licenses/cddl1.php](http://opensource.org/licenses/cddl1.php)) gives you what you're looking for.
> 
> _Disclaimer - I work for Sun Microsystems, on OpenSSO ([http://opensso.dev.java.net](http://opensso.dev.java.net)), a CDDL-licensed project. However, in this instance, I'm not shilling for Sun, just giving my personal opinion._
> 
> Based on the Mozilla Public License, CDDL attempts to balance the interests of different sides of the developer community - on a file-by-file basis, any modifications you make to CDDL-licensed source code must be made available under the CDDL, however, if you build CDDL into a 'larger work' you choose how to license your 'new' files.
> 
> This is essentially a middle course between GPL and Apache/BSD/MIT (they're not the same, but they do lie on the same side of the license spectrum). If I license my code to you under CDDL, you are free to use it as a component in a 'larger work', but you must make available any changes/fixes to my code.
> 
> Anyway - the main thing is to read the licenses, decide which one best fits your intentions, adopt it, and get back to the code. One thing some people overlook is that, as the actual copyright-holder, you are not bound perpetually by your initial license choice. Although the genie is out of the bottle regarding already licensed code, you can decide to stop licensing future versions under an open source license, switch licenses, add new licenses or whatever. Of course, you would consider the needs and preferences of the community that you have (hopefully) built around your code before taking any of these courses of action!

I truly believe that CDDL offers a useful middle path between the 'viral' ([all your code are belong to us](http://en.wikipedia.org/wiki/All_your_base_are_belong_to_us)) GPL and the 'permissive' (take what you like, just don't sue us if it doesn't work out) Apache/BSD/MIT, and this provides specific benefits for business.

James goes on to extrapolate somewhat from his lawyer friend's opinion:

> She mentioned that corporate friendly licenses permit redistribution without restrictions on commercial use and don't have broad retaliation clauses. In reading into her position, I would guess that she doesn't like Sun, IBM or Mozilla but would like likes such as GPL 2.0, Apache and MIT though.

Nice guess, James, but I'd like her unfiltered opinion after reading the licenses (you are correct in your suspicion that I've never had a conversation with any corporate lawyers whose primary business isn't technology). The [Apache 2.0 license](http://opensource.org/licenses/apache2.0.php) has a patent retaliation clause (my **emphasis**:

> 3\. Grant of Patent License.
> 
> Subject to the terms and conditions of this License, each Contributor hereby grants to You a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable (except as stated in this section) patent license to make, have made, use, offer to sell, sell, import, and otherwise transfer the Work, where such license applies only to those patent claims licensable by such Contributor that are necessarily infringed by their Contribution(s) alone or by combination of their Contribution(s) with the Work to which such Contribution(s) was submitted. **If You institute patent litigation against any entity (including a cross-claim or counterclaim in a lawsuit) alleging that the Work or a Contribution incorporated within the Work constitutes direct or contributory patent infringement, then any patent licenses granted to You under this License for that Work shall terminate as of the date such litigation is filed.**

I AM NOT A LAWYER, but this does not seem substantially different from the equivalent section of CDDL:

> 6.2\.
> 
> If You assert a patent infringement claim (excluding declaratory judgment actions) against Initial Developer or a Contributor (the Initial Developer or Contributor against whom You assert such claim is referred to as Participant) alleging that the Participant Software (meaning the Contributor Version where the Participant is a Contributor or the Original Software where the Participant is the Initial Developer) directly or indirectly infringes any patent, then any and all rights granted directly or indirectly to You by such Participant, the Initial Developer (if the Initial Developer is not the Participant) and all Contributors under Sections 2.1 and/or 2.2 of this License shall, upon 60 days notice from Participant terminate prospectively and automatically at the expiration of such 60 day notice period, unless if within such 60 day period You withdraw Your claim with respect to the Participant Software against such Participant either unilaterally or pursuant to a written agreement with Participant.

Understand, I'm not saying that CDDL is the license-to-end-all-licenses, but it is definitely worth considering as an option if you want a middle way.