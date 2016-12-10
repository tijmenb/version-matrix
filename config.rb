require 'sinatra'
require 'json'
require 'typhoeus'

require_relative './lib/ruby_versions'
require_relative './lib/gem_versions'

get '/' do
  content_type :json
  JSON.dump(message: "Hello world!")
end

get '/ruby-versions' do
  content_type :json
  result = RubyVersions.new(Array[params[:repos]].flatten).as_json
  JSON.pretty_generate(result)
end

get '/gem-versions' do
  content_type :json
  result = GemVersions.new(Array[params[:repos]].flatten, Array[params[:gems]].flatten).as_json
  JSON.pretty_generate(result)
end
