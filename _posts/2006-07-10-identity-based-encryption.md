---
author: user
title: Identity-Based Encryption
slug: identity-based-encryption
id: 643
date: '2006-07-10 11:47:30'
layout: single
categories:
  - Identity
---

Catching up with the rest of the world after Sun's summer holiday, I see a [posting](http://duckdown.blogspot.com/2006/07/outstanding-question-for.html) from [James McGovern](http://duckdown.blogspot.com/) mentioning '[Identity-Based Encryption](http://crypto.stanford.edu/ibe/)'. I can totally see the utility of IBE in the context of, say, corporate email: there is a mechanism for Alice to easily tranforming an arbitrary string (say, Bob's email address) to a public key and use the latter to encrypt a message for Bob. At this point, Bob needn't have a private key at all. On receiving the message, Bob can go to the Private Key Generator (PKG), the equivalent of a certificate authority, I guess, prove that he 'owns' the email address in question and obtain a private key. (I haven't read up on this in the necessary detail to discover whether there is an implicit key escrow here - presumably the key issuer could generate Bob's private key for itself, if it really wanted to?).

Thinking aloud on the application to identity in the sense of SSO, federation and such... As far as I can see, the 'Identity' in IBE's name could just as well be 'arbitrary string', but in an email context, the use of an email address (one possible identifier) has obvious benefits. For authentication, though, I'm not so sure. I can't see strong non-repudiation here, since the PKG can always mint a private key for any given public key.

Still, there might be applications for encrypting attributes in a loosely-coupled authentication domain. At the request of the principal, an identity provider could encrypt attributes to be sent to a given relying party without a prior relationship with that relying party, using, say, a URL as public key. If that URL located an appropriate web service, the relying party could automatically request a private key from the PKG, which would send the private key to that web service, using message and/or transport encryption for privacy. Interesting...