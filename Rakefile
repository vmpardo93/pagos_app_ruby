require 'active_record'
require 'active_record/tasks/database_tasks'
require 'yaml'
require 'erb'
require 'logger'

ENV['RACK_ENV'] ||= 'development'


raw_config = ERB.new(File.read('config/database.yml')).result
db_configs = YAML.load(raw_config, aliases: true)
db_config = db_configs[ENV['RACK_ENV']]


ActiveRecord::Base.establish_connection(db_config)
ActiveRecord::Base.logger = Logger.new(STDOUT)


ActiveRecord::Tasks::DatabaseTasks.database_configuration = db_configs
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
    migrations_path = File.join(Dir.pwd, 'db/migrate')

    migration_context = ActiveRecord::MigrationContext.new(
      migrations_path,
      ActiveRecord::SchemaMigration
    )

    migration_context.migrate
  end


  desc "Show current version"
  task :version do
    puts ActiveRecord::Migrator.current_version
  end
end
