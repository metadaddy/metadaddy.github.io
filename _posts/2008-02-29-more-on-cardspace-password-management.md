---
author: user
title: More on CardSpace Password Management
slug: more-on-cardspace-password-management
id: 438
date: '2008-02-29 13:16:46'
layout: single
categories:
  - Identity
---

<span style="margin: 5px; float: right;">![](images/infocard_184x128.png)</span>

I wrote an entry on Tuesday about [CardSpace as a Password Manager](http://blogs.sun.com/superpat/entry/cardspace_as_a_password_manager). [Kim](http://www.identityblog.com/) [responded with a request](http://www.identityblog.com/?p=932): _"I’d like to hear Pat’s ideas about the user experience of bootstrapping the passwords into the Identity Provider."_.

Well, I see this happening at the relying party (RP) - if you already had an account there you would go to some 'change password' page containing the information card 'script' to invoke the identity selector and proceed as I detailed in [the earlier post](http://blogs.sun.com/superpat/entry/cardspace_as_a_password_manager). When the identity provider (IP/STS) receives this initial request, it will see that it has no password for that RP/user, create (and record) a new one and send it to the RP, which will write it into the user's entry exactly as if the user had just typed it in.

If you didn't have an account, the relying party would do the information card thing as part of the signup, as an alternative to just prompting you for a password. In both cases, the relying party could display the password on screen (probably requiring a mouse click to 'unmask' it) so the user could independently make a note if she really wanted to.

In all three cases, signup, login and change password, it's the same code from the RP point of view - just a way of getting a password from the user. And, in both cases, the password could be nice and strong, since the user doesn't really need to remember it. One other detail is that the RP would need to communicate its password policy (e.g. 5-12 characters, alphanumeric plus !, @, #, $, %) to the IP/STS; **sp:RequestSecurityTokenTemplate** looks like it could carry that in its optional **wsp:Policy** element.

Going further, [Gerry](http://blog.beuchelt.org/) [posted this morning](http://blog.beuchelt.org/2008/02/29/Windows+CardSpace+And+Passwords.aspx) on how the identity provider could even provide a _series_ of strong, one time use, passwords, providing additional security, albeit with some incremental complexity at the RP.

[Ben](http://www.links.org/) [raises the bootstrap question, and also says](http://www.links.org/?p=300) (paraphrasing slightly) _"If we derive an RP password from a master password and the RP site’s name, we can eliminate the IdP and do the whole thing locally, using the master password."_. Yes - I use [Hashapass](http://www.hashapass.com/) to exactly that, manually (of course, I saved the page to disk, examined the JavaScript and only ever run it from my disk copy), but there are some trade-offs here. One is that this is yet another piece of client software to get onto everybody's machine. Not impossible, but a hurdle. The other issue I see is the 'keys to the kingdom' attack. If an attacker obtains the master password, then all the RP logins are compromised instantly and the only mitigation (as far as I can see) is to go round each and every one individually, changing passwords and cleaning up any mess. With an identity provider, there is still a master password that can be compromised in the same way, but the mitigation is rather different. Change your password at the identity provider and (assuming the identity provider has this information) obtain the identity provider's record of which RP's you've authenticated to. If you were encrypting the passwords in transit between the IdP and RP, you wouldn't even need to change your password at any RPs, since our attacker may have logged in as you, but would not have any of the RP passwords.

Now, [Eric Norman](http://ejnorman.blogspot.com/) [commented](http://blogs.sun.com/superpat/entry/cardspace_as_a_password_manager#comment-1204259168000):

> I don't get it.
> 
> In this scheme, all three of IdP, identity selector, and RP need to speak the information card protocols. If they do that, then why not just use the regular information card stuff?
> 
> Is there something missing in the information card protocols whereby these password tokens would add value? If so, what is it?
> 
> This looks to me like it's just adding more code and complexity without adding any value.

That's a good question - where is the benefit here, and to whom? Well, the benefit for the RP over the regular information card model is that the RP does not have to correlate Information Card Private Personal Identifiers (PPID's) with user accounts. At the cost of adding some minimal code to the login process (parsing username/password from a posted information card token, rather than from the usual form fields), the RP enables CardSpace login. The RP doesn't need to add a PPID column to its user table and doesn't need a strategy for linking incoming PPIDs with existing accounts. If the RP is running some off-the-shelf web application, with no access to its underlying user management model, this could be very useful, indeed.

For the user, this allows them to use strong passwords with a huge potential population of web sites, all based on a single authentication to their identity provider, this authentication via an identity selector such as Windows CardSpace, rather than a web page in a browser.

For the identity provider, this is a value-added service that it could either charge for, or (more likely) provide free-of-charge as a competitive differentiator.