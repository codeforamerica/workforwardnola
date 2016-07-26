task :app do
  require './app'
end

namespace :db do
  require 'sequel'
  Sequel.extension :migration
  ENV['RACK_ENV'] = 'rake'

  desc 'Run DB migrations'
  task :migrate => :app do
   Sequel::Migrator.apply(WorkForwardNola::App.database, 'db/migrations')
  end

  desc 'Rollback migration'
  task :rollback => :app do
    database = WorkForwardNola::App.database
    version  = (row = database[:schema_info].first) ? row[:version] : nil
    Sequel::Migrator.apply(database, 'db/migrations', version - 1)
  end

  desc 'Dump the database schema'
  task :dump => :app do
    database = WorkForwardNola::App.database

    `sequel -d #{database.url} > db/schema.rb`
    `pg_dump --schema-only #{database.url} > db/schema.sql`
  end

  desc 'Seed DB'
  task :seed => :app do
    require 'sequel/extensions/seed'
    Sequel.extension :seed
    Sequel::Seeder.apply(WorkForwardNola::App.database, 'db')
  end

  desc 'Reset DB (delete all data)'
  task :reset => :app do
    database = WorkForwardNola::App.database
    Sequel::Migrator.run(database, 'db/migrations', :target => 0)
    Sequel::Migrator.run(database, 'db/migrations')
    database.run 'delete from schema_seeds'
  end

  desc 'Migrate & seed DB all in one'
  task :setup => :app do
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
  end
end