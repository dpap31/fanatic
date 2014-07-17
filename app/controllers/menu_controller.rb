class MenuController < ApplicationController
  helper_method :img_finder

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
  
  private
  def img_finder(arr_location)
    if @headlines_top.slice(arr_location)['images'].second['url']
          @headlines_top.slice(arr_location)['images'].second['url']
    else 
      @headlines_top.slice(arr_location)['images'].first['url']
  end
end
end
