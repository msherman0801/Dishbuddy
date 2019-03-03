ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

set :database_file, "./database.yml"

require './app/controllers/application_controller'
require_all 'app'
