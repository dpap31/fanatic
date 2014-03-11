class MenuController < ApplicationController
  def index
	espn = EspnRb.headlines(:api_key =>ENV["ESPN_API_key"])
    @headlines = espn.all(:top)
    @accordion_headlines_nba = espn.nba(:top)
    @accordion_headlines_mlb = espn.mlb(:top)
    @accordion_headlines_nfl = espn.nfl(:top)
    @accordion_headlines_nhl = espn.nhl(:top)
  end
end
