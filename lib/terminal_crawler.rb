require 'open-uri'
require 'nokogiri'
require 'pry'

class TerminalCrawler
  class << self
    def retrieve_profile_links # collect links to all profiles
      doc = Nokogiri::HTML(URI.open('https://terminal.turing.edu'))
      elements = doc.css('a:contains("See full profile")')
      profile_links = elements.map do |ele|
        ele['href']
      end
    end

    def retrieve_profile_content(profile_links) # collect project links and emails from each profile
      profile_content = Hash.new { |hash, key| hash[key] = [] }
      profile_links.each do |link|
        profile = Nokogiri::HTML(URI.open("https://terminal.turing.edu#{link}"))
        elements = profile.css('a:contains("Launch the App")')

        project_links = elements.map do |link|
          link['href']
        end

        alum_email_element = profile.css('a:contains("Email Directly")')
        email = alum_email_element.first['href'].split(':').last
        profile_content[email] = project_links
        sleep(3)
      end
      profile_content
    end
  end
end
