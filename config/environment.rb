require 'bundler/setup'
Bundler.require

require 'yaml'
require 'active_record'

env = ENV['RACK_ENV'] || 'development'

db_config = YAML.load_file('config/database.yml')
ActiveRecord::Base.establish_connection(db_config[env])

# Log SQL en consola (muy útil)
ActiveRecord::Base.logger = Logger.new(STDOUT)

Dir[File.join(__dir__, '..', 'domain', '**', '*.rb')].each do |file|
  require file
end

Dir[File.join(__dir__, '..', 'infrastructure', '**', '*.rb')].each do |file|
  require file
end