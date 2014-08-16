class Headline	
    #Global variables for espn
    @@base_url = "http://api.espn.com/v1/sports/"
    @@params = {:disable => "audio,categories,keywords,mobileStory,related", :limit => 10, :apikey => ENV["ESPN_API_key"]}

	#class method that calls to the espn API
   def self.api_call(base, params, path)
	  #Create URl and Query
	  uri = URI(base + path)
	  uri.query = URI.encode_www_form(params) 
	  #Start request
	  request = Net::HTTP::Get.new(uri)
	  response = Net::HTTP.start(uri.hostname, uri.port) { |http| 
	    http.request(request)}
	  #Parse response
	  hash = JSON.parse(response.body)
	  #Capture headlines node
	  headlines_hash = hash.fetch('headlines')
    end

	def self.top
		params = {:disable => "audio,categories,keywords,mobileStory,related", :limit => 5, :apikey => ENV["ESPN_API_key"]}
		path = "/news/headlines/top/"
		api_call(@@base_url, params, path)
	end

	def self.nba
		path = "/basketball/nba/news/headlines/top/"
	    api_call(@@base_url, @@params, path)
	end
	def self.mlb
		path = "/baseball/mlb/news/headlines/top/"
		api_call(@@base_url, @@params, path)
	end
	def self.nfl
		path = "/football/nfl/news/headlines/top/"
		api_call(@@base_url, @@params, path)
	end
	def self.nhl	
		path = "/hockey/nhl/news/headlines/top/"
		api_call(@@base_url, @@params, path)
	end
end
