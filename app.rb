require 'sinatra/base'
require 'sinatra/sequel'
require 'mustache'
require 'dotenv'
require 'pony'
require './emailprovider.rb'

module WorkForwardNola
  # WFN app
  class App < Sinatra::Base
    attr_reader :emailer
    
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
      @session ||= GoogleDrive::Session.from_service_account_key('client_secret.json')
      @spreadsheet ||= @session.spreadsheet_by_title('contact')
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
      new_row = [params['first_name'], params['last_name'], params['best_way'],
                 params['email_submission'], params['phone_submission'],
                 params['text_submission'],  params['referral'],
                 params['neighborhood'], params['young_adult'],
                 params['veteran'], params['no_transportation'],
                 params['homeless'], params['no_drivers_license'],
                 params['no_state_id'], params['disabled'], params['childcare'],
                 params['criminal'], params['previously_incarcerated'],
                 params['using_drugs'], params['none'], params['resume']]
      begin
        worksheet.insert_rows(worksheet.num_rows + 1, [new_row])
        worksheet.save
        mustache :jobsystem
      end
      if params['email_submission'] != '' then
        send_job_form_email(params['email_submission'], 'ccemail_here', params)
      end
      redirect to ('/') # where to redirect after submission?
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
    
    private
    
    def send_job_form_email(recipient, oppCenter, params)
      # Specify a configuration set. To use a configuration
      # set, uncomment the next line and send it to the proper method
      #   configsetname = "ConfigSet"
      subject = 'New Submission: Opportunity Center Sign Up'
  
      htmlbody =
        "<strong>
        Thank you for registering in the New Orleans job system.
        </strong>
        <p>We are evaluating which opportunity center can best meet your
        needs or barriers.
        You'll get a reply by email of who to contact.
        If you do not have email, someone will call you.</p>
        <br>Here are your submissions: </br>
        <br>First Name: #{params['first_name']}</br>
        <br>Last Name: #{params['last_name']}</br>
        <br>Best way to contact: #{params['best_way']}</br>
        <br>Email: #{params['email_submission']}</br>
        <br>Phone: #{params['phone_submission']}</br>
        <br>Text: #{params['text_submission']}</br>
        <br>Referred by: #{params['referral']}</br>
        <br>Which neighborhood:  #{params['neighborhood']}</br>
        <br>Are you a young adult? #{params['young_adult']}</br>
        <br>Are you a veteran?  #{params['veteran']}</br>
        <br>Do you have little access to transportaion?  
        #{params['no_transportation']}</br>
        <br>Are you homeless or staying with someone temporarily?  
        #{params['homeless']}</br>
        <br>I dont have a drivers license. #{params['no_drivers_license']}</br>
        <br>I dont have a state-issued I.D. #{params['no_state_id']}</br>
        <br>I am disabled. #{params['disabled']}</br>
        <br>I need childcare. #{params['childcare']}</br>
        <br>I have an open criminal charge. #{params['criminal']}</br>
        <br>I have been previously incarcerated.
        #{params['previously_incarcerated']}</br>
        <br>I am using drugs and want to get help. #{params['using_drugs']}</br>
        <br>None of the above. #{params['none']}</br>"
  
  
      # The email body for recipients with non-HTML email clients.
      textbody =  "Thank you for registering in the New Orleans job system.
                  We are evaluating which opportunity center can best meet your
                  needs or barriers. You'll get a reply by email of who to
                  contact. If you do not have email, someone will call you."
      emailer = EmailProvider.emailer
      sender = EmailProvider.sender
      owner = EmailProvider.owner
      puts self.emailer.inspect
      emailer.send_email(sender, recipient, subject, textbody, htmlbody,
                         oppCenter, owner)
    end
  end
end
