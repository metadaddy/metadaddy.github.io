---
author: user
title: Secure Federated Identity Deployments
slug: secure-federated-identity-deployments
id: 299
date: '2009-01-31 21:21:49'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">![](images/padlock.jpg)</span>

Nothing if not provocative, [James McGovern](http://duckdown.blogspot.com/) continues our discussion on security and federation with [Insecure Federated Identity Deployments](http://duckdown.blogspot.com/2009/01/insecure-federated-identity-deployments.html). As always, James raises a number of good questions; I'll see how may I can get through here...

> Does anyone know in typical deployments who has the responsibility of generating these identifiers (IDP or RP)? Do IdM products such as Sun's IdM, Oracle OIM, Courion, OpenIAM, Keychain, etc have a secure way built in to generate identifiers and pass them to third parties? Should they be exchanged via SPML, some other open standard or is this intentionally left undefined?

In a typical deployment, the IdP will generate the identifier. [OpenSSO](http://opensso.org/) uses the [nextBytes](http://java.sun.com/j2se/1.4.2/docs/api/java/security/SecureRandom.html#nextBytes%28byte[]%29) method of Java's [SecureRandom](http://java.sun.com/j2se/1.4.2/docs/api/java/security/SecureRandom.html) class to generate 21 random bytes, which it then base 64 encodes into a String. SecureRandom provides a cryptographically strong pseudo-random number generator (PRNG), minimally complying with [FIPS 140-2, Security Requirements for Cryptographic Modules [PDF]](csrc.nist.gov/publications/fips/fips140-2/fips1402.pdf), section 4.9.2 and [RFC 1750: Randomness Recommendations for Security](http://www.ietf.org/rfc/rfc1750.txt). That should be secure enough...

The persistent name ID can be transmitted to the SP in one of two ways, which I'll term interactive or batch. Interactive mode tends to be used when the user already has an account, with login credentials, at the SP, and there may not be an easy correlation possible between the user's accounts at IdP and SP. In the interactive mode, the first time the user attempts single sign-on between a given IdP-SP pair, the IdP authenticates the user, then generates a persistent name ID and sends it to the SP in a SAML assertion. The SP will attempt to locate the corresponding user in its store, and, failing to do so, will authenticate the user itself, in the same way as it did pre-SSO. On authenticating the user, the SP can write the persistent name ID into the user's profile and use it in future.

In contrast, batch mode can be used when either an automatic correlation is possible between IdP and SP accounts - the IdP and SP share some index attribute(s) that uniquely identifies the user - or when the SP has no pre-existing accounts. In the batch mode, the IdP generates a persistent name ID for each user, and writes that name ID and some collection of attributes to a file. The file is transmitted to the SP out of band, and the SP loads the persistent name ID's into its user store, either looking up existing accounts via the index attribute(s) or creating new accounts.

OpenSSO does this duty in the Sun world, although you could easily customize Sun IdM to do this - OpenSSO's createNameIdentifier() method is 21 lines of open source code, with no dependencies except java.security.SecureRandom and a Base64 encoder.

You could certainly use SPML to transmit the name ID from the IdP to the SP, since the name ID is just a fragment of XML that can travel in a SPML <data> element:

    <spml:data>
    <saml:NameID
    NameQualifier="http://saml.exampleidp.com/opensso"
    SPNameQualifier="http://saml.examplesp.com/fedlet"
    Format="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent">
    YgolvKBPsL4ABSrdOpilovLnVq+X
    </saml:NameID>
    </spml:data>

James goes on:

> Let's say that I have an application already protected by CA Siteminder, Oracle CoreID, Yale CAS, etc and I want to use OpenSSO strictly for its federation capabilities. How should OpenSSO pass authentication context to these web access management products and what APIs would it use?

As a concrete example, let's look at the case where OpenSSO performs SP federation duties for CA SiteMinder, a [documented and supported configuration, by the way](http://docs.sun.com/app/docs/doc/820-3746/ghdzy?a=view#ghebr), in use at several customers who balked at the cost of adding CA's federation capability. As [I mentioned last time](http://blog.superpat.com/2009/01/12/did-you-know-that-federated-identity-deployments-are-more-secure-than-you-think/), setting an attribute in the SSO session, to indicate that the user had authenticated via federation, would work to pass authentication context from OpenSSO to SiteMinder or a similar product. Policy on the SiteMinder side would then act on the value of that attribute. Since I'm not an expert in SiteMinder integration, and CA don't publish the SDK documentation on the web, I couldn't tell you the API to use, but setting an attribute in an SSO session is pretty basic stuff. It will be there somewhere.

> When people are learning a new technology, they tend to keep it simple and develop suboptimal habits. I recently did an exercise to see if past books I have written had examples of [OWASP](http://www.owasp.org/index.php/Hartford) vulnerabilities and found several. To think that folks have learned to program high quality but otherwise potentially insecurely from my writings is troubling. So, what is the call to action to prevent this same thing from happening in the world of federation? Are vendors keeping it too simple? If you were to search the documentation for RSA, PingIdentity, Oracle, etc do you think they cover the aspects you outlined? Does Sun become a member of OWASP to have someone analyze the insecure aspects of federation help?

Liberty and OASIS are already the venues for this work - see the [SAML 2.0 Security and Privacy Considerations [PDF]](http://docs.oasis-open.org/security/saml/v2.0/saml-sec-consider-2.0-os.pdf) document and the [Static Conformance Requirements and Testing Procedures](http://www.projectliberty.org/liberty/liberty_interoperable/documents). Note, in particular, Test Case P, 'Error Testing', in the [Liberty Interoperability Testing Procedures for SAML 2.0 [PDF]](http://www.projectliberty.org/liberty/content/download/4160/27946/file/Liberty_Interoperability_SAML_Test_Plan_v3.1.pdf) - you'll see that error modes are explicitly tested. Note also that this is an evolving document, with the current version being the fourth iteration since the first was released in 2005\. I'm not sure what value OWASP would add.

> Wouldn't segregating local and federated users into different domains require deploying additional unnecessary infrastructure? If the RP gets its profile by reading a UID value in a cookie and then binding to a directory service, wouldn't this require changing the security model of the application which begs the question of how enterprise applications need to change to support federation. For the most part, this is undocumented and never discussed in the blogosphere Is this a use-case for leveraging XACML?

OK - that was thinking aloud on my part. You either have two user populations (outsiders and insiders), typically already identified as such in your user store (if you can't tell employees from customers, you're in a bad way!) or you have a single user population that can access the deployment via alternate methods, depending on where they happen to be. In the latter case, policy might dictate, for example, that the payroll app could not be accessed via federated SSO, enforced by the policy agent deployed into the app's container. No changes to the payroll app required. I'm not sure where XACML comes into the picture.

James goes on to ask a number of additional questions:

> 1\. If a federated identity product is deployed as a separate tier from an application and the IDP when sending an assertion needs to not only send values that may be stored in a directory (e.g. OpenDS, OpenLDAP, etc) but also include values that may be calculated by the application at runtime, how would this work? What APIs would be used and more importantly what APIs should exist but are missing?

In OpenSSO's case, you simply implement the [IDPAttributeMapper SPI](http://docs.sun.com/app/docs/doc/820-3748/ggiei?a=view#ggicr), calculate the attribute values, and OpenSSO will include them in the Assertion.

> 2\. SAML 2.0 identifiers is a great concept and Pat shows how OpenSSO can leverage them. I am curious though when they are stored in a directory service such as OpenDS, should they have a standard IETF OID for holding this attribute/objectClass?

Good question. I'm not sure they really need it, since this is an implementation detail for the federation product, rather than an interoperability point.

> 3\. I haven't looked in detail, but the SAML 2.0 identifier outlined feels the same as the PPID leveraged in Cardspace. If they are different, then did Microsoft violate some principle? If they are the same, then shouldn't there be a standard as to how this is represented as MS will generate it differently than Sun? What other "best practices" exist around generating this value?

The semantics aren't quite the same. The PPID is associated with a _card_ at the IdP, in the context of a specific relying party, while the persistent name ID is associated with the user _account_ at the IdP, in the context of a specific service provider. Having said that, for managed cards, I think they are equivalent. SAML 2.0 says this about the persistent name ID:

> _Persistent name identifiers generated by identity providers MUST be constructed using pseudo-random values that have no discernible correspondence with the subject's actual identifier (for example, username). The intent is to create a non-public, pair-wise pseudonym to prevent the discovery of the subject's identity or activities. Persistent name identifier values MUST NOT exceed a length of 256 characters._

The relevant spec in the CardSpace, um, space, is the [Identity Selector Interoperability Profile V1.5](http://www.microsoft.com/downloads/details.aspx?FamilyID=b94817fc-3991-4dd0-8e85-b73e626f6764&DisplayLang=en), which gives various mechanisms for constructing PPID's, each of which results in a Base64 encoded SHA256 hash, resulting in a 44 character string, which is well within SAML's 256 character limit. So it's certainly possible for a user's persistent name ID to be the same as the PPID for the same IdP/SP pair.

> 4\. Did Gerry Gebel of the Burton Group test out these scenarios at the Catalyst conference?

I don't think there was an interop demo at Catalyst 2008, but at the [Concordia interop demos at RSA](http://blog.superpat.com/2008/04/07/rsa-conference-2008-concordia-done-osis-to-go/), we tested a CardSpace/SAML interop scenario, passing an authentication context URI to indicate to the SAML SP that the user had authenticated via some CardSpace mechanism (self-issued card, managed card with password authentication to the IdP, etc). Given the scope of both PPID and persistent name ID, it wouldn't make sense to pass them across the CardSpace/SAML 2.0 boundary, since there are two discrete IdP/SP pairs at work here.

You could imagine a scenario where users could use either CardSpace or SAML 2.0 between a given IdP/SP pair, using the same PPID/persistent name ID value. I can't see any problem here, since, as I describe above, SAML 2.0 does not define any particular structure or semantics for the persistent name ID beyond a maximum length, which the PPID satisfies.

> 5\. Recently , I had the opportunity to hang out with some folks from [Voltage](http://superconductor.voltage.com/2009/01/another-crypto.html) who discussed the concept of identity based encryption (IBE). Should federations support IBE in addition to traditional PKI approaches?

The PKI in federations is point-to-point between providers, certificates being the trust anchor for signed metadata, which in turn contains message signing certificates. Typically, IdP's and SP's either exchange certificates out-of-band in a pairwise manner, or there is some trusted authority that signs metadata for a whole population of providers. You could conceive of a mechanism that would use [IBE](http://en.wikipedia.org/wiki/Identity_based_encryption) to generate keys from SAML 2.0 entity identifiers (which are simply URI's), with a Private Key Generator (PKG) from which the providers retrieve their private keys. The issue I see here is [well documented](http://en.wikipedia.org/wiki/Identity_based_encryption#Problems_with_IB-cryptography) - the PKG has access to ALL of the private keys in the PKI. This might be OK for inter-department federations within a larger organization, but I can't see it flying for inter-enterprise federation. I can't see any particular advantage in the former case, either. If you trust some central authority to issue private keys for a population of providers, you might as well trust it to distribute a signed metadata file.

> 6\. Does Sun have any plans on making the J2EE Petstore OpenID and federation-enabled?

No. I think the stumbling block here would be that there is no Java EE API for federation, so any such enabling would be OpenSSO-specific, which kind of goes against the point of the Petstore in demonstrating Java EE. Of course, we could show how to use OpenSSO with the Petstore, but this wouldn't quite be the same.

Phew! That was a long, detailed post! Hopefully there's some useful stuff there. Some of it might even be accurate ;-)