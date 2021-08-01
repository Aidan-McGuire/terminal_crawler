require 'open-uri'
require 'nokogiri'
class TerminalCrawler
  class << self
    def retrieve_profile_links
      doc = Nokogiri::HTML(URI.open('https://terminal.turing.edu'))
      elements = doc.css('a:contains("See full profile")')
      profile_links = elements.map do |ele|
        ele['href']
      end
    end

    def retrieve_profile_content
      profile_content = Hash.new { |hash, key| hash[key] = [] }
      profile_links = retrieve_profile_links
      profile_links.each do |link|
        profile = Nokogiri::HTML(URI.open("https://terminal.turing.edu#{link}"))
        elements = profile.css('a:contains("Launch the App")')

        project_links = elements.map do |link|
          link['href']
        end

        alum_email_element = profile.css('a:contains("Email Directly")')
        email = alum_email_element.first['href'].split(':').last
        profile_content[email] = project_links
        sleep(5)
      end
    end
  end
end
