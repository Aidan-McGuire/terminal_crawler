# require 'nokogiri'
# require 'open-uri'
require 'mechanize'

class TerminalCrawler
  def initialize
    url = 'https://terminal.turing.edu'
    @agent = Mechanize.new
    @agent.get(url)
  end
  
  def get_links
    profiles = @agent.page.links_with(:text => "\n                See full profile\n                \n")
  end

  def check_status(profile)
    profile.links_with(:text => "\n          Launch the App\n").find_all do |link|
      link.click.code.to_i >= 400
    end
  end
end

crawler = TerminalCrawler.new
crawler.get_links