# terminal_crawler


Terminal Crawler provides users a CLI to scrape Turing’s Terminal site to check alumni profiles for broken project links. This is the first project that I’ve tackled outside of the Turing curriculum, which has given me an opportunity to explore topics not covered in class. At this point, I’ve created a simple app that scrapes the Terminal site and successfully identifies broken links. I recently implemented threading to significantly decrease the runtime to check all of the alumni links, and am planning on adding the option to send email notifications from this plain old Ruby project to users who have broken links in their profiles; I will likely implement threading once again to give users the ability to get back to work rather than waiting for those emails to send.

Ruby Version 3.0.0

### Set Up Instructions
```
git clone git@github.com:A-McGuire/terminal_crawler.git
cd terminal_crawler
bundle install
ruby runner.rb 
```
