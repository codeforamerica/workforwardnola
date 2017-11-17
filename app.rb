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
      enable :logging
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
    
      def worksheet
          @session ||= GoogleDrive::Session.from_service_account_key("client_secret.json")
          @spreadsheet ||= @session.spreadsheet_by_title("contact")
          @worksheet ||= @spreadsheet.worksheets.first
      end

    get '/' do
      @title = 'Work Forward NOLA'
      mustache :index
    end

    post '/careers/update' do
      data = JSON.parse(request.body.read)
      begin
        Trait.bulk_create data['traits']
        Career.bulk_create data['careers']
      rescue Sequel::Error => se
        logger.error "Sequel::Error: #{se}"
        logger.error se.backtrace.join("\n")
        return {
          result: 'error',
          text: "There was an error saving the new data: #{se.to_s.split('DETAIL').first}\n" +
                'Please make sure your data is in the correct format or contact an administrator.'
        }.to_json
      end

      {
        result: 'success',
        text: "Success! #{Trait.count} traits and #{Career.count} careers were saved."
      }.to_json
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
      
  
   
    post '/contact' do

      new_row = [params["first_name"], params["last_name"],params["best_way"], params["referral"], params["neighborhood"], params["young_adult"], params["veteran"], params["no_transportation"],
      params["homeless"], params["no_drivers_license"], params["no_state_id"], params["disabled"], params["childcare"], params["criminal"], params["previously_incarcerated"], params["using_drugs"], params["none"]]
      begin
        worksheet.insert_rows(worksheet.num_rows + 1, [new_row])
        worksheet.save
        mustache :jobsystem
      end

    end
  

    get '/opportunity-center-info' do
      @title = 'Opportunity Center Information'
      mustache :opp_center_info
    end

    post '/careers/email' do
      body = JSON.parse(request.body.read)

      @career_ids = body['career_ids']
      email_body = mustache :careers_email, layout: false

      Pony.mail({
        to: body['recipient'],
        subject: 'Your NOLA Career Results',
        html_body: email_body,
        via: :smtp,
        via_options: {
          address:              ENV['EMAIL_SERVER'],
          port:                 ENV['EMAIL_PORT'],
          enable_starttls_auto: true,
          user_name:            ENV['EMAIL_USER'],
          password:             ENV['EMAIL_PASSWORD'],
          authentication:       :plain, # :plain, :login, :cram_md5, no auth by default
          domain:               ENV['EMAIL_DOMAIN'] # the HELO domain provided by the client to the server
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
