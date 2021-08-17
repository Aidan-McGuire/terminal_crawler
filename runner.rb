require './lib/terminal_crawler.rb'
require 'pry'

# profiles = TerminalCrawler.retrieve_broken_profiles
links = TerminalCrawler.check_links(["http://mixdup.vercel.app/"])
binding.pry
