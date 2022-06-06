---
author: user
title: Access Manager 7.1 Beta in Java EE Tools/NetBeans 5.5 Enterprise Pack
slug: access-manager-7-1-beta-in-java-ee-toolsnetbeans-5-5-enterprise-pack
id: 661
date: '2006-05-23 23:35:53'
layout: single
categories:
  - Access Manager
---

<span style="margin:40px;float:right;">![](images/ThumbsUp.jpg)</span>

If you've been following [Eric Leach's blog](http://blogs.sun.com/roller/page/cericleach), you'll know that, just before JavaOne, [we released a beta version of Sun Java System Access Manager 7.1](http://blogs.sun.com/roller/page/cericleach?entry=java_one_blog_number_10) via a couple of bundles:

*   [Java EE 5 Tools Bundle Beta](http://java.sun.com/javaee/downloads/index.jsp)
*   [NetBeans Enterprise Pack 5.5 Early Access](http://www.netbeans.org/products/enterprise/index.html)

The former download is 132 MB, the latter 89 MB. The main difference between them seems to be that the Java EE 5 Tools Bundle includes NetBeans; NB EP 5.5 assumes you already have it.

Access Manager's role in this bundle is to secure web services. If you're thinking "Uh oh - this is that [Liberty](http://www.projectliberty.org/) stuff they keep pushing at me; I've barely got my head around basic [SAML](http://www.oasis-open.org/committees/security/) assertions, let alone [ID-WSF](http://www.projectliberty.org/resources/specifications.php#ID-WSF_Specs).", well - relax. [We did show](http://blogs.sun.com/roller/page/superpat?entry=pdfs_for_javaone_2005_technical) [Access Manager](http://www.sun.com/software/products/access_mgr/index.xml) working with [Java Studio Enterprise](http://developers.sun.com/prodtech/javatools/jsenterprise/index.jsp) and [JSR 196 (Java Authentication Service Provider Interface for Containers)](http://www.jcp.org/en/jsr/detail?id=196) to secure web services via Liberty ID-WSF at last year's JavaOne ([there's also a technical article on the topic](http://blogs.sun.com/roller/page/superpat?entry=building_identity_enabled_web_services)); since then we have implemented [WS-I BSP](http://www.ws-i.org/deliverables/workinggroup.aspx?wg=basicsecurity) to secure 'plain vanilla' web services.

Here are my notes from installing the [Java EE 5 Tools Bundle Beta](http://java.sun.com/javaee/downloads/index.jsp) and working through the [Securing Web Services tutorial](http://www.netbeans.org/kb/55/amsecurity.html). I'm running [Ubuntu](http://www.ubuntu.com) 6.06 'Dapper Drake' Beta. Not an officially supported platform, but I like to surf the bleeding edge ![](http://blogs.sun.com/roller/images/smileys/smile.gif)

*   Let's get started. I downloaded the [Java EE 5 Tools Bundle Beta](http://java.sun.com/javaee/downloads/index.jsp), `chmod +x netbeans-5_5-ide-entpack-sdk-jbi-am-linux.sh; ./netbeans-5_5-ide-entpack-sdk-jbi-am-linux.sh` and I'm into the installer. I need to tell the installer where I've put Java - it doesn't seem to know. Fair enough - this is not a standard system - I have at least three versions of Java floating around.
*   The installer prompts me for ports, passwords and trundles away for a while. On completion it reports that there were some warnings. I check `/tmp/netbeans-5_5-installation-20060523143837.41310.log` and it looks like the installer was not able to get to Access Manager (AM) at `http://_myhostname_:8080/amserver/configurator.jsp`. Ah - that's probably because it likes your system to have a fully qualified domain name (FQDN), e.g. _myhostname.mydomain.com_ and I don't have a domain set. This is documented in the [release notes](http://java.sun.com/javaee/sdk/tools/sdkentpack_relnotes.jsp) - it doesn't seem to be a big deal, and I can get to that URL in Firefox, so we'll just carry on.
*   OK - surf to `http://_myhostname_:8080/amserver/configurator.jsp` and I get a nice configuration page:  
    [![](images/AMConfigurator.png)](images/AMConfigurator.png)  
    Those are the 5 parameters you need to set to configure AM. I left everything as default and (as expected from the release notes) got a server error. Putting a dummy domain on the end of the hostname did the trick and I'm at an Access Manager login screen.  
    [![](images/AMLogin.png)](images/AMLogin.png)  
    Cool! The simplest ever AM install/config ![](http://blogs.sun.com/roller/images/smileys/smile.gif)
*   Login with the default amadmin/admin123 (we'll have to change that - I _hate_ default passwords. We should add 'amadmin password' to the 5 configuration parameters) and I'm in the now familiar AM 7.x admin UI:  
    [![](images/AMAdmin.png)](images/AMAdmin.png)
*   Ok - install and config done. On to the [Securing Web Services tutorial](http://www.netbeans.org/kb/55/amsecurity.html). The tutorial notes are a little sketchy - I'll fill in the gaps here as I go along.
*   Grab the [stockapp.zip](http://www.netbeans.org/download/samples/amsecurity/stockapp.zip) sample source and put it somewhere sensible, as suggested in the tutorial. I get two directories, `stockclient` and `stockservice`. Cool.
*   Tutorial step 2 is missing an initial steplet - you need to go to the App Server admin console at `http://_myhostname_:4848/` and login as admin with whatever AS password you selected at install. Hmm - I don't see a 'Runtime' tab, but I can see a running App Server (in fact, I already checked that it was running by browsing `http://_myhostname_:8080/` and, of course, I wouldn't have been able to configure AM if it wasn't running. So, according to step 2c, I can safely skip forward to step 5 in the tutorial. Except that it seems like the next thing I have to do is in step 3\.
*   Tutorial step 3 - yes - done this already.
*   Step 4 - ah - you will definitely want to do this - set AM to full message debug logging. On my system, the config file was at `/home/pat/SUNWappserver/addons/amserver/AMConfig.properties`. **Beware** - there is another `AMConfig.properties` file for the AM server - on my machine it's at `/home/pat/AMConfig.properties`. If you set message debug logging at the AM server but not in the AS addons, you won't get any of the diagnostic output described below. I know - I did exactly this first time round and spent several hours trying to figure out what was wrong. Change `com.iplanet.services.debug.level` to `message` and restart the App Server. Just go to `_wherever_you_installed_it_/SUNWappserver/bin` and do `./asadmin stop-domain; ./asadmin start-domain`.
*   Step 5 - Run NetBeans and disable proxies as directed in the tutorial, since we'll be interacting with local services.
*   OK - now for some secure web service action... Start NetBeans and... Oh. NetBeans just shows me a blank window. That's not good. Google Google Google... Ah. I have [XGL and Compiz](http://www.novell.com/linux/xglrelease/) [eye candy](http://www.novell.com/linux/xglrelease/img/transparency1.jpg) installed. [This forum post](http://www.suseforums.net/lofiversion/index.php/t24712.html) gives the answer - run the Xnest nested X server, the icewm window manager and then run NetBeans in the nested X session. Fair enough. Ubuntu recommends [Xephyr](http://www.freedesktop.org/wiki/Software_2fXephyr) rather than Xnest, so I grab that, icewm and.. great - we have NetBeans! _[UPDATE: See [this comment](http://blogs.sun.com/roller/page/superpat?entry=access_manager_7_1_beta#comment1) for a handy little script I wrote to run NetBeans in a nested X session.]_ Back to the tutorial...
*   Open the two projects. Cool - Web Service Provider (WSP) Security Configuration property page. Enable security, select SAML-HolderOfKey, sign reponses. Don't forget to change the password if you overrode the default AS 'adminadmin' password. Ooh - we'll have to fix that password entry field. This _is_ beta, don't forget.
*   We can go look in the keystore, just to check that we are supplying the right password here, and that the s1as cert is there:

    ```
pat@patlinux:~/SUNWappserver/domains/domain1/config$ keytool -list
    -keystore ./keystore.jks -storepass password
    Keystore type: jks
    Keystore provider: SUN
    Your keystore contains 1 entry
    s1as, May 23, 2006, keyEntry,
    
```

*   Now to the client... Web Service Client (WSC) Security Configuration, enable security, SAML-HolderOfKey, verify response. Check that password again. And we're ready to run. Build and deploy stockservice as described in the tutorial. Build and run stockclient and we have a JSP ready for input. I had to copy the URL into the browser in my main X session, since Firefox wasn't happy running a second instance in the nested X session. I also had to change 'localhost' in the URL to my real hostname.
*   Now I just press enter to get a quote for SUNW and... I get a page of canned price data. It works!!! On my machine, `ClientModule` and `ServerModule` are in `/tmp/amserver/`, I can see real, honest to goodness WS-I BSP SOAP messages with SAML assertions in the headers. I've indented for clarity and elided most of the base 64 encoded signature and key info.
*   Here's the raw SOAP message as it leaves the client code (don't forget, the whole point of this is to abstract the security stuff out of the client/server code):

```
<env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/" xmlns:enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns0="http://sun.com/stockquote.xsd" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<env:Body>
<ns0:QuoteRequest>
<Symbol>SUNW</Symbol>
</ns0:QuoteRequest>
</env:Body>
</env:Envelope>

```

*   And here is the secured SOAP message as it goes onto the wire:

```
<env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/" xmlns:enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns0="http://sun.com/stockquote.xsd" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<env:Header>
<wsse:Security xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-01.xsd">
<saml:Assertion xmlns:saml="urn:oasis:names:tc:SAML:1.0:assertion" AssertionID="s69f7e258e30da2b9b9f5799d4eb0c548782432bf" IssueInstant="2006-05-24T05:52:32Z" Issuer="patlinux" MajorVersion="1" MinorVersion="1">
<saml:AuthenticationStatement AuthenticationInstant="2006-05-24T05:52:30Z" AuthenticationMethod="urn:com:sun:identity:Application">
<saml:Subject>
<saml:NameIdentifier>wsc</saml:NameIdentifier>
<saml:SubjectConfirmation>
<saml:ConfirmationMethod>urn:oasis:names:tc:SAML:1.0:cm:holder-of-key</saml:ConfirmationMethod>
<KeyInfo xmlns="http://www.w3.org/2000/09/xmldsig#">
<KeyName>CN=patlinux, OU=Sun Java System Application Server, O=Sun Microsystems, L=Santa Clara, ST=California, C=US</KeyName>
<KeyValue>
<RSAKeyValue>
<Modulus>AIE1oq...</Modulus>
<Exponent>AQAB</Exponent>
</RSAKeyValue>
</KeyValue>
</KeyInfo>
</saml:SubjectConfirmation>
</saml:Subject>
</saml:AuthenticationStatement>
<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
<SignedInfo>
<CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/>
<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/>
<Reference URI="#s69f7e258e30da2b9b9f5799d4eb0c548782432bf">
<Transforms>
<Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/>
<Transform Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/>
</Transforms>
<DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/>
<DigestValue>zdCY/1iqOMUJq/RvxsaDPWM4+7c=</DigestValue>
</Reference>
</SignedInfo>
<SignatureValue>ApcX/D...</SignatureValue>
<KeyInfo>
<X509Data>
<X509Certificate>MIICmj...</X509Certificate>
</X509Data>
</KeyInfo>
</Signature>
</saml:Assertion>
<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
<SignedInfo>
<CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/>
<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/>
<Reference URI="#se0ffabd98ecfdf194adc0c8ac8fb4edabf65cd3a">
<Transforms>
<Transform Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/>
</Transforms>
<DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/>
<DigestValue>Sccy9a3A7Ps27f3pf9adkRWuGvU=</DigestValue>
</Reference>
</SignedInfo>
<SignatureValue>aE9vKM...</SignatureValue>
<KeyInfo>
<SecurityTokenReference xmlns="http://schemas.xmlsoap.org/ws/2003/06/secext" wsu:Id="STR1">
<KeyIdentifier ValueType="http://docs.oasis-open.org/wss/oasis-wss-saml-token-profile-1.0#SAMLAssertionID" wsu:Id="sbee70b80d8b330875655b8956d13ff5a4199ca1d">s69f7e258e30da2b9b9f5799d4eb0c548782432bf</KeyIdentifier>
</SecurityTokenReference>
</KeyInfo>
</Signature>
</wsse:Security>
</env:Header>
<env:Body wsu:Id="se0ffabd98ecfdf194adc0c8ac8fb4edabf65cd3a">
<ns0:QuoteRequest>
<Symbol>SUNW</Symbol>
</ns0:QuoteRequest>
</env:Body>
</env:Envelope>

```

So - in the next thrilling installment, we'll walk through that secure SOAP message and see what each bit actually does.

_UPDATE_ - [here is that next installment](http://blogs.sun.com/roller/page/superpat?entry=anatomy_of_a_saml_secured).