# Load the rails application
require File.expand_path('../application', __FILE__)

FACEBOOK_APP_ID = ENV["FACEBOOK_APP_ID"]

# Initialize the rails application
Dothespread::Application.initialize!
