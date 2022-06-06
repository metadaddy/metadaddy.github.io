---
author: user
title: Blog Bling - Part 2 - Tag Cloud
slug: blog-bling-part-2-tag-cloud
id: 514
date: '2007-06-28 06:27:15'
layout: single
categories:
  - General
---

<span style="margin: 5px; float: right;">[![](images/TagCloud.png)](http://blogs.sun.com/superpat/)</span>

Back in version 3.1, [Apache Roller](http://roller.apache.org/) [added support for tags](http://cwiki.apache.org/confluence/display/ROLLER/What%27s+new+in+Roller+3.1). After [Dave Levy](http://blogs.sun.com/DaveLevy/) [blogged about tag clouds](http://blogs.sun.com/DaveLevy/entry/more_about_tag_clouds_on), [I added one](http://blogs.sun.com/superpat/entry/from_categories_to_tags), based on his code:

```
#set($mytags = $model.weblog.getPopularTags(-1, 100))
#foreach ($tag in $mytags)
#if ($tag.count > 2)
<a class="tag s${tag.intensity}" href="$url.tag($tag.name)"
title="$tag.count">$tag.name</a>
#end
#end

```

The code is quite simple - we create a set of popular tags, and, for each tag, if there are more than two blog entries with that tag, we create a link. The link's class is s1, s2...s5 based on the number of entries with that tag ('tag intensity'). The classes control the font size of the link:

```
<style type="text/css">
.s1 {
font-size:60%;
}
.s2 {
font-size:80%;
}
.s3 {
font-size:100%;
}
.s4 {
font-size:120%;
}
.s5 {
font-size:140%;
}
</style>

```

That's all there is to it. I can link to all entries for a given tag - for example, [http://blogs.sun.com/superpat/tags/opensso](http://blogs.sun.com/superpat/tags/opensso); there are even RSS feeds per tag - [http://blogs.sun.com/superpat/feed/entries/atom?tags=opensso](http://blogs.sun.com/superpat/feed/entries/atom?tags=opensso). You can also combine tags to get an intersection - [http://blogs.sun.com/superpat/tags/opensso+saml](http://blogs.sun.com/superpat/tags/opensso+saml). I've completely moved from categories to tags now - "It just works".