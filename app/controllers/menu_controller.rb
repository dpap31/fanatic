class MenuController < ApplicationController
  helper_method :img_finder

  #headlines call ESPN headlines API
  #and stores results in an instance variable to be used in the view
  def headlines
  	# @headlines_top = Headline.top
   #  @headlines_nba = Headline.nba
   #  @headlines_mlb = Headline.mlb
   #  @headlines_nhl = Headline.nhl
   #  @headlines_nfl = Headline.nfl
    @headlines_top = Rails.cache.fetch("top", expires_in: 2.hours) { Headline.top }
    @headlines_nba = Rails.cache.fetch("nba", expires_in: 2.hours) { Headline.nba }
    @headlines_mlb = Rails.cache.fetch("mlb", expires_in: 2.hours) { Headline.mlb }
    @headlines_nhl = Rails.cache.fetch("nhl", expires_in: 2.hours) { Headline.nhl }
    @headlines_nfl = Rails.cache.fetch("nfl", expires_in: 2.hours) { Headline.nfl }
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
    elsif images.length == 0
      'http://www.cootharababeefgenes.com.au/assets/placeholder-81127a71a07cd5c12cde6fc9ac9b1b6e.png'
    else
      images[1]
    end
  end
end
