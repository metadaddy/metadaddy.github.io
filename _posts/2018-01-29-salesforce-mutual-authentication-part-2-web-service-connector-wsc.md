---
author: user
title: 'Salesforce Mutual Authentication - Part 2: Web Service Connector (WSC)'
slug: salesforce-mutual-authentication-part-2-web-service-connector-wsc
id: 1648
date: '2018-01-29 19:19:46'
layout: single
categories:
  - Salesforce
  - StreamSets
tags:
  - salesforce
  - soap
  - tls
---

![Code](images/Code3-150x94.png){: .align-left}In [my last blog entry](salesforce-mutual-authentication-part-1-the-basics) I explained how to enable, configure and test Salesforce's [Mutual Authentication](https://help.salesforce.com/articleView?id=000240864&type=1) feature. This time, I'll share my experience getting Mutual Authentication working with the Java client SDK for Salesforce's SOAP and Bulk APIs: [Web Service Connector](https://github.com/forcedotcom/wsc), aka WSC. [StreamSets Data Collector](https://streamsets.com/products/sdc)'s Salesforce integration accesses the SOAP and Bulk APIs via WSC, so, when I was implementing Mutual Authentication in SDC, I examined WSC to see where I could configure the client key and certificate chain. Although there is no mention of [`SSLContext`](https://docs.oracle.com/javase/8/docs/api/javax/net/ssl/SSLContext.html) or [`SSLSocketFactory`](https://docs.oracle.com/javase/8/docs/api/javax/net/ssl/SSLSocketFactory.html) in the WSC code, it is possible to set a custom [`TransportFactory`](https://github.com/forcedotcom/wsc/blob/af53b297cfd1da3fdaea125fa172984f04b0cded/src/main/java/com/sforce/ws/transport/TransportFactory.java) on the WSC [`ConnectorConfig`](https://github.com/forcedotcom/wsc/blob/af53b297cfd1da3fdaea125fa172984f04b0cded/src/main/java/com/sforce/ws/ConnectorConfig.java) object. The `TransportFactory` is used to create a [`Transport`](https://github.com/forcedotcom/wsc/blob/af53b297cfd1da3fdaea125fa172984f04b0cded/src/main/java/com/sforce/ws/transport/Transport.java), which in turn is responsible for making the HTTPS connection to Salesforce. To enable Mutual Authentication I would need to create an `SSLContext` with the client key and certificate chain. This is straightforward enough:

```
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

Given the `SSLContext`, we can create an `SSLSocketFactory` and set it on the `HttpsURLConnection`. Here's the code we'd use if we were simply using the `java.net` classes directly:

```
URL url = new URL(someURL);
HttpURLConnection conn = (HttpURLConnection)url.openConnection();
// Check that we did get an HttpsURLConnection before casting to it
if (conn instanceof HttpsURLConnection) {
  ((HttpsURLConnection)conn).setSSLSocketFactory(
      sslContext.getSocketFactory()
  );
}
```

# Mutual Authentication and the Salesforce SOAP API

The default `Transport` implementation, [`JdkHttpTransport`](https://github.com/forcedotcom/wsc/blob/af53b297cfd1da3fdaea125fa172984f04b0cded/src/main/java/com/sforce/ws/transport/JdkHttpTransport.java), looked like a good place to start. My first thought was to extend `JdkHttpTransport`, overriding the relevant methods. Unfortunately, `JdkHttpTransport`'s `createConnection` method, which calls `url.openConnection()`, is `static`, so it's impossible to override. The `connectRaw()` method also looked like a promising route, since it calls `createConnection()`, performs some setup on the `HttpURLConnection`, and then gets the `OutputStream`, but it's `private`, and once the `OutputStream` has been created, it's too late to set the `SSLSocketFactory`. In my searching for an answer, I came across this comment from Salesforce Software Engineer [Steven Lawrance](https://www.linkedin.com/in/meowmeow/) in a [Salesforce Trailblazer Community answer](https://success.salesforce.com/answers?id=9063A000000Dj7SQAS).

> You'll generally need to set the TransportFactory in the ConnectorConfig object that you use to create the PartnerConnection (or EnterpriseConnection, etc), though another option is to set the Transport. It's possible to create a Transport implementation that is based off of the com.sforce.ws.transport.JdkHttpTransport class while having the JdkHttpTransport create the connection with its static createConnection method. Your Transport implementation can then set up the SSLSocketFactory (casting the connection to HttpsURLConnection is required to do that), and your SSLSocketFactory can be created from creating an SSLContext that is initialized to include your client certificate.

I followed Steven's advice and created [`ClientSSLTransport`](https://github.com/streamsets/datacollector/blob/4a46b7414ae8407850f360e8f09281950b430a2a/salesforce-lib/src/main/java/com/streamsets/pipeline/lib/salesforce/mutualauth/ClientSSLTransport.java), a clone of `JdkHttpTransport`, and [`ClientSSLTransportFactory`](https://github.com/streamsets/datacollector/blob/4a46b7414ae8407850f360e8f09281950b430a2a/salesforce-lib/src/main/java/com/streamsets/pipeline/lib/salesforce/mutualauth/ClientSSLTransportFactory.java), its factory class. To minimize the amount of copied code, I changed the implementation of `connectRaw()` to call `JdkHttpTransport.createConnection()` and then set the `SSLSocketFactory`:

```
private OutputStream connectRaw(String uri, HashMap<String, String> httpHeaders, boolean enableCompression)
throws IOException {
  url = new URL(uri);

  connection = JdkHttpTransport.createConnection(config, url, 
      httpHeaders, enableCompression);
  if (connection instanceof HttpsURLConnection) {
    ((HttpsURLConnection)connection).setSSLSocketFactory(
        sslContext.getSocketFactory()
    );
  }
  connection.setRequestMethod("POST");
  connection.setDoInput(true);
  connection.setDoOutput(true);
  if (config.useChunkedPost()) {
    connection.setChunkedStreamingMode(4096);
  }

  return connection.getOutputStream();
}
```

With this in place, I wrote a [simple test application](https://github.com/metadaddy/mutual-auth/blob/master/src/main/java/mutualauth/TestWSC.java) to call an API with Mutual Authentication. As I mentioned in the previous blog post, the Salesforce login service does not support Mutual Authentication, so the inital code to authenticate is just the same as the default case:

```
// Login as normal to get instance URL and session token
ConnectorConfig config = new ConnectorConfig();
config.setAuthEndpoint("https://login.salesforce.com/services/Soap/u/39.0");
config.setSslContext(sc);
config.setUsername(USERNAME);
config.setPassword(PASSWORD);

connection = Connector.newConnection(config);

// display some current settings
System.out.println("Auth EndPoint: "+config.getAuthEndpoint());
System.out.println("Service EndPoint: "+config.getServiceEndpoint());
```

Running this bit of code revealed that, not only does the login service not support Mutual Authentication, it returns the default service endpoint:

```
Auth EndPoint: https://login.salesforce.com/services/Soap/u/39.0
Service EndPoint: https://na30.salesforce.com/services/Soap/u/39.0/00D36000000psQd
```

Before we can call an API, then, we have to override the service endpoint, changing the port from the default 443 to 8443, as well as setting the `TransportFactory`:

```
String serviceEndpoint = config.getServiceEndpoint();
// Override service endpoint port to 8443
config.setServiceEndpoint(changePort(serviceEndpoint, 8443));

// Set custom transport factory
config.setTransportFactory(new ClientSSLTransportFactory(sslContext));

...

private static String changePort(String url, int port) throws URISyntaxException {
  URI uri = new URI(url);
  return new URI(
      uri.getScheme(), uri.getUserInfo(), uri.getHost(),
      port, uri.getPath(), uri.getQuery(), uri.getFragment()).toString();
}
```

With this in place, I could call a SOAP API in the normal way:

```
System.out.println("Querying for the 5 newest Contacts...");

// query for the 5 newest contacts
QueryResult queryResults = connection.query("SELECT Id, FirstName, LastName, Account.Name " +
    "FROM Contact WHERE AccountId != NULL ORDER BY CreatedDate DESC LIMIT 5");
if (queryResults.getSize() > 0) {
  for (SObject s: queryResults.getRecords()) {
    System.out.println("Id: " + s.getId() + " " + s.getField("FirstName") + " " +
        s.getField("LastName") + " - " + s.getChild("Account").getField("Name"));
  }
}
```

With output:

```
Querying for the 5 newest Contacts...
Id: 00336000009BusFAAS Rose Gonzalez - Edge Communications
Id: 00336000009BusGAAS Sean Forbes - Edge Communications
Id: 00336000009BusHAAS Jack Rogers - Burlington Textiles Corp of America
Id: 00336000009BusIAAS Pat Stumuller - Pyramid Construction Inc.
Id: 00336000009BusJAAS Andy Young - Dickenson plc
```

Success!

# Mutual Authentication and the Salesforce Bulk API

Now, what about the Bulk API? Running a test app resulted in an error when I tried to create a Bulk API Job. Tracing through the WSC code revealed that when `ConnectorConfig.createTransport()` creates a `Transport` with a custom `TransportFactory`, it does not set the `ConnectorConfig` on the `Transport`:

```
public Transport createTransport() throws ConnectionException {
  if(transportFactory != null) {
    return transportFactory.createTransport();
  }

  try {
    Transport t = (Transport)getTransport().newInstance();
    t.setConfig(this);
    return t;
  } catch (InstantiationException e) {
    throw new ConnectionException("Failed to create new Transport " + getTransport());
  } catch (IllegalAccessException e) {
    throw new ConnectionException("Failed to create new Transport " + getTransport());
  }
}
```

`ConnectorConfig.createTransport()` is only used when the WSC Bulk API client is POSTing to the Bulk API, since the POST method is hardcoded into `JdkHttpTransport.connectRaw()` (all SOAP requests use HTTP POST). When the client wants to do a GET, it uses `BulkConnection.doHttpGet()`, which does not use `ConnectorConfig.createTransport()`, instead calling `config.createConnection()`:

```
private InputStream doHttpGet(URL url) throws IOException, AsyncApiException {
  HttpURLConnection connection = config.createConnection(url, null);
  connection.setRequestProperty(SESSION_ID, config.getSessionId());
  ...
```

The problem here is that `config.createConnection()` ultimately just calls `url.openConnection()` directly, bypassing any custom Transport:

```
public HttpURLConnection createConnection(URL url,
HashMap<String, String> httpHeaders, boolean enableCompression) throws IOException {

  if (isTraceMessage()) {
    getTraceStream().println( "WSC: Creating a new connection to " + url + " Proxy = " +
        getProxy() + " username " + getProxyUsername());
  }

  HttpURLConnection connection = (HttpURLConnection) url.openConnection(getProxy());
  connection.addRequestProperty("User-Agent", VersionInfo.info());
  ...
```

Luckily, `config.createConnection()` is public, so my solution to these problems was to subclass `ConnectorConfig` as [`MutualAuthConnectorConfig`](https://github.com/streamsets/datacollector/blob/69914117f85ed766327d6e3cd1b9083dc2e37bfe/salesforce-lib/src/main/java/com/streamsets/pipeline/lib/salesforce/mutualauth/MutualAuthConnectorConfig.java), providing an `SSLContext` in its constructor, and overriding `createConnection()`:

```
public class MutualAuthConnectorConfig extends ConnectorConfig {
  private final SSLContext sc;

  public MutualAuthConnectorConfig(SSLContext sc) {
    this.sc = sc;
  }

  @Override
  public HttpURLConnection createConnection(URL url, HashMap<String, String> httpHeaders, 
      boolean enableCompression) throws IOException {
    HttpURLConnection connection = super.createConnection(url, httpHeaders, enableCompression);
    if (connection instanceof HttpsURLConnection) {
      ((HttpsURLConnection)connection).setSSLSocketFactory(sc.getSocketFactory());
    }
    return connection;
  }
}
```

If you look at [`ClientSSLTransport`](https://github.com/streamsets/datacollector/blob/4a46b7414ae8407850f360e8f09281950b430a2a/salesforce-lib/src/main/java/com/streamsets/pipeline/lib/salesforce/mutualauth/ClientSSLTransport.java) and [`ClientSSLTransportFactory`](https://github.com/streamsets/datacollector/blob/4a46b7414ae8407850f360e8f09281950b430a2a/salesforce-lib/src/main/java/com/streamsets/pipeline/lib/salesforce/mutualauth/ClientSSLTransportFactory.java), you'll notice that the factory has a two-argument constructor that allows us to pass the `ConnectorConfig`. This ensures that the `Transport` can get the configuration it needs, despite the fact that `ConnectorConfig.createTransport()` neglects to set the config. Now, when creating a `BulkConnection` from a Partner API `ConnectorConfig`, I use my subclassed `ConnectorConfig` class AND set the `TransportFactory` on it, so that the `SSLSocketFactory` is set for both GET and POST:

```
  ConnectorConfig bulkConfig = new MutualAuthConnectorConfig(sslContext);
  bulkConfig.setTransportFactory(new ClientSSLTransportFactory(sslContext, bulkConfig));
  bulkConfig.setSessionId(partnerConfig.getSessionId()); 

  // The endpoint for the Bulk API service is the same as for the normal 
  // SOAP uri until the /Soap/ part. From here it's '/async/versionNumber' 
  String soapEndpoint = partnerConfig.getServiceEndpoint(); 
  String restEndpoint = soapEndpoint.substring(0, soapEndpoint.indexOf("Soap/")) 
      + "async/" + conf.apiVersion; 

  // Remember to swap the port for Mutual Authentication! 
  bulkConfig.setRestEndpoint(changePort(restEndpoint, 8443));
```

Running my simple sample app showed that I was able to successfully retrieve data via the Bulk API:

```
Querying for the 5 newest Contacts via the Bulk API...
Created job: 7503600000KbCyMAAV
Batch state is: Queued
Sleeping for a second...
Sleeping for a second...
Sleeping for a second...
Batch state is: Completed
Result header:[Id, FirstName, LastName, Account.Name]
Id: 00336000009BusFAAS Rose Gonzalez - Edge Communications
Id: 00336000009BusGAAS Sean Forbes - Edge Communications
Id: 00336000009BusHAAS Jack Rogers - Burlington Textiles Corp of America
Id: 00336000009BusIAAS Pat Stumuller - Pyramid Construction Inc.
Id: 00336000009BusJAAS Andy Young - Dickenson plc
```

You can grab my sample app and all of the above mentioned files [here](https://github.com/metadaddy/mutual-auth).

# Proposed WSC Changes

With the above changes I was able to call both the SOAP and Bulk APIs and include the WSC JAR files unchanged. I filed issue [#213](https://github.com/forcedotcom/wsc/issues/213) on WSC, and then fixed the problems in the WSC directly ([pull request](https://github.com/forcedotcom/wsc/pull/216)) by adding an `SSLContext` member variable and its getter/setter to `ConnectorConfig` and having `JdkHttpTransport.connectRaw()` and `BulkConnection.doHttpGet()` set the `SSLSocketFactory` on the `HttpsURLConnection` immediately after it's created. I'll update this blog entry if and when my pull request is accepted.

# Conclusion

The [first blog entry in this series](salesforce-mutual-authentication-part-1-the-basics) explained how to enable, configure and test [Salesforce Mutual Authentication](https://help.salesforce.com/articleView?id=000240864&type=1). This time, I showed how to work around the shortcomings in the [Salesforce Web Service Connector](https://github.com/forcedotcom/wsc) (WSC) to allow it to work with Mutual Authentication. In [part 3, the final installment in this series](salesforce-mutual-authentication-part-3-java-http-clients), I show you how to use Mutual Authentication with common HTTP clients to access Salesforce API endpoints directly.