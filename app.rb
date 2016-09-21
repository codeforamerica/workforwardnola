require 'sinatra/base'
require 'sinatra/sequel'
require 'mustache'
require 'dotenv'
require 'pony'

module WorkForwardNola
  # WFN app
  class App < Sinatra::Base
    Dotenv.load

    register Sinatra::SequelExtension

    ENV['DATABASE_URL'] ||= "postgres://#{ENV['RDS_USERNAME']}:#{ENV['RDS_PASSWORD']}@#{ENV['RDS_HOSTNAME']}:#{ENV['RDS_PORT']}/#{ENV['RDS_DB_NAME']}"

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
      { result: "success!! there are #{Trait.count} traits \
      and #{Career.count} careers." }.to_json
    end

    post '/careers' do
      # params hash has answers
      @quiz_answers = params
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

    post '/careers/email' do
      body = JSON.parse(request.body.read)

      @career_ids = body['career_ids']
      email_body = mustache :careers_email, layout: false

      Pony.mail({
        :to => body['recipient'],
        :subject => 'Your NOLA Career Results',
        :html_body => email_body,
        :via => :smtp,
        :via_options => {
          :address              => ENV['EMAIL_SERVER'],
          :port                 => ENV['EMAIL_PORT'],
          :enable_starttls_auto => true,
          :user_name            => ENV['EMAIL_USER'],
          :password             => ENV['EMAIL_PASSWORD'],
          :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
          :domain               => ENV['EMAIL_DOMAIN'] # the HELO domain provided by the client to the server
        }
      })

      status 200
      body.to_json # we have to return some JSON so that the callback gets executed in JS
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
