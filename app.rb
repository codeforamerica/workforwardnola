require 'sinatra/base'
require 'sinatra/sequel'
require 'mustache'
require 'dotenv'

module WorkForwardNola
  # WFN app
  class App < Sinatra::Base
    Dotenv.load

    register Sinatra::SequelExtension
    configure do
      set :database, ENV['DATABASE_URL']
    end

    # check for un-run migrations
    if ENV['RACK_ENV'].eql? 'development'
      Sequel.extension :migration
      Sequel::Migrator.check_current(database, 'db/migrations')
    end

    register Mustache::Sinatra
    require './views/layout'

    dir = File.dirname(File.expand_path(__FILE__))

    set :mustache,
        namespace: WorkForwardNola,
        templates: "#{dir}/templates",
        views: "#{dir}/views"

    before do
      response.headers['Cache-Control'] = 'public, max-age=36000'
    end

    get '/' do
      @title = 'Work Forward NOLA'
      mustache :index
    end

    post '/careers' do
      # TODO require answers to all questions
      @quiz_answers = params       # params hash has answers
      mustache :careers
    end

    get '/careers' do
      @title = 'Career Results'
      mustache :careers
    end

    get '/assessment' do
      @title = 'Assessment'
      mustache :assessment
    end

    get '/manage' do
      @title = 'Manage Content'
      mustache :manage
    end
  end
end
