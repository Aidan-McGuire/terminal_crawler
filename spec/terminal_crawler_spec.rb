require './spec/spec_helper'
require './lib/terminal_crawler'

RSpec.describe TerminalCrawler, :vcr do
  context 'retrieve profile links' do
    it 'returns an array of links to all alumni profiles' do
      links = TerminalCrawler.retrieve_profile_links
      expect(links).to be_an Array
      expect(links.first).to eq('/alumni/675-ben-lee')
    end
  end

  context 'retrieve profile_content' do
    it 'return a hash of links to all alumni profiles with alumni emails' do
      links = [
        "/alumni/675-ben-lee", "/alumni/849-aidan-mcguire-lester"
        ]

      content = TerminalCrawler.retrieve_profile_content(links)

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
end

