---
author: user
title: WordPress Tip - Redirect to Main Page on 404
slug: wordpress-tip-redirect-to-main-page-on-404
id: 1284
date: '2010-11-13 21:49:08'
layout: single
categories:
  - Uncategorized
---

If you're using the [Postalicious](http://wordpress.org/extend/plugins/postalicious/) WordPress plugin to post your [del.icio.us](http://del.icio.us/) links to your blog, you might have noticed that it doesn't always handle the occasional 500 errors from del.icio.us very well, and you end up with a bogus 'links' entry on your blog with a link to '500 Server Error'.

In itself, it's not that big a deal; I usually notice the bogus post pretty quickly and just delete it, but, by then, it's been tweeted by [Twitterfeed](http://twitterfeed.com/), pushed to Facebook, and folks have it in their RSS stream, so they hit the 'links for the day' link and get the default '404 page not found' message. In fact, if you ever delete a post for any reason, you're in the same situation - the link is out there, you can't call it back (even if you go delete it from Twitter and Facebook, it's still out there somewhere!), and people are going to land on that ugly page.

So, I got thinking... That default 404 page isn't really good for much... What if I could just send people to the [main page of my blog](http://blog.superpat.com/)? Well, with a couple of minutes googling I found a [useful blog post on the subject](http://www.wordpressmax.com/wordpress-guide/wordpress-404) and [the WordPress docs for get_bloginfo()](http://codex.wordpress.org/Function_Reference/get_bloginfo), and came up with the following replacement for the default 404 page:

```
<?php
   header("Status: 301 Moved Permanently");
   header("Location: ".get_bloginfo('url'));
?>

```

You could do fancier things with a JavaScript redirect that shows a 'page not found' message then redirects after a few seconds, but I prefer the more direct approach :-)