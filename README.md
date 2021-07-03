# terminal_crawler


This is a CLI app that crawls Turing School's Terminal looking for broken project links.  
I built this app in an effort to give back to the Turing community. I plan to create a version of this app that emails the owners of the broken links to notify them; however, for the sake of those individuals inboxes that repo will be private.

At the moment Turing's Terminal is host to 130 alumni profiles. The app takes quite a while to run due to the number of links to check and more importantly the number of projects hosted on free, slow to wake up, Heroku servers. My next steps are to improve the output to the terminal and implement background workers to speed up the runtime. 

Ruby Version 3.0.0

### Set Up Instructions
```
git clone git@github.com:A-McGuire/terminal_crawler.git
cd terminal_crawler
bundle install
ruby runner.rb
```
