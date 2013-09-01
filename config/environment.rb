# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
BabyRecord::Application.initialize!

Time::DATE_FORMATS[:time] = "%I:%M %p"
