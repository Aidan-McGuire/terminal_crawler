require 'mechanize'
require 'pry'
require 'progress_bar'

class TerminalCrawler
  def initialize
    url = 'https://terminal.turing.edu'
    @mechanize = Mechanize.new
    @mechanize.get(url)
    @see_profile_text = "\n                See full profile\n                \n"
    @launch_app_text = "\n          Launch the App\n"
    @email_text = "\n        Email Directly\n"
    @exceptions = [Mechanize::ResponseCodeError, Net::HTTP::Persistent::Error]
  end
  
  def get_profiles_with_bad_links
    total_number_of_profiles = get_profile_links.count
    progress_bar = ProgressBar.new(total_number_of_profiles, :bar, :counter, :elapsed)
    get_profile_links.map do |profile_link|
      progress_bar.increment!
      check_status(profile_link) if check_status(profile_link).any?
    end.compact
  end
  
  def get_profile_links
    profiles = @mechanize.page.links_with(:text => @see_profile_text)
  end
  
  def check_status(link_to_profile)
    broken_profiles = Hash.new { |hash, key| hash[key] = [] }
    profile = link_to_profile.click
    profile.links_with(:text => @launch_app_text).find_all do |link|
      begin
        link.click
      rescue *@exceptions
        email = profile.link_with(:text => @email_text).uri.to_s.split(":").pop
        bad_link = link.uri.to_s
        broken_profiles[email] << bad_link
      end
    end
    broken_profiles
  end
end
