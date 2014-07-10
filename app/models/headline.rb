class Headline
def self.nba
base_url = "http://api.espn.com/v1/sports/basketball/nba/news/headlines/top/"
params = { :disable => "audio,categories,keywords,mobileStory,related", :limit => 10, :apikey => ENV["ESPN_API_key"]}

uri = URI(base_url)
uri.query = URI.encode_www_form(params) 

request = Net::HTTP::Get.new(uri)
response = Net::HTTP.start(uri.hostname, uri.port) { |http| 
	http.request(request)
}

headlines_hash = JSON.parse(response.body)
 end
end

 #  include HTTParty
 #  base_uri 'http://api.espn.com/v1/sports'

 #  def self.all
 #  	params = { :disable => "audio,categories,keywords,mobileStory,related", :limit => 10, :apikey => ENV["ESPN_API_key"] }
	# params.to_param
 #    response["headlines"]
 #    response = Headline.get('/news/headlines/top',
 #      :query => { :disable => "audio,categories,keywords,mobileStory,related", :limit => 10, :apikey => ENV["ESPN_API_key"] })
 #    response["headlines"]
 #  end
 
 # # def self.basketball
 # #    response = Headline.get('/sports/basketball/nba',
 # #      :query => { :apikey => ENV["ESPN_API_key"], :enable => "title,links" })
 # #    response["nba_headlines"]
 # #  end

# end