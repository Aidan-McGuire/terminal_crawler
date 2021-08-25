require './lib/terminal_crawler.rb'
require './lib/link_checker.rb'
require './lib/alum_emailer.rb'
require 'pry'

profile_links = TerminalCrawler.retrieve_profile_links # collect links to all profiles
profile_content = TerminalCrawler.retrieve_profile_content(profile_links) # collect project links from each profile
broken_links = LinkChecker.retrieve_broken_profiles(profile_content) # find all broken project links
broken_profiles = AlumEmailer.retrieve_emails(broken_links, profile_content) # re associate broken links with alum emails
p broken_profiles