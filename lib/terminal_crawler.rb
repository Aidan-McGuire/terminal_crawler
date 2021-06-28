require 'mechanize'

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
    counter = 1
    broken = get_profile_links.map do |profile_link|
      check_status(profile_link)
      profile_counter(counter); counter += 1
    end
    broken.reject { |i| i.empty? }
  end
  
  def get_profile_links
    profiles = @mechanize.page.links_with(:text => @see_profile_text)
  end
  
  def check_status(link_to_profile)
    broken_profiles = []
    profile = link_to_profile.click
    profile.links_with(:text => @launch_app_text).find_all do |link|
      begin
        link.click
      rescue *@exceptions
        email = profile.link_with(:text => @email_text).uri.to_s
        profile_uri = link_to_profile.uri.to_s
        bad_link = link.uri.to_s
        broken_profiles << [email, profile_uri, bad_link]
      end
    end
    broken_profiles
  end

  def profile_counter(counter)
    return p "#{counter} profile checked" if counter <= 1
    return p "#{counter} profiles checked" if counter > 1
  end
end
