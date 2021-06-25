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
    exceptions = [Mechanize::ResponseCodeError, Net::HTTP::Persistent::Error]
    broken_profiles = []
    profile.click.links_with(:text => "\n          Launch the App\n").find_all do |link|
      begin
        link.click
      rescue *exceptions
        broken_profiles << [profile, link]
      end
    end
    broken_profiles
  end
end
