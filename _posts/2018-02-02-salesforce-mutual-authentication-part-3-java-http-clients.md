---
author: user
title: 'Salesforce Mutual Authentication – Part 3: Java HTTP Clients'
slug: salesforce-mutual-authentication-part-3-java-http-clients
id: 1665
date: '2018-02-02 10:15:15'
layout: single
categories:
  - Uncategorized
comments: true
---

![HTTP Client Logos](images/http-client-logos-150x92.png){: .align-left}In [part 1](salesforce-mutual-authentication-part-1-the-basics) of this short series of blog entries on Salesforce's [Mutual Authentication](https://help.salesforce.com/articleView?id=000240864&type=1) feature, I explained how to enable, configure and test Mutual Authentication. In [part 2](salesforce-mutual-authentication-part-2-web-service-connector-wsc), I documented the shortcomings of Salesforce's [Web Service Connector](https://github.com/forcedotcom/wsc) when trying to use Mutual Authentication, and showed how to work around them. This time, I'm going to show you how to use common Java HTTP Clients to call Salesforce APIs with Mutual Authentication. Recall from part 1 that enabling Mutual Authentiation on a Salesforce Profile means that users with that profile must call a separate API endpoint, connecting via TLS with a client key and certificate chain. A Java client application can load the client key and certificate as I explained in part 2:

```java
// Make a KeyStore from the PKCS-12 file
KeyStore ks = KeyStore.getInstance("PKCS12");
try (FileInputStream fis = new FileInputStream(KEYSTORE_PATH)) {
  ks.load(fis, KEYSTORE_PASSWORD.toCharArray());
}

// Make a KeyManagerFactory from the KeyStore
KeyManagerFactory kmf = KeyManagerFactory.getInstance("SunX509");
kmf.init(ks, KEYSTORE_PASSWORD.toCharArray());

// Now make an SSL Context with our Key Manager and the default Trust Manager
SSLContext sslContext = SSLContext.getInstance("TLS");
sslContext.init(kmf.getKeyManagers(), null, null);
```

We'll also need to obtain a session ID. I'll just reuse the SOAP login code from last time, though you could also use [any of the OAuth mechanisms](https://help.salesforce.com/articleView?id=remoteaccess_authenticate_overview.htm).

```java
// Login as normal to get instance URL and session token
ConnectorConfig config = new ConnectorConfig();
config.setAuthEndpoint("https://login.salesforce.com/services/Soap/u/39.0");
config.setUsername(USERNAME);
config.setPassword(PASSWORD);

// Uncomment for more detail on what's going on!
//config.setTraceMessage(true);

// This will set the session info in config
Connector.newConnection(config);

// Display some current settings
System.out.println("Auth EndPoint: "+config.getAuthEndpoint());
System.out.println("Service EndPoint: "+config.getServiceEndpoint());

String sessionId = config.getSessionId();
String instance = new URL(config.getServiceEndpoint()).getHost();
```

Let's look at how we proceed then, in a few common scenarios. All of the below code is available in [this Github project](https://github.com/metadaddy/mutual-auth).

# Java's HttpURLConnection

This is pretty much the most basic way of accessing an HTTP endpoint in Java. We create a URL object and get the `HttpURLConnection` as usual, then we can set the `SSLSocketFactory` on the connection:

```java
// URL to get a list of REST services
// For example: https://na30.salesforce.com:8443/services/data/v41.0
URL url = new URL("https://" + instance + ":" + MUTUAL_AUTHENTICATION_PORT
    + "/services/data/v" + API_VERSION);

HttpURLConnection conn = (HttpURLConnection)url.openConnection();

// Check that we did get an HttpsURLConnection before casting to it
if (conn instanceof HttpsURLConnection) {
  ((HttpsURLConnection)conn).setSSLSocketFactory(sslContext.getSocketFactory());
}
```

Now we set the authorization header as we normally would. I'm also using the `X-PrettyPrint` header to make the REST API response a bit easier to read.

```java
// Set the Authorization header
conn.setRequestProperty("Authorization", "OAuth "+sessionId);
// Make the response pretty
conn.setRequestProperty("X-PrettyPrint", "1");
```

Finally, we'll pull the data from the HttpURLConnection's OutputStream and dump it to System.out:

```java
// Dump the response to System.out
try (BufferedReader br =
    new BufferedReader(
      new InputStreamReader(conn.getInputStream()))) {
  String input;

  while ((input = br.readLine()) != null){
    System.out.println(input);
  }
}
```

The result is the expected list of Salesforce REST services:

```json
{
  "tooling" : "/services/data/v41.0/tooling",
  "metadata" : "/services/data/v41.0/metadata",
  ...lots more...
  "sobjects" : "/services/data/v41.0/sobjects",
  "actions" : "/services/data/v41.0/actions",
  "support" : "/services/data/v41.0/support"
}
```

# Apache HttpClient

How does the same example look with [Apache HttpClient](https://hc.apache.org/httpcomponents-client-ga/)? We just need to set the `SSLContext` in the Apache `CloseableHttpClient`:

```java
// URL to get a list of REST services
String url = "https://" + instance + ":" + MUTUAL_AUTHENTICATION_PORT
    + "/services/data/v" + API_VERSION;

// Set the SSLContext in the HttpClient
try (CloseableHttpClient httpclient = HttpClients.custom()
    .setSSLContext(sslContext)
    .build()) {
  HttpGet httpGet = new HttpGet(url);
  // Set the Authorization header
  httpGet.addHeader("Authorization", "OAuth "+sessionId);
  // Make the response pretty
  httpGet.addHeader("X-PrettyPrint", "1");

  // Execute the request
  try (CloseableHttpResponse response = httpclient.execute(httpGet);
       BufferedReader br =
         new BufferedReader(
           new InputStreamReader(response.getEntity().getContent()))
  ){
    // Dump the response to System.out
    String input;
    while ((input = br.readLine()) != null){
      System.out.println(input);
    }
  }
}
```

The output is identical to the previous example.

# Eclipse Jetty

[Jetty](https://www.eclipse.org/jetty/) is a little more complex. We need to create a Jetty `SslContextFactory`, rather than a standard Java `KeyManagerFactory` and `SSLContext`. Note that we need to set the KeyStore password in the `SslContextFactory`:

```java
SslContextFactory sslContextFactory = new SslContextFactory();
sslContextFactory.setKeyStore(ks);
// Need to set password in the SSLContextFactory even though it's set in the KeyStore
sslContextFactory.setKeyStorePassword(KEYSTORE_PASSWORD);
```

Now we can create a Jetty `HttpClient` with the `SslContextFactory`, and start it:

```java
HttpClient httpClient = new HttpClient(sslContextFactory);
httpClient.start();
```

Executing the request proceeds as usual, and results in identical output:

```java
String response = httpClient.newRequest(url)
    .header("Authorization", "OAuth " + sessionId)
    .header("X-PrettyPrint", "1")
    .send()
    .getContentAsString();

System.out.println(response);
```

Don't forget to stop the `HttpClient` when you're done with it:

```java
httpClient.stop();
```

# Conclusion

Salesforce Mutual Authentication offers an additional layer of security over default server-authenticated TLS - clients must possess the key corresponding to a certificate configured in the Salesforce org. As I showed in [part 1 of this series of blog entries](salesforce-mutual-authentication-part-1-the-basics), configuring Mutual Authentication in Salesforce is straightforward, as is testing the connection with curl, although the Salesforce documentation is not totally accurate. Salesforce's [Web Service Connector](https://github.com/forcedotcom/wsc) requires some modifications to make it compatible with Mutual Authentication, although, as I explained in [part 2](salesforce-mutual-authentication-part-2-web-service-connector-wsc), it is possible to engineer around the issues. The popular Java HTTP clients all provide mechanisms for setting the client key and certificate, and using them to call the Salesforce REST APIs is straightforward. Source code showing how to use Mutual Authentication via all of the above mechanisms is available in [my mutual-auth GitHub repo](https://github.com/metadaddy/mutual-auth). I hope you've enjoyed this exploration of Mutual Authentication, and that you've saved yourself a bit of time by reading it!