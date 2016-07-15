require 'sinatra/base'

module WorkForwardNola
  # WFN app
  class App < Sinatra::Base
    register Mustache::Sinatra
    require './views/layout'

    dir = File.dirname(File.expand_path(__FILE__))

    set :mustache,
        namespace: App,
        templates: "#{dir}/templates",
        views: "#{dir}/views"

    get '/' do
      mustache :index
    end
  end
end
