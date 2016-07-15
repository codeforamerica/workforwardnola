require 'rubygems'
require 'bundler'

Bundler.require

require './app'

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'assets/javascript'
  environment.append_path 'assets/style'
  environment.append_path 'assets/images'

  environment.js_compressor  = :uglify
  environment.css_compressor = :scss
  # AutoprefixerRails.install(environment)
  run environment
end

run WorkForwardNola::App.new
