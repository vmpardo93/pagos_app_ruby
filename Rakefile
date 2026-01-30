require 'active_record'
require 'yaml'
require 'logger'
require 'rake'

ENV['RACK_ENV'] ||= 'development'

require 'erb'

raw = ERB.new(File.read('config/database.yml')).result
require 'erb'

db_config = YAML.load(
  ERB.new(File.read('config/database.yml')).result,
  aliases: true
)[ENV['RACK_ENV']]


ActiveRecord::Base.establish_connection(db_config)
ActiveRecord::Base.logger = Logger.new(STDOUT)

namespace :db do
  desc "Create database"
  task :create do
    ActiveRecord::Base.connection
    ActiveRecord::Base.connection.create_database(db_config['database'])
  rescue ActiveRecord::StatementInvalid
    puts "Database already exists"
  end

  desc "Migrate database"
  task :migrate do
    ActiveRecord::MigrationContext.new(
      'db/migrate',
      ActiveRecord::SchemaMigration
    ).migrate
  end

  desc "Show current version"
  task :version do
    puts ActiveRecord::SchemaMigration.maximum(:version) || 0
  end
end
