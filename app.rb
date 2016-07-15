require 'sinatra/base'

module WorkForwardNola
  # WFN app
  class App < Sinatra::Base
    register Mustache::Sinatra
    require './views/layout'

    dir = File.dirname(File.expand_path(__FILE__))

    set :mustache,
        namespace: WorkForwardNola,
        templates: "#{dir}/templates",
        views: "#{dir}/views"

    get '/' do
      @title = 'Work Forward NOLA'
      mustache :index
    end

    # yes, this is lazy and not really correct but waiting until we have
    # more specific requirements
    get '/*' do
      puts params.to_s
      @title = 'Assessment'
      mustache params[:splat].first.to_sym
    end
  end
end
