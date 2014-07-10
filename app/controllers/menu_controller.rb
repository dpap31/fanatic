class MenuController < ApplicationController
  def index
  end
  
  def headlines
    @headlines_nba = Headline.nba.fetch('headlines')
    @headlines_mlb = Headline.mlb
    @headlines_nhl = Headline.nhl
    @headlines_nfl = Headline.nfl

    espn = EspnRb.headlines(:api_key =>ENV["ESPN_API_key"])

    # @headlines = espn.all(:top)

    @accordion_headlines_nba = espn.nba(:top)
    @accordion_headlines_mlb = espn.mlb(:top)
    @accordion_headlines_nfl = espn.nfl(:top)
    @accordion_headlines_nhl = espn.nhl(:top)

  #if @accordion_headlines_nba.nil? ||  @accordion_headlines_mlb.nil? || @accordion_headlines_nfl.nil? || @accordion_headlines_nhl.nil?
    #redirect_to menu_path

  end
end
