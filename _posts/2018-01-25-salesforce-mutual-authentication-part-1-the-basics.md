---
author: user
title: 'Salesforce Mutual Authentication - Part 1: the Basics'
slug: salesforce-mutual-authentication-part-1-the-basics
id: 1637
date: '2018-01-25 21:42:17'
layout: single
categories:
  - Salesforce
tags:
  - salesforce
  - tls
---

![](images/Screen-Shot-2018-01-25-at-9.34.23-PM-150x150.png){: .align-left}[Mutual Authentication](https://help.salesforce.com/articleView?id=000240864&type=1) was introduced by Salesforce in the Winter '14 release. As the [Salesforce Winter '14 release notes](https://resources.docs.salesforce.com/186/latest/en-us/sfdc/pdf/salesforce_winter14_release_notes.pdf) explain, _mutually authenticated transport layer security (TLS) allows secure server-to-server connections initiated by a client using client certificate authentication, and means that both the client and the server authenticate and verify that they are who they say they are_. In this blog post, I'll show you how to enable Mutual Authentication and perform some basic tests using the [curl](https://curl.haxx.se/) command line tool. In a future blog post, I'll show you how to implement Mutual Authentication in your Java apps. In the default case, without Mutual Authentication, when an API client connects to Salesforce via TLS, the client authenticates the server via its TLS certificate, but the TLS connection itself gives the server no information on the client's identity. After the TLS session is established, the client sends a login request containing its credentials over the secure channel, the Salesforce login service responding with a session ID. The client then sends this session ID with each API request. Mutual Authentication provides an additional layer of security. Each time you connect to a Salesforce API, the server checks that the client's certificate is valid for the client's org, as well as checking the validity of the session ID. Note that Mutual Authentication is intended for API use and **not** for user interface (web browser) use. Before you can use Mutual Authentication, you need to obtain a client certificate. This certificate **must** be issued by a certificate authority with its root certificate in the Salesforce [Outbound Messaging SSL CA Certificates](https://developer.salesforce.com/page/Outbound_Messaging_SSL_CA_Certificates) list; Mutual Authentication will not work with a self-signed client certificate. More information is available in the Salesforce document, [Set Up a Mutual Authentication Certificate](https://help.salesforce.com/articleView?id=security_keys_uploading_mutual_auth_cert.htm&type=5). I bought an SSL certificate from GoDaddy - you can almost certainly find a cheaper alternative if you spend some time looking.

# Enabling Mutual Authentication in Salesforce

Mutual Authentication is not enabled by default. You must open a support case with Salesforce to enable it. When it is enabled, you will see a **Mutual Authentication Certificates** section at **Setup \| Administer \| Security Controls \| Certificate and Key Management**. [![Mutual Authentication Configuration](images/MutualAuthentication-1024x689.png)](images/MutualAuthentication.png) You must upload a PEM-encoded client certificate to this list. Note that you need only upload the client certificate itself; do not upload a certificate chain. You will also need to create a user profile with the **Enforce SSL/TLS Mutual Authentication** user permission enabled. Clone an existing Salesforce profile and enable **Enforce SSL/TLS Mutual Authentication**. Check that the profile has the Salesforce object permissions that your application will need to access data. Assign the new profile to the user which your app will use to access Salesforce.

# Testing Mutual Authentication with curl

This was a stumbling block for me for some time. First, despite what the Salesforce documentation ([Configure Your API Client to Use Mutual Authentication](https://help.salesforce.com/articleView?id=security_keys_uploading_mutual_auth_cert_api.htm&type=5)) says, the Salesforce login service does **not** support Mutual Authentication. You **cannot** connect to `login.salesforce.com` on port `8443` as described in the docs. You can, however, send a normal authentication request for a user with Enforce SSL/TLS Mutual Authentication enabled to the default TLS port, `443`. The login service responds with a session ID as for any other login request. Mutual Authentication is enforced when you use the session ID with an API endpoint. Let's try this out. Here's a SOAP login request - add a username/password and save it to `login.xml`:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<env:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:env="http://schemas.xmlsoap.org/soap/envelope/">
  <env:Body>
    <n1:login xmlns:n1="urn:partner.soap.sforce.com">
      <n1:username>user@example.com</n1:username>
      <n1:password>p455w0rd</n1:password>
    </n1:login>
  </env:Body>
</env:Envelope>
```

Now you can send it to the login service with curl:

```shell
$ curl -s -k https://login.salesforce.com/services/Soap/u/41.0 \
    -H "Content-Type: text/xml; charset=UTF-8" \
    -H "SOAPAction: login" \
    -d @login.xml | xmllint --format -
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <soapenv:Body>
    <loginResponse>
      <result>
        <metadataServerUrl>https://na30.salesforce.com/services/Soap/m/41.0/00D36000000bLGT</metadataServerUrl>
        <passwordExpired>false</passwordExpired>
        <sandbox>false</sandbox>
        <serverUrl>https://na30.salesforce.com/services/Soap/u/41.0/00D36000000bLGT</serverUrl>
        <sessionId>00D36000000bLGT!AQQAQMlp30Zpiy6_gSeP1cmQG.0dHlfMcUDg96d8BSRpSb9BwksAABdKsde14ahtDGzKzRXAMroiomST8.UWcg.hp5XXDi4O</sessionId>
        <userId>00536000006Z51jAAC</userId>
        <userInfo>
          ...lots of user data...
        </userInfo>
      </result>
    </loginResponse>
  </soapenv:Body>
</soapenv:Envelope>
```

We need to create a PEM file for curl with the signing key, client certificate, and all the certificates in its chain _except the root_. This file looks something like this:

```
-----BEGIN RSA PRIVATE KEY-----
...base 64 encoded private key data...
-----END RSA PRIVATE KEY-----
-----BEGIN CERTIFICATE-----
...base64 encoded client certificate data...
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
...base64 encoded CA issuing cert...
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
...another base64 encoded CA issuing cert...
-----END CERTIFICATE-----
```

We'll call the `getUserInfo` API. Here's the SOAP request - add the session ID returned from login and save it as `getuserinfo.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?> 
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:urn="urn:partner.soap.sforce.com">
  <soapenv:Header>
    <urn:SessionHeader>
      <urn:sessionId>INSERT_YOUR_SESSION_ID_HERE</urn:sessionId>
    </urn:SessionHeader>
  </soapenv:Header>
  <soapenv:Body>
    <urn:getUserInfo />
  </soapenv:Body>
</soapenv:Envelope>
```

Now we're ready to make a mutually authenticated call to a Salesforce API! You'll need to specify the correct instance, as returned in the login response, in the URL. Note the port number is `8443`:

```shell
$ curl -s -k https://na30.salesforce.com:8443/services/Soap/u/41.0 \
    -H "Content-Type: text/xml; charset=UTF-8" \
    -H "SOAPAction: example" \
    -d @getuserinfo.xml \
    -E fullcert.pem | xmllint --format -
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <soapenv:Header>
    <LimitInfoHeader>
      <limitInfo>
        <current>6</current>
        <limit>15000</limit>
        <type>API REQUESTS</type>
      </limitInfo>
    </LimitInfoHeader>
  </soapenv:Header>
  <soapenv:Body>
    <getUserInfoResponse>
      <result>
        ...all the user data...
      </result>
    </getUserInfoResponse>
  </soapenv:Body>
</soapenv:Envelope>

```

Now let's look at a couple of failure modes. What happens when we call the `8443` port, but don't pass a client certificate?

```shell
$ curl -s -k https://na30.salesforce.com:8443/services/Soap/u/41.0 \
    -H "Content-Type: text/xml; charset=UTF-8" \
    -H "SOAPAction: example" \
    -d @getuserinfo.xml
<html><head><title>Certificate Error</title></head><body bgcolor=#ffffff text=#3198d8><center><img src="http://www.sfdcstatic.com/common/assets/img/logo-company.png"><p><h3>Client certificate error:<i>No client certificate provided.</i></h3></center></body></html>
```

Note the HTML response, rather than XML! What about calling the regular `443` port with this session ID?

```shell
$ curl -s -k https://na30.salesforce.com/services/Soap/u/41.0 \
    -H "Content-Type: text/xml; charset=UTF-8" \
    -H "SOAPAction: example" \
    -d @getuserinfo.xml
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:sf="urn:fault.partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <soapenv:Body>
    <soapenv:Fault>
      <faultcode>sf:MUTUAL_AUTHENTICATION_FAILED</faultcode>
      <faultstring>MUTUAL_AUTHENTICATION_FAILED: This session could not be mutually authenticated for use with the API</faultstring>
      <detail>
        <sf:UnexpectedErrorFault xsi:type="sf:UnexpectedErrorFault">
          <sf:exceptionCode>MUTUAL_AUTHENTICATION_FAILED</sf:exceptionCode>
          <sf:exceptionMessage>This session could not be mutually authenticated for use with the API</sf:exceptionMessage>
        </sf:UnexpectedErrorFault>
      </detail>
    </soapenv:Fault>
  </soapenv:Body>
</soapenv:Envelope>

```

This time we get a much more palatable response! Now you know how to get the basics of Salesforce Mutual Authentication working. In [part 2 of this series](salesforce-mutual-authentication-part-2-web-service-connector-wsc), I look at using Salesforce's Web Service Connector (WSC) to access the SOAP and Bulk APIs with Mutual Authentication, and in [part 3](salesforce-mutual-authentication-part-3-java-http-clients), I explain how to access the Salesforce REST APIs with common Java HTTP clients such as the Apache and Jetty.