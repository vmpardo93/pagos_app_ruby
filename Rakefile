require 'active_record'
require 'yaml'
require 'logger'

ENV['RACK_ENV'] ||= 'development'

db_config = YAML.load_file('config/database.yml')[ENV['RACK_ENV']]

ActiveRecord::Base.establish_connection(db_config)
ActiveRecord::Base.logger = Logger.new(STDOUT)

require 'active_record/tasks/database_tasks'

ActiveRecord::Tasks::DatabaseTasks.database_configuration = {
  ENV['RACK_ENV'] => db_config
}
ActiveRecord::Tasks::DatabaseTasks.db_dir = 'db'
ActiveRecord::Tasks::DatabaseTasks.env = ENV['RACK_ENV']
ActiveRecord::Tasks::DatabaseTasks.root = Dir.pwd

namespace :db do
  desc "Create database"
  task :create do
    ActiveRecord::Tasks::DatabaseTasks.create
  end

  desc "Migrate database"
  task :migrate do
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate('db/migrate')
  end

  desc "Show current version"
  task :version do
    puts ActiveRecord::Migrator.current_version
  end
end
