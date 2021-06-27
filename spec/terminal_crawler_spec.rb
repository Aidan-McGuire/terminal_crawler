require './spec/spec_helper'
require './lib/terminal_crawler'

RSpec.describe TerminalCrawler, :vcr do
  before(:each) do
    @crawler = TerminalCrawler.new
  end

  it 'can get links to alums terminal profiles' do
    profile_links = @crawler.get_profile_links
    expect(profile_links).to be_an Array
    expect(profile_links.count).to eq(130)
    expect(profile_links.first).to be_a Mechanize::Page::Link
    expect(profile_links.first.href).to eq("/alumni/675-ben-lee")
  end
  
  it 'can find profiles with broken links' do
    profile_links = @crawler.get_profile_links
    profile = profile_links[3]
    
    actual = @crawler.check_status(profile)
    
    expect(actual).to eq([["/alumni/292-noah-gibson", "timberlineincsantafe.com"]])
  end
end