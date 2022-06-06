---
author: user
title: 'Latest OpenSSO Extension: SAML 2.0 on Ruby'
slug: latest-opensso-extension-saml-2-0-on-ruby
id: 556
date: '2007-03-20 13:54:27'
layout: single
categories:
  - OpenSSO
---

[<span style="margin: 5px; float: right;">![](http://www.ruby-lang.org/images/logo.gif)</span>](http://www.ruby-lang.org/)

_UPDATE 21 March 2007_ - I missed a couple of steps, including, ironically, installing the SAML 2.0 Ruby code. All should be well now.

Hot on the heels of our [launch](http://blogs.sun.com/superpat/entry/lightbulb_is_dead_long_live) of [OpenSSO Extensions](https://opensso.dev.java.net/public/extensions/) comes the latest extension, contributed by Todd Saxton from New Zealand: a [SAML 2.0](http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=security#samlv20) relying party implementation in [Ruby](http://www.ruby-lang.org/) (already noticed by the sharp-eyed [Tatsuo Kudo](http://blogs.sun.com/tkudo), [here](http://blogs.sun.com/tkudo/entry/saml2ruby)). Todd used the [existing SAML 2.0 PHP relying party](https://opensso.dev.java.net/source/browse/opensso/extensions/saml2php/source) (formerly known as Lightbulb) as a starting point and ported it to Ruby, using Roland Schmitt's [WSS4R](http://rubyforge.org/projects/wss4r) to handle the XML Security chores. Note that both the Ruby and PHP SAML 2.0 relying party implementations are very much 'proofs of concept'. They successfully complete SAML 2.0 single sign-on and single logout, but are not to be considered production quality. In particular, [Andreas Solberg](http://rnd.feide.no/) has [identified some bugs and shortcomings in the PHP implementation](http://rnd.feide.no/2007/01/16/enabling-saml-20-in-a-php-application/) and kindly offered to contribute his [fixes](http://rnd.feide.no/2007/03/12/lightbulb-updates/) (nudge!).

I just downloaded the [Ruby SAML 2.0 code](https://opensso.dev.java.net/source/browse/opensso/extensions/saml2ruby/source) and... it works! I made [one minor fix](https://opensso.dev.java.net/source/browse/opensso/extensions/saml2ruby/source/lib/xml_sec.rb?r1=1.1&r2=1.2) to account for differences in my environment, but everything else was just configuration. Here is a checklist of what you'll need (I used [this very useful HOWTO on Rails installation](http://railsforum.com/viewtopic.php?pid=16102) as a base):

*   Install [Ruby](http://www.ruby-lang.org/) - I have version 1.8.4, installed into Ubuntu via apt-get.
*   Install [RubyGems](http://rubyforge.org/projects/rubygems/) - I have version 0.9.2\.
*   Install [Rails](http://www.rubyonrails.org/) - I have version 1.2.3, installed via gem.
*   (Optional) Install [Mongrel](http://mongrel.rubyforge.org/) - I have version 1.0.1, installed via gem.
*   Install [WSS4R](http://rubyforge.org/projects/wss4r) - I downloaded the tarball and ran `ruby setup.rb.`
`*   Install [LOG4R](http://log4r.sourceforge.net/) (needed by WSS4R) - I used `gem install log4r`.*   Checkout the SAML 2.0 Ruby source from opensso.dev.java.net (it's in `opensso/extensions/saml2ruby/source`). [Instructions for getting the code via CVS](https://opensso.dev.java.net/servlets/ProjectSource).*   Patch the WSS4R library's `xmlcanonicalizer.rb` according to the instructions in saml2ruby's [INSTALL](https://opensso.dev.java.net/source/browse/opensso/extensions/saml2ruby/source/INSTALL?view=markup) file.*   Edit `saml2ruby/source/examples/rails/SimpleSAMLRP/config/environment.rb` and change `RAILS_GEM_VERSION` to match what you have. There may be cleaner ways of doing this, but this is what worked for me.*   Edit `saml2ruby/source/examples/rails/SimpleSAMLRP/app/controllers/account_controller.rb` and change the SP and IdP settings to match your environment.*   Run the server - from `saml2ruby/source/examples/rails/SimpleSAMLRP` do `mongrel_rails start` or `ruby script/server`.*   Now browse to `http://myserver.mydomain.com/3000/account/login` and you should be redirected to authenticate at the IdP. On successful authentication you should be sent back to the Ruby SP example app which will report a successful login.`

`[![](http://blog.superpat.com/saml2ruby.png)](http://blog.superpat.com/saml2ruby.png)

So - if you're a Ruby-ist (Ruby-ite? Rubier?) and you need SAML 2.0, [go grab saml2ruby](https://opensso.dev.java.net/source/browse/opensso/extensions/saml2ruby/source/)!`