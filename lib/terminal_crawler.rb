require 'open-uri'
require 'nokogiri'
require 'parallel'
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

    def retrieve_profile_content(profile_links) # collect project links from each profile
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

    def retrieve_broken_profiles(project_links) # find all broken project links
      links = project_links.values.flatten
      sanitized_links = sanitize(links)
      
      check1 = check_links(sanitized_links)
      check2 = check_links(sanitized_links)
      
      broken_links = check1 & check2
    end

    def check_links(links)
      exceptions = [OpenURI::HTTPError, Errno::ECONNREFUSED, Errno::ENOENT]
      broken_profiles = []
      Parallel.each(links, in_threads: 5) do |link|
      # links.each do |link|
        begin
          retries ||= 0
          Nokogiri::HTML(URI.open(link))
        rescue SocketError
          broken_profiles << link
        rescue *exceptions => e
          if e.message == "308 Permanent Redirect" 
            link.gsub!('http', 'https')
            sleep(1)
            retry if (retries += 1) <= 1
          end
          broken_profiles << link
        end
      end
      broken_profiles
    end

    def sanitize(links)
      links.map do |link|
        link.strip
      end
    end
  end
end
