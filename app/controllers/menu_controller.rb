class MenuController < ApplicationController
  def index
  end
  
  def headlines
  	@headlines_top = Headline.top
    @headlines_nba = Headline.nba
    @headlines_mlb = Headline.mlb
    @headlines_nhl = Headline.nhl
    @headlines_nfl = Headline.nfl
    expires_in 10.minutes, public: true
  end
end
