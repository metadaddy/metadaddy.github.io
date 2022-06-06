---
author: user
title: Liberty and WS-Federation
slug: liberty-and-ws-federation
id: 649
date: '2006-06-20 15:34:24'
layout: single
categories:
  - Federation
---

[James McGovern](http://duckdown.blogspot.com/) directed this question to me in a [recent blog entry](http://duckdown.blogspot.com/2006/06/outstanding-questions-for-folks-on-my.html):

> Pat Patterson, what would it take for you to get Liberty Alliance to embrace the WS-Federation specification? Having federation capabilities built directly into an operating system is liberating...

I'm not sure what James means, exactly, by 'embrace', but here is an answer to a more precise question - could you mix-and-match [WS-Federation](http://schemas.xmlsoap.org/ws/2003/07/secext/) with the [Liberty Alliance Project](http://projectliberty.org/)'s [Identity Web Services Framework](http://projectliberty.org/resources/specifications.php#ID-WSF_Specs) (ID-WSF)?

Well, Liberty got out of the SSO business some time ago, contributing ID-FF to [OASIS](http://www.oasis-open.org/) for inclusion in [SAML 2.0](http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=security#samlv20). Liberty's technical focus is now on Web services, strong authentication and such.

ID-WSF is independent of the actual SSO mechanism - the dependency is on the token, or, more precisely, the token carrying specific information. ID-WSF 1.1 can use SAML 1.1 tokens, ID-WSF 2.0 will be able to use both SAML 2.0 and SAML 1.1 tokens.

WS-Federation's USP is that it abstracts the token away from the SSO mechanism - a WS-Federation SSO can carry any token you like - SAML 1.1, SAML 2.0, Kerberos, whatever.

So, you can bootstrap from WS-Federation to ID-WSF if you obtain a suitable SAML token via WS-Fed SSO. Section 4 of the [draft ID-WSF 2.0 Discovery Service specification](http://projectliberty.org/specs/draft-liberty-idwsf-disco-svc-v2.0-24.pdf) defines SAML 2.0 and SAML 1.x Attributes that carry the Discovery Service endpoint reference (EPR). For example, here is a SAML 2.0 `<AttributeStatement>` containing a Discovery Service EPR:

```
<AttributeStatement
xmlns="urn:oasis:names:tc:SAML:2.0:assertion">
<Attribute Name="urn:liberty:disco:2005-11:DiscoveryEPR" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri">
<AttributeValue>
<wsa:EndpointReference>
<wsa:Address>https://example.com/disco/</wsa:Address>
<wsa:Metadata>
<Abstract>
The Principal’s Discovery Service Resource
</Abstract>
<ServiceType>urn:liberty:disco:2005-11</ServiceType>
<ProviderID>http://example.com/</ProviderID>
<SecurityContext>
<SecurityMechID>urn:liberty:security:2005-02:TLS:bearer</SecurityMechID>
<sec:Token ref="..." usage="urn:liberty:security:tokenusage:2005-11:SecurityToken" />
</SecurityContext>
</wsa:Metadata>
</wsa:EndpointReference>
</AttributeValue>
</Attribute>
</AttributeStatement>

```

There are some minor syntactic differences in the SAML 1.x version:

```
<AttributeStatement
xmlns="urn:oasis:names:tc:SAML:1.0:assertion">
<Subject>
<NameIdentifier Format="urn:liberty:iff:nameid:federated">
d0CQF8elJTDLmzE0
</NameIdentifier>
</Subject>
<Attribute AttributeName="DiscoveryEPR" AttributeNamespace="urn:liberty:disco:2005-11">
<AttributeValue>
<wsa:EndpointReference>
<wsa:Address>https://example.com/disco/</wsa:Address>
<wsa:Metadata>
<Abstract>
The Principal’s Discovery Service Resource
</Abstract>
<ServiceType>urn:liberty:disco:2005-11</ServiceType>
<ProviderID>http://example.com/</ProviderID>
<SecurityContext>
<SecurityMechID>urn:liberty:security:2005-02:TLS:bearer</SecurityMechID>
<sec:Token ref="..." usage="urn:liberty:security:tokenusage:2005-11:SecurityToken" />
</SecurityContext>
</wsa:Metadata>
</wsa:EndpointReference>
</AttributeValue>
</Attribute>
</AttributeStatement>

```

Such an attribute gives you everything you need to invoke the Discovery Service on behalf of a principal - its location (`https://example.com/disco/` in the examples above) and a token representing the principal - and it can be carried via WS-Federation just as easily as SAML.

It's up to vendors to make this work. If ADFS can be customized/extended to provide the above SAML attribute in a WS-Federation SSO then other vendors' products can consume it. No further specification or standardization is required, since, again, WS-Federation allows any token as its payload and ID-WSF doesn't care about the SSO mechanism as long as the token carries the Discovery Service EPR.

Which brings us round to the original question - "what would it take for you to get Liberty Alliance to embrace the WS-Federation specification". I believe this is moot, since, as I have shown, SSO is orthogonal to Liberty's current activities. SAML 2.0, WS-Federation, come one, come all.

Finally, yes, I agree - "having federation capabilities built directly into an operating system is liberating" - it would have been even more liberating had Microsoft adopted the federation standard agreed long ago by the rest of the industry and built SAML 2.0 into the operating system. However, we live in the real world and work to satisfy our customers' requirements. You will see WS-Federation support in future versions of our products - in fact, we've already done a [PoC showing WS-Federation](customer-sabotage-just-what-you-need-in-a-proof-of-concept).