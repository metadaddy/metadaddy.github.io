---
author: user
title: OpenSSO Code_Swarm Visualization
slug: opensso-code_swarm-visualization
id: 308
date: '2009-01-15 08:54:37'
layout: single
categories:
  - OpenSSO
---

[Code_Swarm](http://vis.cs.ucdavis.edu/~ogawa/codeswarm/) produces a compelling visualization of the commits over the lifetime of a software project, showing the ebb and flow of development. I put together a video last night showing the history of [OpenSSO](http://opensso.org/):

<object width="480" height="385"><param name="movie" value="http://www.youtube.com/v/E-COJoJ8SG0&amp;hl=en&amp;fs=1&amp;rel=0&amp;ap=%2526fmt%3D18 "><param name="allowFullScreen" value="true"><param name="allowscriptaccess" value="always"><embed src="http://www.youtube.com/v/E-COJoJ8SG0&amp;hl=en&amp;fs=1&amp;rel=0&amp;ap=%2526fmt%3D18 " type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="480" height="385"></object>

When you watch the video (embedded above in 'high quality', thanks to [this tip at 'My Digital Life'](http://www.mydigitallife.info/2008/06/12/how-to-embed-high-quality-and-higher-resolution-youtube-videos-on-blog-or-website/)), you can see how the project got off to a quiet start (in terms of commits) in mid 2005, then came alive at the very end of October 2005 with [the first big code commitment](https://opensso.dev.java.net/servlets/NewsItemView?newsItemID=2905). You can see [the web agent code (rendered in yellow) being added](https://opensso.dev.java.net/servlets/NewsItemView?newsItemID=3700) in May 2006, then the [federation code (purple)](https://opensso.dev.java.net/servlets/NewsItemView?newsItemID=4377) in November 2006\. After that, it's pretty much one continuous firework show. One particularly spectacular blast is in late June 2008, when we had to make a global change to the copyright headers:

[![](http://blog.superpat.com/code_swarm.png)](http://www.youtube.com/watch?v=E-COJoJ8SG0&fmt=6)

If you've worked on OpenSSO, it's fun to watch for your name appearing with your first commit - see if you can spot me ('superpat7') in March 2007...

Thanks to [Rich](http://blog.softwhere.org/) for [the tip](http://blog.softwhere.org/archives/661).