---
author: user
title: My Thinking on Bloggers and Federated Identity
slug: my-thinking-on-bloggers-and-federated-identity
id: 720
date: '2006-01-03 16:39:47'
layout: single
categories:
  - Federation
---

[James McGovern](http://duckdown.blogspot.com/), Enterprise Architect at [The Hartford](http://www.thehartford.com/), posted a [series of questions](http://duckdown.blogspot.com/2005/12/thoughts-on-bloggers-and-federated.html) on federation and blogging just before Christmas. My Christmas vacation started just after he posted that entry, so I haven't had a chance to respond before today. So - here goes... Remember the disclaimer: these thoughts are my own and do not necessarily reflect the official line of [Sun Microsystems](http://www.sun.com), the [Liberty Alliance](http://www.projectliberty.org) or, indeed, reality ![](http://blogs.sun.com/roller/images/smileys/wink.gif). Oh - and my cut'n'paste didn't preserve links in the quotations from James' original. Sorry.

> Pat Patterson of Sun, commented on one of my comments I left in his blog and only partially responded to my rant that folks in the blogging community need to take an enterprise view to identity and not just evangelize the Liberty Alliance...

I think you're mischaracterizing the 'blogging community' a little there, James. I don't see [Kim Cameron](http://www.identityblog.com/) doing much evangelizing on behalf of Liberty ![](http://blogs.sun.com/roller/images/smileys/wink.gif).

> Figured the best way to make my point would be to ask these same bloggers to respond in their own blogs, answers to the following questions:
> 
> *   The Liberty Alliance is a wonderful organization that is working towards interoperability but doesn't have as a charter the notion of community formation as this typically occurs within a specific industry vertical. Examples include the SAFE initiative in pharma and Securities.Hub on Wall Street. Do bloggers who work for software vendors have any duty to enable (or at least talk about) the notion of best practices around community formation at an industry vertical level? If so, do they strictly talk in terms of case studies of what has occured in the past or provide guidance to verticals that haven't yet walked this path?

Wow. Well, personally, I certainly don't feel qualified to enable or talk about best practices in community formation at an industry vertical level. In a previous life, I was involved with [Identrus](http://www.identrus.com/), a consortium of financial institutions working first to enable global authentication of business partners, then to establish a secure payment initiation system, but I worked on the architecture and implementation of the specs. (Heh - I just found [this](http://www.identrus.com/knowledge_center/pub/Sun.pdf) on the Identrus site. The [iPlanet](http://en.wikipedia.org/wiki/IPlanet) brand is long gone, of course, as are some of the listed products. I worked on [iPlanet Trustbase Transaction Manager](http://docs.sun.com/source/816-6288-10/ittm22db.htm), the last version of which end-of-lifed in Feb 2003.) Anyway - perhaps [Robin Wilton](http://blogs.sun.com/roller/page/racingsnake), also a Trustbase alumni, would have a few thoughts on vertical community formation, since he was more on the business side of things.

> *   Identity Bloggers pretend that notions such as Sarbanes Oxley don't exist (or at least never mention them). Do they think that federations also need the notion of attestation? If so, don't you think this will become an impediment to corporate adoption of federated identity for many verticals?

Have you read [Sara Gates](http://blogs.sun.com/roller/page/saragates)' (Sun's VP of identity management) blog recently? Sara is very interested in Sarbox and compliance - in fact, she wrote this [article](http://www.sun.com/emrkt/campaign_docs/idmgmt/newsletter/1005feature.html) recently comparing compliance demands to seatbelt laws.

I think that identity management has a huge part to play in compliance. In fact, Sun has a product dedicated to auditing compliance - [Identity Auditor](http://www.sun.com/software/products/identity_auditor/index.xml). You are spot on in highlighting the need for attestation in federation. I think this will be an area that Liberty will turn to in future.

> *   SAML 2.0 is a good move to increase interoperability and should be implemented in all security oriented products. Maybe you can tell us why within the enterprise we should use SAML 2.0 between say Active Directory and RACF vs. sticking with tried and true approaches such as Kerberos?

You use the appropriate tool for the job. Where there is a tried and true approach then use it. For example, if you are implementing single sign-on between some group of websites in the same internet domain, then it would be madness to use SAML 2.0 rather than simply deploying a web-based access management product such as Sun's [Access Manager](http://www.sun.com/software/products/access_mgr/index.xml). However, if you are implementing single sign-on between siloed (silo'd?) divisions of an enterprise, each with its own identity management infrastructure, or between an enterprise and a trading partner, then SAML 2.0 is the appropriate tool for the job.

> *   The Liberty Alliance can only point to a handful of Fortune 100 enterprises (non-software) that have joined. Its primary makeup is most of software vendors. Maybe you could tell us why an Enterprise Architect that works for a Fortune 100 enterprise would request for next years budget the annual dues for membership vs spending it in other areas?

Well - one motivation would be to redress the balance ![](http://blogs.sun.com/roller/images/smileys/smile.gif). Seriously, though, with Liberty membership you're buying a voice in the standards setting process - the ability to ensure that enterprise concerns are heard.

> *   Do you think that enterprises are well-served by consolidating identity stores vs keeping them spread all over the place and doing SAML? If consolidation is a good thing, why wouldn't it be a good idea to consolidate identity within Active Directory?

Consolidation is a _great_ thing, though I would counsel Sun's [Directory Server](http://www.sun.com/software/products/directory_srvr_ee/index.xml) over Active Directory, of course. However, consolidation isn't always possible:

*   In the case of an acquisition or merger, consolidation can be a costly and time-consuming process. It's still worthwhile, but often an interim solution is needed to bridge identity infrastructures.
*   Legislation may preclude consolidation - for instance, a multinational corporation may not be able to store all identity data in one location. Or even provide access to more than a strict subset across national boundaries.
*   Consolidation isn't always feasible - [Radovan Semančík](http://storm.alert.sk/blog) talks about this in a [recent blog entry](http://storm.alert.sk/blog//identity/enterprise/re-mcgovern-1.html).

So - I would say, consolidate as far as possible (or sensible) and use federation to bridge to disparate environments.

> *   Should SXIP, LID and SAML exchange tokens from one system to those in another or should they continue to do their own thing with their own tokens? If the later, could this really be considered an identity metasystem according to Kim Cameron's laws of identity?

Ah - user-centric identity. I can't really comment here - I keep an eye on what folks like [Sxip](http://sxip.com/) and [Netmesh](http://netmesh.us/) are up to (e.g. [YADIS](http://yadis.org/wiki/Main_Page)), but I can't pretend to any expertise. [Chuck Mortimore](http://xmldap.blogspot.com/) (Sxip) and [Johannes Ernst](http://netmesh.info/jernst) (Netmesh) (to pick two almost at random) are much bette r qualified than I am to speak on thse issues. And, of course, the mighty [Kim Cameron](http://www.identityblog.com/) would be best placed to judge whether this is a metasystem according to his definition.

> *   If you want corporations to embrace the notion of federated identity, wouldn't it require more than simple "look at me" interoperability demos and for all the vendors in this space to create some publicly available notion of "reference architecture" above and beyond what exists in Project Liberty?

We've [done some work in this area](http://blogs.sun.com/roller/page/superpat?entry=mobile_operator_federation_web_services), but much more remains to be done. Yes, I know that particular paper addresses a set of telco use cases, but the principles apply across industry boundaries.

> *   Acknowledgement that not all problems are technology related and consider asking the Liberty Alliance to take on social / governmental issues related to identity in the same way that Richard Stallman does for the Free Software Foundation. Examples include mechanisms that will allow an industry vertical to form communities without the appearance of collusion. What about certain countries such as Italy that create laws that violate current thinking on identity? Have you seen this article?

Have you been to the Liberty website recently? There are vertical industry sections on [Identity Theft Prevention](http://www.projectliberty.org/resources/featured_verticals.php), [Healthcare](http://www.projectliberty.org/resources/featured_verticals_health.php), [Guidelines](http://www.projectliberty.org/resources/guidelines.php) on subjects from the implications of [EU Data Protection and Privacy Law for Establishing a Legal Framework for Identity Federation](http://www.projectliberty.org/specs/Circles_of_Trust_Legal_Framework_White_Paper_322200522576.pdf) to [federation enabling 401(k)](http://www.projectliberty.org/resources/whitepapers/liberty-biz-tier2-401k.pdf). This is all there for the taking - no membership required.

Liberty Alliance's [Public Policy Expert Group](http://www.projectliberty.org/activities/public_policy.php) "drives dialogue with global government and nongovernment groups concerned with the many issues pertaining to identity and data management". For instance [Benefits of Federated Identity to Government](http://www.projectliberty.org/resources/whitepapers/Liberty_Government_Business_Benefits.pdf).

Read [Robin Wilton's Esoterica](http://blogs.sun.com/roller/page/racingsnake) for regular articles on social / governmental issues relating to the Liberty Alliance, Sun and identity management in general.

> *   More thinking on how identity changes based not on the person but their interaction? Examples may include the notion of "six degrees of separation" or minimally the practice of role affliation?

Not a topic I can really address in a bullet point reply, but, yeah - interesting. Is a role an identity?

> *   How should we think about SmartCards within our own infrastructure and how it plays with federated identity? I know MS is doing this for their own employees.

Well, smartcards as an authentication mechanism play nicely with federated identity. A SAML assertion can (in fact, usually does) identify the mechanism by which the user authenticated, so architecting systems that require smartcard authentication to access a given set of resources is perfectly possible.

> *   Should we have a mechanism for discovery of capabilities for various identity systems? Should it be YADIS? Something else?

Good question. Is this what Kim's metasystem will turn out to be? Will YADIS do this? Is there room for more than one metasystem? In that case, do we need a metametasystem???

> *   Any thoughts on how federated identity can integrate with Digital Rights Management?

I'm going to play the "not Sun's opinion" card here... In the light of Sony's recent DRM nightmares, I think DRM needs a total rethink. Can DRM work at all? Should content providers' business models change to reflect the realities of the digital world?

> *   Any thoughts on how Liberty Alliance can embrace the notion of a Virtual Personality?

What do you mean by 'virtual personality'. I just checked the [Identity Gang](http://www.identitygang.org/)'s [lexicon](http://www.identitygang.org/Lexicon) and even they haven't figured out what it means yet.

> *   What if we decided to externalize identity and put it on a spacecraft headed to pluto? Dont take this question seriously.

I'd go back to coding [technical analysis](http://www.investopedia.com/university/technical/) systems. Don't take this answer seriously.

> *   How come pretty much all of the identity bloggers don't support trackback in their blogs? Is it because they haven't yet figured out how to protect their own identity or that of others?

The short answer is trackback spam. I provide trackback links. Sometimes they work. Sometimes the spam load is so heavy we just turn them off. There is no easy solution right now. I believe the user-centric guys are working on this...