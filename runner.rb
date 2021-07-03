require './lib/terminal_crawler'

crawler = TerminalCrawler.new
p "Crawling... this may take a while..."
profiles = crawler.get_profiles_with_bad_links
count = profiles.count
p "#{count} profiles with broken links found."
p "#{profiles}"
