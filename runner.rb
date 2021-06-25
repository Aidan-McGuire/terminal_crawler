require './link_checker'

crawler = TerminalCrawler.new
links = crawler.get_links
bad = links.first(130).map do |link|
  crawler.check_status(link)
end
bad_links = bad.reject { |i| i.empty? }