require 'json'
json = ActiveSupport::JSON.decode(File.read('db/teamdata.json'))
json.each do |a|
Team.create!(espn_uid: a['uid'], name: a['name'], abbreviation:
 a['abbreviation'], location: a['location'],) 
end