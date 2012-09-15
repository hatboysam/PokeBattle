# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PokeBattle::Application.initialize!

PokeBattle::Application.configure do
	config.assets.paths << "#{Rails.root}/app/assets/fonts"
end
