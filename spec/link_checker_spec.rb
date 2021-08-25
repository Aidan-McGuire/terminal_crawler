require './spec/spec_helper'
require './lib/link_checker'
require 'json'

RSpec.describe LinkChecker do
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
      
      expect(LinkChecker.check_links(links).sort).to eq([
        "https://whosthatpokemongame.netlify.app/game", "https://ecosystem.theorem.local:3300/",
        "https://shrouded-hamlet-60350.herokuapp.com/#/", "https://dream-home-cap.herokuapp.com/",
        "https://monstronomicon.herokuapp.com/", "https://rancid-tomatillos-lm-kd.herokuapp.com/",
        "https://penpost-web.vercel.app/", "https://carryokay.netlify.app/songbook",
        "https://ancient-ridge-85691.herokuapp.com"
      ].sort)
    end
  end

  context 'remove_whitespace(links)' do
    it 'removes extra whitespace' do
      poorly_formatted_links = [" https://astro-clash.surge.sh/", " https://astro-clash.surge.sh/  ", "https://ancient-ridge-85691.herokuapp.com"]

      expect(LinkChecker.remove_whitespace(poorly_formatted_links)).to eq(["https://astro-clash.surge.sh/", "https://astro-clash.surge.sh/", "https://ancient-ridge-85691.herokuapp.com"])
    end
  end
end

