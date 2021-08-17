require './spec/spec_helper'
require './lib/terminal_crawler'
require 'json'

RSpec.describe TerminalCrawler, :vcr do
  context 'retrieve profile links' do
    it 'returns an array of links to all alumni profiles' do
      links = TerminalCrawler.retrieve_profile_links
      expect(links).to be_an Array
      expect(links.count).to eq(121)
      expect(links.first).to eq('/alumni/675-ben-lee')
    end
  end

  context 'retrieve profile_content' do
    it 'return a hash of links to all alumni profiles with alumni emails' do
      links = [
        "/alumni/675-ben-lee", "/alumni/284-mason-france", "/alumni/328-paul-schlattmann",
        "/alumni/175-victor-abraham", "/alumni/292-noah-gibson", "/alumni/539-jessie-le-ho",
        "/alumni/683-colin-kiyoshi-koga", "/alumni/396-fred-rondina", "/alumni/849-aidan-mcguire-lester"
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

  context 'check links' do
    it 'returns broken project links' do
      links = ["http://chesspedition.herokuapp.com", "http://leahlamarr.com", "http://sweater-weather-1.surge.sh", "https://book-club-project.herokuapp.com", "https://sweater-weather-2102.herokuapp.com/"]

      expect(TerminalCrawler.check_links(links)).to eq(["https://sweater-weather-2102.herokuapp.com/"])
    end
  end

  context 'sanitize(links)' do
    it 'appends https to beginning of url if protocol not present' do
      tricky_links = ["chesspedition.herokuapp.com", "leahlamarr.com", "http://sweater-weather-1.surge.sh", "https://book-club-project.herokuapp.com", "http://sweater-weather-1.surge.sh", "https://book-club-project.herokuapp.com"]
      poorly_formatted_links = [" https://astro-clash.surge.sh/", "leahlamarr.com"]


      expect(TerminalCrawler.sanitize(tricky_links)).to eq(["https://chesspedition.herokuapp.com", "https://leahlamarr.com", "http://sweater-weather-1.surge.sh", "https://book-club-project.herokuapp.com", "http://sweater-weather-1.surge.sh", "https://book-club-project.herokuapp.com"])
      expect(TerminalCrawler.sanitize(poorly_formatted_links)).to eq(["https://astro-clash.surge.sh/", "https://leahlamarr.com"])
    end

    it 'replaces http with https' do
      links = ["http://mixdup.vercel.app/", "http://leahlamarr.com"]

      expect(TerminalCrawler.sanitize(links)).to eq(["https://mixdup.vercel.app/", "https://leahlamarr.com"])
    end

    it 'removes extra whitespace' do
      poorly_formatted_links = [" https://astro-clash.surge.sh/", "leahlamarr.com "]

      expect(TerminalCrawler.sanitize(poorly_formatted_links)).to eq(["https://astro-clash.surge.sh/", "https://leahlamarr.com"])
    end
  end
end

