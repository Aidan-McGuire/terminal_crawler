require './lib/terminal_crawler.rb'
require 'pry'

profile_links = TerminalCrawler.retrieve_profile_links # collect links to all profiles
project_links = TerminalCrawler.retrieve_profile_content(profile_links) # collect project links from each profile
broken_profiles = TerminalCrawler.retrieve_broken_profiles(project_links) # find all broken project links
