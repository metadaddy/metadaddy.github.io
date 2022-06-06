---
author: user
title: CardSpace as a Password Manager
slug: cardspace-as-a-password-manager
id: 441
date: '2008-02-26 17:13:34'
layout: single
categories:
  - Identity
---

<span style="margin: 5px; float: right;">![](images/infocard_184x128.png)</span>

You might have noticed the exchange between [Ben](http://www.links.org/) and [Kim](http://www.identityblog.com/) over the past day or two... Ben made a point that [CardSpace makes OpenID redundant](http://www.links.org/?p=297) - why not just send a password to the RP? [Kim jumped all over him](http://www.identityblog.com/?p=924) - somewhat misinterpreting what Ben later describes as [one of my most diabolical hungover bits of prose ever](http://www.links.org/?p=298). Ben goes on to clarify that maybe CardSpace can have a role in helping the user manage passwords; [Kim says "Hmm... Food for thought"](http://www.identityblog.com/?p=928) (okay, I'm paraphrasing); Ben [admits he didn't explain himself too clearly to begin with](http://www.links.org/?p=299); and, glory be, they're [violently agreeing](http://www.identityblog.com/?p=929). Phew! I thought we were going to be seeing [handbags at dawn](http://en.wiktionary.org/wiki/handbags_at_dawn)... ![](http://blogs.sun.com/images/smileys/smile.gif)

Reading all this lit a spark in my mind of how this could work. The crux is to consider the username/password token, usually sent as one of a set of possible _input_ tokens to an identity provider security token service (IP/STS), as an _output_ token.

Here's how it would work... Borrowing a diagram from Microsoft's [Guide to Interoperating with the Information Card Profile V1.0](http://msdn2.microsoft.com/en-us/library/bb298803.aspx):

![](http://msdn2.microsoft.com/en-us/library/Bb298803.infocardprofilegd02(en-us,MSDN.10).gif)

First of all, the IP/STS would specify **ic:RequireAppliesTo** in the managed card. This tells the identity selector to include a **wsp:AppliesTo** element in the **wst:RequestSecurityToken** (RST). The IP/STS is going to need this later...

Now, the user visits the relying party (RP) in step 1, requesting some resource. In step 2, the 'service requestor' (application client with identity selector) requests security policy from the RP. The RP would indicate, in step 3, that it wanted a username/password token by specifying a token type of **http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0** in the policy.

Now the identity selector presents some set of information cards (hopefully just one) to the user (step 5) and the user selects one (step 6). Steps 7 and 8 would see the RP requesting security policy from the IP/STS, and the IP/STS supplying it, exactly as in the standard information card interaction. Here the IP/STS could require any form of input token, but username/password is most likely.

Between steps 8 and 9, the identity selector prompts the user for credentials (bad Microsoft, missing that out of the diagram!) and in step 8, the identity selector packages up the user's credentials in a WS-Trust RST and send them to the IP/STS.

Now, here's the interesting bit. The IP/STS authenticates the user, exactly as in the standard CardSpace case, but now it looks at the **wsp:AppliesTo** element, and looks up the user's username/password pair for that RP (this is an implementation detail - there could be a mapping of RP identifiers to username/password pairs per user, all encrypted on disk, of course). The IP/STS packages them as a **wsse:UsernameToken**, which is then encrypted with the RP's public key and returned to the identity selector (step 10). The display token could just show ******** for the value of the password claim. Now we have a nice, securely packaged credential that the identity selector can send to the RP in step 11\.

Here's the other nice bit... All the RP has to do is to decrypt the incoming token and it has the user's username and password, exactly as if they had arrived by a conventional form post. No further customization required at the RP - no changes to directory or database schemas, no extra steps of associating an information card with your account. Passwords on steroids.