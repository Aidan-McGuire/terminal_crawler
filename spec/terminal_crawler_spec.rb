require './spec/spec_helper'
require './lib/terminal_crawler'

RSpec.describe TerminalCrawler, :vcr do
  context 'retrieve profile links' do
    it 'return an array of links to all alumni profiles' do
      links = TerminalCrawler.retrieve_profile_links
      expect(links).to be_an Array
      expect(links.count).to eq(121)
      expect(links.first).to eq('/alumni/675-ben-lee')
    end
  end

  context 'retrieve profile_content' do
    it 'return an array of links to all alumni profiles' do
      content = TerminalCrawler.retrieve_profile_content
      expect(content).to be_a Hash
      expect(content["bendelonlee@gmail.com"]).to eq([
        "https://glass-planner-frontend-git-demo-bendelonlee.vercel.app/",
        "https://thirsty-plants.herokuapp.com",
        "http://sweater-weather-1.surge.sh",
        "https://book-club-project.herokuapp.com"
        ])
      expect(content["aidanmcguire211@gmail.com"]).to eq([
        "https://headtotoe.surge.sh/"
        ])
    end
  end

  context 'retrieve broken project links' do
    it 'returns all broken links with associated email addresses' do
      broken_links = TerminalCrawler.retrieve_broken_profiles

      expect(broken_links.count.zero?).to eq(false)
    end
  end

  context 'add_protocol' do
    it 'appends http to beginning of url if protocol not present' do
      tricky_links = %w["chesspedition.herokuapp.com" "leahlamarr.com" "http://sweater-weather-1.surge.sh" "https://book-club-project.herokuapp.com"]

      expect(TerminalCrawler.add_protocol(tricky_links)).to eq(["http://chesspedition.herokuapp.com", "http://leahlamarr.com", "http://sweater-weather-1.surge.sh", "https://book-club-project.herokuapp.com"])
    end
  end
end