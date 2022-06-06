---
author: user
title: Identity-Based Encryption revisited
slug: identity-based-encryption-revisited
id: 640
date: '2006-07-13 21:41:12'
layout: single
categories:
  - Identity
---

After my [earlier post on Identity-Based Encryption](http://blog.superpat.com/2006/07/10/identity-based-encryption/), I [promised James McGovern](http://blog.superpat.com/2006/07/10/identity-based-encryption/#comment-336) that I'd ping our security folks for their take on IBE. I did so and [Radia Perlman](http://research.sun.com/people/mybio.php?uid=28941) was kind enough to reply and gave me permission to quote her in full:

> Identity based encryption.  
> Sigh.
> 
> This is something that some people in the research community have gotten all excited about, and I really think there's nothing there. It might be cute math, and even a cute concept. The hype is that it makes "all the problems of PKI go away".
> 
> The basic idea is that you can use your name as your public key. The private key is derived from the public key based on a domain secret, known to a special node called the PKG (private key generator), which is like a KDC, or an NT domain controller.
> 
> Some of the problems I see with it:
> 
> a) public key stuff is so nice because nobody needs to know your secret, and the trusted party (the CA) need not be online. The PKG obviously needs to be online, and knows everyone's secrets
> 
> b) If Alice is in a different trust domain than Bob, she has to somehow securely find out Bob's PKG's public parameters (which enable her to turn Bob's name into a public key IN THAT DOMAIN).
> 
> c) Bob has to somehow authenticate to the PKG to get his own private key
> 
> d) There is no good answer to revocation, in case someone steals Bob's private key
> 
> e) There is no good answer to revocation, in case someone steals the PKG's domain secret.
> 
> I've seen hype slides about identity based encryption saying "which identity is easier to remember?
> 
> In PKI: 237490798271278094178034612638947182748901728394078971890468193707  
> In IBE: radia.perlman@sun.com
> 
> This is such ill-conceived hype. In PKI no human needs to see an RSA key. The RSA key is not your identity. Your identity is still something like radia.perlman@sun.com

So, it looks like IBE gives with one hand (sender can create a public key without the recipient's involvement) but takes much more away with the other (key secrecy, PKG has to be online, revocation issues). I guess there is no such thing as a free lunch...