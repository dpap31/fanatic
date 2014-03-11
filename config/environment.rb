# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
FanaticV2::Application.initialize!

Sunspot::Rails::Server.new.start
at_exit do
Sunspot::Rails::Server.new.stop
end