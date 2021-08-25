require 'open-uri'
require 'nokogiri'
require 'parallel'

class LinkChecker
  class << self
    def retrieve_broken_profiles(project_links) # find all broken project links
      links = project_links.values.flatten
      sanitized_links = remove_whitespace(links)
      
      check1 = check_links(sanitized_links)
      check2 = check_links(sanitized_links)

      broken_links = check1 & check2 # Double check to account for slow heroku links
    end

    def check_links(links)
      exceptions = [OpenURI::HTTPError, Errno::ECONNREFUSED, Errno::ENOENT]
      broken_links = []
      Parallel.each(links, in_threads: 5) do |link|
      # links.each do |link|
        begin
          retries ||= 0
          Nokogiri::HTML(URI.open(link))
        rescue SocketError # TODO: Why does this not work when included in exceptions array? 
          broken_links << link
        rescue *exceptions => e
          if e.message == "308 Permanent Redirect" 
            link.gsub!('http', 'https')
            sleep(1)
            retry if (retries += 1) <= 1
          end
          broken_links << link
        end
      end
      broken_links
    end

    def remove_whitespace(links)
      links.map do |link|
        link.strip
      end
    end
  end
end