---
author: user
title: Uploading data to the Salesforce Wave Analytics Cloud
slug: uploading-data-to-the-salesforce-wave-analytics-cloud
id: 1610
date: '2016-03-17 21:18:27'
layout: single
categories:
  - Salesforce
  - StreamSets
tags:
  - analytics
  - salesforce
  - wave
---

![bi_phoneOverDesktop](images/bi_phoneOverDesktop-300x239.png){: .align-left}As you might know from [my last post](thank-you-for-the-music), I moved from Salesforce to [StreamSets](https://streamsets.com/) a couple of weeks ago. It didn't take long before I was signing up for a fresh Developer Edition org, though! I'm creating a StreamSets destination to allow me to write data to [Wave Analytics](http://www.salesforce.com/analytics-cloud/overview/) datasets, and it's fair to say that the documentation is... sparse. Working from the [Wave Analytics External Data API Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.bi_dev_guide_ext_data.meta/bi_dev_guide_ext_data/) and [Wave Analytics External Data Format Reference](https://developer.salesforce.com/docs/atlas.en-us.bi_dev_guide_ext_data_format.meta/bi_dev_guide_ext_data_format/) (why are these separate docs???), and my understanding of how Salesforce works, I was able to put together a working sample Java app that creates a dataset from CSV data. Here's the code - I explain a few idiosyncrasies below, and reveal the easiest way to get this working with Wave.

```java
package wsc;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.List;
import com.sforce.soap.partner.Connector;
import com.sforce.soap.partner.Error;
import com.sforce.soap.partner.PartnerConnection;
import com.sforce.soap.partner.QueryResult;
import com.sforce.soap.partner.SaveResult;
import com.sforce.soap.partner.sobject.SObject;
import com.sforce.ws.ConnectionException;
import com.sforce.ws.ConnectorConfig;

public class Main {
    // Describes the data we'll be uploading
    static String metadataJson = "{\n" + 
        " \"fileFormat\": {\n" + 
            " \"charsetName\": \"UTF-8\",\n" + 
            " \"fieldsDelimitedBy\": \",\",\n" + 
            " \"fieldsEnclosedBy\": \"\\\"\",\n" + 
            " \"numberOfLinesToIgnore\": 1\n" + 
        " },\n" + 
        " \"objects\": [\n" + 
            " {\n" + 
                " \"connector\": \"AcmeCSVConnector\",\n" + 
                " \"description\": \"\",\n" + 
                " \"fields\": [\n" + 
                    " {\n" + 
                        " \"description\": \"\",\n" + 
                        " \"fullyQualifiedName\": \"SalesData.Name\",\n" + 
                        " \"isMultiValue\": false,\n" + 
                        " \"isSystemField\": false,\n" + 
                        " \"isUniqueId\": false,\n" + 
                        " \"label\": \"Account Name\",\n" + 
                        " \"name\": \"Name\",\n" + 
                        " \"type\": \"Text\"\n" + 
                    " },\n" + 
                    " {\n" + 
                        " \"defaultValue\": \"0\",\n" + 
                        " \"description\": \"\",\n" + 
                        " \"format\": \"$#,##0.00\",\n" + 
                        " \"fullyQualifiedName\": \"SalesData.Amount\",\n" + 
                        " \"isSystemField\": false,\n" + 
                        " \"isUniqueId\": false,\n" + 
                        " \"label\": \"Opportunity Amount\",\n" + 
                        " \"name\": \"Amount\",\n" + 
                        " \"precision\": 10,\n" + 
                        " \"scale\": 2,\n" + 
                        " \"type\": \"Numeric\"\n" + 
                    " },\n" + 
                    " {\n" + 
                        " \"description\": \"\",\n" + 
                        " \"fiscalMonthOffset\": 0,\n" + 
                        " \"format\": \"MM/dd/yyyy\",\n" + 
                        " \"fullyQualifiedName\": \"SalesData.CloseDate\",\n" + 
                        " \"isSystemField\": false,\n" + 
                        " \"isUniqueId\": false,\n" + 
                        " \"label\": \"Opportunity Close Date\",\n" + 
                        " \"name\": \"CloseDate\",\n" + 
                        " \"type\": \"Date\"\n" + 
                    " }\n" + 
                " ],\n" + 
                " \"fullyQualifiedName\": \"SalesData\",\n" + 
                " \"label\": \"Sales Data\",\n" + 
                " \"name\": \"SalesData\"\n" + 
            " }\n" + 
        " ]\n" + 
    "}"; 

    // This is the data we'll be uploading
    static String data = "Name,Amount,CloseDate\n" + 
        "opportunityA,100.99,6/30/2014\n" + 
        "opportunityB,99.01,1/31/2012\n";

    // This will be the name of the data set in Wave
    // Must be unique across the organization
    static String datasetName = "tester";

    // Change these as appropriate
    static final String USERNAME = "user@example.com";
    static final String PASSWORD = "p455w0rd";

    // Status values indicating that the job is done
    static final List&lt;String&gt; DONE = (List&lt;String&gt;)Arrays.asList( "Completed", "CompletedWithWarnings", "Failed", "NotProcessed" );

    public static void main(String[] args) {
        PartnerConnection connection;

        ConnectorConfig config = new ConnectorConfig();
        config.setUsername(USERNAME);
        config.setPassword(PASSWORD);

        try {
            connection = Connector.newConnection(config);
            System.out.println("Successfully authenticated as "+config.getUsername());

            // Wave time!

            // First, we create an InsightsExternalData job
            SObject sobj = new SObject();
            sobj.setType("InsightsExternalData");
            sobj.setField("Format","Csv");
            sobj.setField("EdgemartAlias", datasetName);
            sobj.setField("MetadataJson", metadataJson.getBytes(StandardCharsets.UTF_8));
            sobj.setField("Operation","Overwrite");
            sobj.setField("Action","None");

            String parentID = null;
            SaveResult[] results = connection.create(new SObject[] { sobj });

            for(SaveResult sv:results) {
                if(sv.isSuccess()) {
                    parentID = sv.getId();
                    System.out.println("Success creating InsightsExternalData: "+parentID); 
                } else {
                    for (Error e : sv.getErrors()) {
                        System.out.println("Error: " + e.getMessage());
                    }
                    System.exit(1);
                }
            }

            // Now upload some actual data. You can do this as many times as necessary,
            // subject to the Wave External Data API Limits
            sobj = new SObject();
            sobj.setType("InsightsExternalDataPart");
            sobj.setField("DataFile", data.getBytes(StandardCharsets.UTF_8));
            sobj.setField("InsightsExternalDataId", parentID);
            sobj.setField("PartNumber", 1);

            results = connection.create(new SObject[] { sobj });

            for(SaveResult sv:results) {
                if(sv.isSuccess()) {
                    String rowId = sv.getId();
                    System.out.println("Success creating InsightsExternalDataPart: "+rowId);
                } else {
                    for (Error e : sv.getErrors()) {
                        System.out.println("Error: " + e.getMessage());
                    }
                    System.exit(1);
                }
            }

            // Instruct Wave to start processing the data
            sobj = new SObject();
            sobj.setType("InsightsExternalData");
            sobj.setField("Action","Process");
            sobj.setId(parentID);

            results = connection.update(new SObject[] { sobj });

            for(SaveResult sv:results) {
                if(sv.isSuccess()) {
                    String rowId = sv.getId();
                    System.out.println("Success updating InsightsExternalData: "+rowId);
                } else {
                    for (Error e : sv.getErrors()) {
                        System.out.println("Error: " + e.getMessage());
                    }
                    System.exit(1);
                }
            }

            // Periodically check whether the job is done
            boolean done = false;
            int sleepTime = 1000;
            while (!done) {
                try {
                    Thread.sleep(sleepTime);
                    sleepTime *= 2;
                } catch(InterruptedException ex) {
                    Thread.currentThread().interrupt();
                }

                QueryResult queryResults = connection.query( "SELECT Status FROM InsightsExternalData WHERE Id = '" + parentID + "'" );

                if (queryResults.getSize() &gt; 0) {
                    for (SObject s: queryResults.getRecords()) {
                        String status = (String)s.getField("Status");
                        System.out.println(s.getField("Status"));
                        if (DONE.contains(status)) {
                            done = true;
                            String statusMessage = (String)s.getField("StatusMessage");
                            if (statusMessage != null) {
                                System.out.println(statusMessage);
                            }
                        }
                    }
                } else {
                    System.out.println("Can't find InsightsExternalData with Id " + parentID);
                }
            }
        } catch (ConnectionException e1) {
            e1.printStackTrace();
        }
    }
}
```

*   Lines 7-14 - I'm using the WSC with the SOAP Partner API, just because I'm working in Java, and that was what was used in the bits of sample code included in the docs.
*   Lines 19-72 - this is the metadata that describes the CSV you're uploading. This is optional, but recommended.
*   Lines 75-78 - CSV is the only format currently supported, though the docs reserve a binary format for Salesforce use.
*   Line 82 - the dataset name must be unique across your org.
*   Lines 85-86 - change these to your login credentials.
*   Line 117 - the API wants base64-encoded data, so you'd likely try encoding the data yourself and passing the resulting string here, resulting in an error message. Instead you have to pass the raw bytes of the unencoded string and let the WSC library sort it out.
*   Lines 137-154 - you can repeat this block in a loop as many times as necessary.

You will need the WSC jar, and the SOAP Partner API jar - follow [Jeff Douglas](https://twitter.com/jeffdonthemic)' excellent article [Introduction to the Force.com Web Services Connector](https://developer.salesforce.com/page/Introduction_to_the_Force.com_Web_Services_Connector) for details on setting this up - use the 'uber' JAR as it contains all the required dependencies. The sample above used Jeff's Partner API sample as a starting point - thanks, Jeff! The fastest way to get started with Wave is, of course, [Salesforce Trailhead](https://developer.salesforce.com/trailhead/). Follow the [Wave Analytics Basics module](https://developer.salesforce.com/trailhead/en/module/wave_analytics_basics) and you'll end up with a Wave-enabled Developer Edition all ready to go. Once you have your Wave DE org, and the sample app, you should be able to run it and see something like:

```
Successfully authenticated as wave@patorg.com
Success creating InsightsExternalData: 06V360000008RIlEAM
Success creating InsightsExternalDataPart: 06W36000000PDXFEA4
Success updating InsightsExternalData: 06V360000008RIlEAM
InProgress
InProgress
Completed
```

If you go look in the Wave Analytics app, you should see the 'tester' dataset: ![WaveAnalytics](images/WaveAnalytics-1024x646.png) Click on 'tester' and you'll see the 'big blue line': ![TesterDataset](images/TesterDataset-1024x408.png) Now you can drill into the data (all 2 rows of it!) by account name, close date etc. You could, of course, extend the above code to accept a CSV filename and dataset name on the command line, and create all sorts of interesting extensions. Follow the [StreamSets blog](https://streamsets.com/blog/) to learn where I plan to go with this!