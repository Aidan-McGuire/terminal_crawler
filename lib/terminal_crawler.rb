require 'open-uri'
require 'nokogiri'
require 'parallel'

class TerminalCrawler
  @tricky_links = %w["chesspedition.herokuapp.com" "leahlamarr.com" "http://course-chart-ap.vercel.app/" "http://mixdup.vercel.app/"]
  @example = {"bendelonlee@gmail.com"=>
  ["https://glass-planner-frontend-git-demo-bendelonlee.vercel.app/",
   "https://thirsty-plants.herokuapp.com",
   "http://sweater-weather-1.surge.sh",
   "https://book-club-project.herokuapp.com"],
 "masonrf1@gmail.com"=>["https://peaceful-cliffs-30422.herokuapp.com/"],
 "paul.h.schlattmann@gmail.com"=>["https://abalone-staging.herokuapp.com/", "https://tripedia-fe.herokuapp.com/"],
 "mschneider247@gmail.com"=>
  ["https://www.youtube.com/watch?v=OcsrT65ifnE&feature=youtu.be%3Fvq%3Dhd1080",
   "https://mschneider247.github.io/swapi-trivia/#/",
   "https://space-farmer.herokuapp.com/"],
 "vpa456@gmail.com"=>
  ["https://pokemon-tcg-db.herokuapp.com/", "https://dimebags-delivery-full.web.app/", "http://vpabraham.com"],
 "noah.gibson99@gmail.com"=>["timberlineincsantafe.com", "https://nasa-photo.herokuapp.com/"],
 "allisonjw01@gmail.com"=>
  ["https://fe-palette-of-colors-picker.herokuapp.com/",
   "https://bradybridges.github.io/jeopardy/",
   "http://ridgecreekplumbing.com/"],
 "jessiethanh.02@gmail.com"=>["https://rickandmorty-pi.vercel.app/", "https://movie-tracker.vercel.app/"],
 "colin.koga@gmail.com"=>[],
 "benfox1216@gmail.com"=>["https://monster-shop-group.herokuapp.com/"],
 "atki1080@gmail.com"=>["https://monster-shop-dreamteam.herokuapp.com/"],
 "fredrondina96@gmail.com"=>["https://knead-recipes.herokuapp.com/", "https://youtu.be/5tSq6kRwoKs"],
 "campryan@comcast.net"=>["https://crime-time.herokuapp.com/"],
 "jcorbin2290@gmail.com"=>["https://www.teamsnap.com/resources/return-to-sports"],
 "tyler.tomlinson.resume@gmail.com"=>
  ["https://adopt-dont-shop-paired-tt-sf.herokuapp.com/", "https://www.youtube.com/watch?v=5tSq6kRwoKs"],
 "niv3kmcg@gmail.com"=>
  ["https://community-compose.herokuapp.com/",
   "https://mcgrevey-lynch-petopia.herokuapp.com/",
   "https://km-sweater-weather-api.herokuapp.com/api/v1/forecast?location=denver%2Cc..."],
 "ed.dev.mon@gmail.com"=>["https://rancid-tomatillos-web-v7ekia46ga-uc.a.run.app/", "beta.rerent.co"],
 "cgaddis36@gmail.com"=>["https://gift-of-gab-deployed.herokuapp.com/", "https://polar-caverns-76159.herokuapp.com/"],
 "josephhaefling@protonmail.com"=>
  ["https://gift-of-gab-deployed.herokuapp.com/", "http://artistry-turing-app.herokuapp.com/api/v1/favorites"],
 "beccasteinbrecher@gmail.com"=>["https://fresh-tomatoes-ui.herokuapp.com/", "https://lono-fertility.herokuapp.com/"],
 "marchcorbin@gmail.com"=>
  ["https://hpspellbook.netlify.app",
   "https://whosthatpokemongame.netlify.app/game",
   "http://career-day-fe.herokuapp.com/"],
 "mlynch5187@gmail.com"=>
  ["https://roots-interface.herokuapp.com/",
   "https://grow-ops.herokuapp.com/",
   "https://secret-headland-45032.herokuapp.com/"],
 "greysonelkins@gmail.com"=>
  ["http://mixdup.vercel.app/",
   "https://ecosystem.theorem.local:3300/",
   "https://feralsuits.com",
   "https://roastedtomahtoes.herokuapp.com/"],
 "airashkan@yahoo.com"=>["https://weather-bop.herokuapp.com/"],
 "laleh21@yahoo.com"=>["https://roots-interface.herokuapp.com/", "https://grow-ops.herokuapp.com/"],
 "aurumvalian@gmail.com"=>[],
 "jane.greene.dev@gmail.com"=>["https://career-day-fe.herokuapp.com/", "https://podsmack.herokuapp.com/"],
 "lkriffell@gmail.com"=>
  ["https://feedthepeople.herokuapp.com/",
   "https://viewing-party-lr-cc.herokuapp.com/dashboard",
   "https://solar-garden-fe.herokuapp.com/"],
 "cdouglascorp@gmail.com"=>[],
 "ericberglund117@gmail.com"=>
  ["https://matrimania-client.herokuapp.com/", "https://ericberglund117.github.io/Rancid-Tomatillos/"],
 "arique1104@gmail.com"=>["https://dreamhome-mvp.herokuapp.com/"],
 "merrittbret9@gmail.com"=>
  ["https://the-bone-yard-fe.herokuapp.com/#/",
   "https://my-tier-ultimate.herokuapp.com/",
   "https://bm-nd-cd-genrefy.herokuapp.com/"],
 "eric_hale@comcast.net"=>[],
 "michael.e.walker.87@gmail.com"=>
  ["https://shrouded-hamlet-60350.herokuapp.com/#/", "https://saturnd-earth.github.io/se-fe/"],
 "judith.pillado@gmail.com"=>
  ["https://the-bone-yard-fe.herokuapp.com/#/", "https://monster-shop-2005.herokuapp.com/"],
 "chriscastanuela@ymail.com"=>
  ["https://chriscastanuela.github.io/chuck/", "https://chriscastanuela.github.io/cc-travel-tracker/"],
 "tim.keresey@gmail.com"=>
  ["https://bbq-finder.herokuapp.com/", "leahlamarr.com", "https://dream-home-cap.herokuapp.com/"],
 "npdarrington@icloud.com"=>["https://the-bone-yard-fe.herokuapp.com/#/", "https://bm-nd-cd-genrefy.herokuapp.com/"],
 "katyannestsauveur@gmail.com"=>["https://eras-frontend.herokuapp.com/", "https://under-the-weathe.herokuapp.com/"],
 "tdfields93@gmail.com"=>["https://matrimania-client.herokuapp.com/"],
 "kev040798@gmail.com"=>["https://packsmart.herokuapp.com/", "https://relocate-front-end-rails.herokuapp.com/"],
 "danicoleman00@gmail.com"=>
  ["https://relocate-front-end-rails.herokuapp.com/",
   "https://viewing-party-bdj.herokuapp.com/",
   "https://friends-furever.herokuapp.com/"],
 "jones.peyton949@gmail.com"=>[],
 "mdflynn34@outlook.com"=>
  ["https://www.mikeflynncodes.com/",
   "https://mdflynn.github.io/game-sleuth/",
   "http://ufomfg.herokuapp.com/",
   "https://mdflynn.github.io/rancid-tomatillos/"],
 "brian.b.liu@gmail.com"=>["https://gtfo-fe.herokuapp.com/"],
 "roberto.basulto085@gmail.com"=>
  ["https://packsmart.herokuapp.com/", "https://www.robertobasulto.com/", "https://carbon-knight.herokuapp.com/"],
 "georgesoderholm@gmail.com"=>["https://gtfo-fe.herokuapp.com/", "https://gtfo-fe.herokuapp.com/"],
 "joselopez11394@gmail.com"=>["https://relocate-front-end-rails.herokuapp.com/"],
 "caleb.j.cyphers@gmail.com"=>["https://job-quest-fe.herokuapp.com/"],
 "cromo1225@gmail.com"=>["https://silver-nest.herokuapp.com/about"],
 "ericcampbell294@gmail.com"=>["https://mainlyetcetera.github.io/rotten_tomatillos/#/"],
 "gecun289@gmail.com"=>
  ["http://course-chart-ap.vercel.app/",
   "https://alumni.turing.io/go-local-fe/herokuapp.com",
   "https://viewing-party-m3.herokuapp.com/",
   "https://sales-engine-m3.herokuapp.com"],
 "conconart.info@gmail.com"=>
  ["https://lyric-lava-conconartist.vercel.app/",
   "https://face-it-blue.vercel.app/",
   "https://rancid-tomatillos-lake.vercel.app/",
   "https://book-worm-2.herokuapp.com/"],
 "lbmerchant93@gmail.com"=>
  ["https://vueniverse.vercel.app/",
   "https://rancid-tomatillos-lm-kd.herokuapp.com/",
   "https://petstrology.vercel.app/"],
 "elsafluss@gmail.com"=>
  ["chesspedition.herokuapp.com", "http://whos-that-player.herokuapp.com/", "https://monstronomicon.herokuapp.com/"],
 "brianandrewf81@gmail.com"=>["http://ugliest-servant.surge.sh/", "https://urban-native.vercel.app/"],
 "mathao@gmail.com"=>
  ["https://acnh-collections-thaomonster.vercel.app/",
   "https://rancid-tomatillos.vercel.app/",
   "https://breath-ez.vercel.app/",
   "https://book-worm-2.herokuapp.com/home"],
 "robert.b.heathii@gmail.com"=>[],
 "yesi.meza10@gmail.com"=>
  ["https://go-local-fe.herokuapp.com/",
   "https://fun-movie-night.herokuapp.com/",
   "https://little-esty-shop.herokuapp.com/",
   "https://ghibli-movie-details.herokuapp.com/"],
 "jeff.w.kersting@gmail.com"=>
  ["https://chatter-box-qw8xpgmzm-jeffkersting.vercel.app/", "https://penpost-web.vercel.app/"],
 "coletfiscus@gmail.com"=>
  ["https://block--breaker.herokuapp.com/",
   "https://bookclubbuddy.herokuapp.com/",
   "https://gardenparty.vercel.app/",
   "https://thevueniverse.vercel.app/"],
 "jiangzho@gmail.com"=>["https://run-the-joules.herokuapp.com/", "https://stormy-bastion-67887.herokuapp.com/"],
 "adametzion90@gmail.com"=>["https://chess-quest.herokuapp.com/"],
 "cmc.cook7@gmail.com"=>
  ["https://rancid-tomatillos-ck.herokuapp.com/",
   "https://hue-pic-it-ui.web.app/",
   "https://quoted-deploy.herokuapp.com/"],
 "jmm.arellano@gmail.com"=>
  ["http://road-trip-restful-api-rails.herokuapp.com/", "https://young-island-83007.herokuapp.com/"],
 "juliaiwinski@gmail.com"=>
  ["https://flickfinder2011.herokuapp.com/#/home",
   "https://my-name-is-dad.herokuapp.com/",
   "https://tomatillos.vercel.app/"],
 "percworld@gmail.com"=>
  ["https://roccoco.herokuapp.com/", "https://setlift.herokuapp.com/", "https://quick-command.herokuapp.com/"],
 "wilddroppings@gmail.com"=>
  ["https://the-nomadic-nibbler.herokuapp.com/login",
   "https://rottenturtletales.herokuapp.com/",
   "https://my-name-is-dad.herokuapp.com/"],
 "jesus.quezada.guillen@gmail.com"=>["https://turing-mesh.herokuapp.com/"],
 "owenhallgren@gmail.com"=>["https://fetchingfriends.herokuapp.com/"],
 "wmccauley724@gmail.com"=>[],
 "trevorsuter@icloud.com"=>["jobfinderfe.herokuapp.com"],
 "jeremiahmichlitsch@yahoo.com"=>[],
 "afoucheaux@gmail.com"=>["http://inu-am-i.herokuapp.com/", "https://gallery-time.herokuapp.com/"],
 "paigevannelli@gmail.com"=>
  ["https://hitch-a-ride-app.herokuapp.com/",
   "https://foma-gallery.herokuapp.com/",
   "https://shine-deployed.herokuapp.com/"],
 "bregmanmax91@gmail.com"=>
  ["https://turing-selector.herokuapp.com/",
   "https://gallery-time.herokuapp.com/",
   "https://rancid-tomatillos-six.vercel.app/",
   "https://chatter-box-qw8xpgmzm-jeffkersting.vercel.app/"],
 "elizshahn@gmail.com"=>
  ["https://the-nomadic-nibbler.herokuapp.com/",
   "https://gearfull.herokuapp.com/",
   "https://carryokay.netlify.app/songbook"],
 "benjamin.fulton99@gmail.com"=>["https://turing-mesh.herokuapp.com"],
 "adam.j.bowers@gmail.com"=>[],
 "trevor.robi1254@gmail.com"=>
  ["https://flickfinder2011.herokuapp.com/#/home", "https://secure-gorge-18886.herokuapp.com/"],
 "megan.gonzales626@gmail.com"=>["https://turing-selector.herokuapp.com/"],
 "doug.welchons@gmail.com"=>["https://boiling-ridge-68487.herokuapp.com/"],
 "garrett.cottrell2116@gmail.com"=>["https://flickfinder2011.herokuapp.com/#/home"],
 "jaxmcguire@gmail.com"=>
  ["https://flickfinder2011.herokuapp.com/#/",
   "https://metapi-app.herokuapp.com/",
   "https://trivia-fanatics.herokuapp.com/"],
 "josharagon99@gmail.com"=>["https://josharagon.github.io/whats-cookin-starter-kit/src/index.html"],
 "marikashanahan@gmail.com"=>["https://turing-selector.herokuapp.com/"],
 "hope.gochnour@gmail.com"=>
  ["https://flickfinder2011.herokuapp.com/#/home",
   "https://relocate-front-end-rails.herokuapp.com/",
   "https://secure-gorge-18886.herokuapp.com/"],
 "cbmackintosh@outlook.com"=>["bard-buddy.herokuapp.com", "https://metapi-app.herokuapp.com/"],
 "jordanfbeck@gmail.com"=>
  ["https://turing-selector.herokuapp.com/",
   "https://boiling-ridge-68487.herokuapp.com/",
   "https://secure-harbor-78053.herokuapp.com/api/v1/forecast?location=denver,co"],
 "connorandersonlarson@gmail.com"=>["https://planet-party.herokuapp.com/", "https://jobfinderfe.herokuapp.com/"],
 "nikkipetersen.dev@gmail.com"=>
  ["https://turing-mesh.herokuapp.com/",
   "https://smash-cards-5c415.web.app/",
   "https://emojicoat-of-arms.herokuapp.com/",
   "https://rancid-tomatillos-np.herokuapp.com/"],
 "kendallhaw@gmail.com"=>
  ["https://gifty-capstone.herokuapp.com/",
   "http://scrabble-rouser.surge.sh/",
   "http://golookatatree.surge.sh/",
   "https://marcelineball.github.io/rancid-tomatillos/"],
 "ryandmiller3521@gmail.com"=>
  ["http://greedy-distance.surge.sh/", "https://ryan-d-miller.github.io/TicTacToeMod1Final/"],
 "cmeubanks@gmail.com"=>["https://walk-safe-frontend.herokuapp.com/", "http://abrasive-honey.surge.sh/"],
 "schlanjo@gmail.com"=>
  ["https://tiktaco.herokuapp.com/",
   "https://get-netflex.herokuapp.com/",
   "https://jon-schlandt.github.io/tic-tac-poe/"],
 "errabun@gmail.com"=>["https://brew-n-jokes.herokuapp.com/", "http://errm-rancid-tomatillos.surge.sh/"],
 "rachelhen92@gmail.com"=>["https://gifty-capstone.herokuapp.com/", "https://chef-indecisive.surge.sh/"],
 "keegan.oshea9@gmail.com"=>["https://vote-local-fe.herokuapp.com/", "https://sweater-weather-ko.herokuapp.com/"],
 "elliemiller66@icloud.com"=>[" https://astro-clash.surge.sh/", "http://comic-cache.herokuapp.com/"],
 "jwmecha@gmail.com"=>
  ["https://down-draft.herokuapp.com/",
   "https://joe-mecha-whether-sweater.herokuapp.com/",
   "https://joe-mecha-viewing-party.herokuapp.com",
   "https://esty-shop-bulk-discounts.herokuapp.com/merchant/9/dashboard"],
 "mistercanderson@gmail.com"=>["http://bright-bucket.surge.sh/", "https://handy-breath.surge.sh/"],
 "diana.pamelaet@gmail.com"=>["https://nameless-lowlands-35724.herokuapp.com/"],
 "ashishmalla45@gmail.com"=>
  ["https://reactionary-1.web.app/",
   "https://happy-almeida-f62824.netlify.app",
   "https://netflex-app.herokuapp.com/",
   "https://asiisii.github.io/Track-Your-Journey/"],
 "bryanhohn13@gmail.com"=>["https://walk-safe-frontend.herokuapp.com/", "https://kings-castle-app.herokuapp.com/"],
 "pmuellerleile@gmail.com"=>
  ["https://walk-safe-frontend.herokuapp.com/",
   "https://hookshot-app.herokuapp.com/",
   "https://tomatillosrancid.herokuapp.com/"],
 "aidanmcguire211@gmail.com"=>["https://headtotoe.surge.sh/"],
 "me@dustinharbaugh.com"=>
  ["http://free.games.to.play.surge.sh/", "http://serious-bridge.surge.sh", "http://rancid.tomatillos.surge.sh/"],
 "patfindley@gmail.com"=>["http://bright-bucket.surge.sh/about", "http://ranc-tomats.surge.sh/"],
 "tyson.mcnutt@gmail.com"=>["http://bright-bucket.surge.sh/", "https://forefinder.herokuapp.com/dashboard"],
 "austinmandrade@gmail.com"=>[],
 "brisagarciaglz@gmail.com"=>[],
 "riley.willow@gmail.com"=>
  ["https://the-random-genderator.surge.sh/",
   "https://headtotoe.surge.sh/",
   "http://golookatatree.surge.sh/",
   "http://errm-rancid-tomatillos.surge.sh/"],
 "zachjjohns@gmail.com"=>
  ["https://spellspotter.surge.sh/", "http://rancid.tomatillos.surge.sh/", "http://golookatatree.surge.sh/"],
 "gaelyn.cooper@gmail.com"=>
  ["https://down-draft.herokuapp.com/",
   "https://sweater-weather-2102.herokuapp.com/",
   "https://lil-e-shoppe.herokuapp.com/"],
 "shawnmcmahon17@gmail.com"=>["https://rancid-tomatillos-smbv.herokuapp.com/"],
 "calebjwittman1991@gmail.com"=>[],
 "merali4@gmail.com"=>["https://little-rails-market.herokuapp.com/", "https://powerful-cliffs-43765.herokuapp.com/"],
 "gallowaytaylor@outlook.com"=>
  ["https://rancid-tomatillos-tylrs.herokuapp.com/", "https://tylrs.github.io/overlook-hotel/"],
 "mkkrumholz@gmail.com"=>
  ["https://rocky-retreat-38535.herokuapp.com/", "https://little-shop-of-rails.herokuapp.com/"],
 "domopadula2192@gmail.com"=>["https://boiling-ridge-68487.herokuapp.com/"],
 "matt.mcvey49@gmail.com"=>
  ["https://my-hero-finder.herokuapp.com/",
   "https://rancid-tomas.herokuapp.com/",
   "https://my-name-is-dad.herokuapp.com/"]}

  class << self
    def retrieve_profile_links
      doc = Nokogiri::HTML(URI.open('https://terminal.turing.edu'))
      elements = doc.css('a:contains("See full profile")')
      profile_links = elements.map do |ele|
        ele['href']
      end
    end

    def retrieve_profile_content
      profile_content = Hash.new { |hash, key| hash[key] = [] }
      profile_links = retrieve_profile_links
      profile_links.each do |link|
        profile = Nokogiri::HTML(URI.open("https://terminal.turing.edu#{link}"))
        elements = profile.css('a:contains("Launch the App")')

        project_links = elements.map do |link|
          link['href']
        end

        alum_email_element = profile.css('a:contains("Email Directly")')
        email = alum_email_element.first['href'].split(':').last
        profile_content[email] = project_links
        sleep(3)
      end
      profile_content
    end

    def retrieve_broken_profiles
      # project_links = retrieve_profile_content
      # project_links.each do |email, links|
      links = @example.values.flatten
      check1 = check_links(links)
      check2 = check_links(links)

      broken_links = check1 & check2
      require 'pry'; binding.pry
    end

    def check_links(links)
      exceptions = [OpenURI::HTTPError, Errno::ECONNREFUSED, Errno::ENOENT]
      broken_profiles = []
      Parallel.each(links, in_threads: 5) do |link|
        begin
          Nokogiri::HTML(URI.open(link))
        rescue SocketError
          broken_profiles << link
        rescue *exceptions
          broken_profiles << link
        end
      end
      broken_profiles
    end
  end
end

