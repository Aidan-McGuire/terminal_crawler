require './spec/spec_helper'
require './lib/terminal_crawler'
require 'json'

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

  context 'check links' do
    it 'returns broken project links' do
      links = [
        "http://chesspedition.herokuapp.com", "http://leahlamarr.com", 
        "http://sweater-weather-1.surge.sh", "https://book-club-project.herokuapp.com", 
        "https://sweater-weather-2102.herokuapp.com/", "http://mixdup.vercel.app/",
        "https://whosthatpokemongame.netlify.app/game", "https://ecosystem.theorem.local:3300/",
        "https://shrouded-hamlet-60350.herokuapp.com/#/", "https://dream-home-cap.herokuapp.com/",
        "https://monstronomicon.herokuapp.com/", "https://rancid-tomatillos-lm-kd.herokuapp.com/",
        "https://penpost-web.vercel.app/", "https://carryokay.netlify.app/songbook",
        "https://ancient-ridge-85691.herokuapp.com"
      ]
      
      expect(TerminalCrawler.check_links(links).sort).to eq([
        "https://whosthatpokemongame.netlify.app/game", "https://ecosystem.theorem.local:3300/",
        "https://shrouded-hamlet-60350.herokuapp.com/#/", "https://dream-home-cap.herokuapp.com/",
        "https://monstronomicon.herokuapp.com/", "https://rancid-tomatillos-lm-kd.herokuapp.com/",
        "https://penpost-web.vercel.app/", "https://carryokay.netlify.app/songbook",
        "https://ancient-ridge-85691.herokuapp.com"
      ].sort)
    end
  end

  context 'sanitize(links)' do
    it 'removes extra whitespace' do
      poorly_formatted_links = [" https://astro-clash.surge.sh/", " https://astro-clash.surge.sh/  ", "https://ancient-ridge-85691.herokuapp.com"]

      expect(TerminalCrawler.sanitize(poorly_formatted_links)).to eq(["https://astro-clash.surge.sh/", "https://astro-clash.surge.sh/", "https://ancient-ridge-85691.herokuapp.com"])
    end
  end

  context 'retrieve_emails' do
    it 'matches broken links with owners email' do
      broken_links = ["https://whosthatpokemongame.netlify.app/game", "https://ecosystem.theorem.local:3300/", "http://career-day-fe.herokuapp.com/"]
      profile_content =  {
      "marchcorbin@gmail.com":
      [
        "https://hpspellbook.netlify.app",
        "https://whosthatpokemongame.netlify.app/game",
        "http://career-day-fe.herokuapp.com/"
      ],
      "mlynch5187@gmail.com":
      [
        "https://roots-interface.herokuapp.com/",
        "https://grow-ops.herokuapp.com/",
        "https://secret-headland-45032.herokuapp.com/"
      ],
      "greysonelkins@gmail.com":
      [
        "http://mixdup.vercel.app/",
        "https://ecosystem.theorem.local:3300/",
        "https://feralsuits.com",
        "https://roastedtomahtoes.herokuapp.com/"
      ]}

      expected = {"marchcorbin@gmail.com": ["https://whosthatpokemongame.netlify.app/game", "http://career-day-fe.herokuapp.com/"], "greysonelkins@gmail.com": ["https://ecosystem.theorem.local:3300/"]}

      expect(TerminalCrawler.retrieve_emails(broken_links, profile_content)).to eq(expected)
    end
  end
end

