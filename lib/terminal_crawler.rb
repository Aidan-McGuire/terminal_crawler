require 'mechanize'

class TerminalCrawler
  def initialize
    url = 'https://terminal.turing.edu'
    @mechanize = Mechanize.new
    @mechanize.get(url)
    @see_profile_text = "\n                See full profile\n                \n"
    @launch_app_text = "\n          Launch the App\n"
    @exceptions = [Mechanize::ResponseCodeError, Net::HTTP::Persistent::Error]
  end
  
  def get_profiles_with_bad_links
    broken = get_profile_links.first(5).map do |link|
      check_status(link)
    end
    broken.reject { |i| i.empty? }
  end
  
  def get_profile_links
    profiles = @mechanize.page.links_with(:text => @see_profile_text)
  end
  
  def check_status(profile)
    broken_profiles = []
    profile.click.links_with(:text => @launch_app_text).find_all do |link|
      begin
        link.click
      rescue *@exceptions
        broken_profiles << [profile, link]
      end
    end
    broken_profiles
  end
end
