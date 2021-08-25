require './spec/spec_helper'
require './lib/alum_emailer'

RSpec.describe AlumEmailer do
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

      expect(AlumEmailer.retrieve_emails(broken_links, profile_content)).to eq(expected)
    end
  end
end