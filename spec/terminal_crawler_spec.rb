require './spec/spec_helper'
require './lib/terminal_crawler'

RSpec.describe TerminalCrawler do
  it 'can get links to alums terminal profiles', :vcr do
    crawler = TerminalCrawler.new
    profile_links = crawler.get_profile_links
    expect(profile_links).to be_an Array
    expect(profile_links.first).to be_a Mechanize::Page::Link

    require 'pry'; binding.pry
  end
end