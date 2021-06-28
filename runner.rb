require './lib/terminal_crawler'

crawler = TerminalCrawler.new
p "Crawling... this may take a while..."
broken_links = crawler.get_profiles_with_bad_links
count = broken_links.count
p "#{count} broken links found."
p "#{broken_links}"
