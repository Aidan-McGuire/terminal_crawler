require './spec/spec_helper'
require './lib/terminal_crawler'

RSpec.describe TerminalCrawler do
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
      expect(content.count).to eq(200)
      expect(content["bendelonlee@gmail.com"]).to eq([
        "https://glass-planner-frontend-git-demo-bendelonlee.vercel.app/",
        "https://thirsty-plants.herokuapp.com",
        "http://sweater-weather-1.surge.sh",
        "https://book-club-project.herokuapp.com"
        ])
    end
  end
end