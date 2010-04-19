Spree Frequently Asked Question Extension
=========

An spree extension for managing FAQs

Installation
============

To install the extension use this command:

script/extension install git://github.com/joshnuss/spree-faq.git

rake db:migrate

rake spree:extensions:faq:update

Viewing FAQs
============

http://yourdomain.tld/faq

Editing FAQs
===========

1. Login to Administraton Console
2. Click on Configuration 
3. Click on the Frequently Asked Questions link

Loading Sample FAQs
=============

There are sample FAQs loaded as part of the rake db:bootstrap task.  

See the sample data in db/sample.
