require 'rubygems'
require 'bundler'

Bundler.require

require './app'

map '/public/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'assets/javascript'
  environment.append_path 'assets/style'
  environment.append_path 'assets/images'

  if ENV['RACK_ENV'].eql? 'production'
    environment.js_compressor  = :uglify
    environment.css_compressor = :scss
  end
  
  run environment
end

run WorkForwardNola::App.new
