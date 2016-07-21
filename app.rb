require 'sinatra/base'
require 'sinatra/sequel'

module WorkForwardNola
  # WFN app
  class App < Sinatra::Base
    configure do
      set :database, lambda {
        ENV['DATABASE_URL'] ||
        "postgres://localhost:5432/workforwardnola"
      }
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

    # yes, this is lazy and not really correct but waiting until we have
    # more specific requirements
    get '/*' do
      @title = 'Assessment'
      mustache request.path_info.delete('/').to_sym
    end
  end
end
