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

    helpers do
      def protected!
        return if authorized?
        headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
        halt 401, "Not authorized\n"
      end

      def authorized?
        @auth ||= Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [ENV['ADMIN_USER'], ENV['ADMIN_PASSWORD']]
      end
    end

    before do
      response.headers['Cache-Control'] = 'public, max-age=36000'

      # this is convoluted, but I have to require this after setting up the DB
      require './models/trait'
      require './models/career'
    end

    get '/' do
      @title = 'Work Forward NOLA'
      mustache :index
    end

    post '/careers/update' do
      data = JSON.parse(request.body.read)
      Trait.bulk_create data['traits']
      Career.bulk_create data['careers']
      # TODO: meaningful success/failure responses
      # or better handling of empty/malformed columns
      {result: "success!! there are #{Trait.count} traits \
      and #{Career.count} careers."}.to_json
    end

    post '/careers' do
      @quiz_answers = params       # params hash has answers
      @title = 'Career Results'
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

    get '/jobsystem' do
      @title = 'Job System'
      mustache :jobsystem
    end

    get '/admin' do
      redirect to('/manage')
    end

    get '/manage' do
      protected!
      @title = 'Manage Content'
      mustache :manage
    end
  end
end
