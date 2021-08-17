require './lib/terminal_crawler.rb'
require 'pry'


profile_links = TerminalCrawler.retrieve_profile_links
project_links = TerminalCrawler.retrieve_profile_content(profile_links)
broken_profiles = TerminalCrawler.retrieve_broken_profiles(project_links)

