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
  # This helper method counts the number of images being returned by the ESPN API
  # for each headline and presents the highest quality image for the carousel
  def img_finder(arr_location)
    images = []
    headline_img = @headlines_top.slice(arr_location)['images'].each do |image|
      images << image['url']
    end
  if images.length == 1
    images[0]
  else
    images[1]
  end
end
end
