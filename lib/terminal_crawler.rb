require 'open-uri'
require 'nokogiri'

url = 'https://terminal.turing.edu'
see_profile_text = "\n                See full profile\n                \n"
launch_app_text = "\n          Launch the App\n"
email_text = "\n        Email Directly\n"

doc = Nokogiri::HTML(URI.open(url))
elements = doc.css('a:contains("See full profile")')
profile_links = elements.map do |ele|
  ele['href']
end
require 'pry'; binding.pry
