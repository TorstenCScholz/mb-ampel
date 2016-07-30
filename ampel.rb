# encoding: UTF-8

require 'sinatra'
require 'json'

require_relative 'busstop'
require_relative 'busstopregexp'
require_relative 'swmclient'

before do
  content_type 'application/json', charset: 'utf-8'
end

get '/search/:searchTerm' do
  searchTerm = params[:searchTerm]

  bus_stop_group = SWMClient.get_bus_stop_group(searchTerm)

  bus_stop_group.to_json
end

get '/regexpStructure' do
  regexp = BusStopRegexp.new SWMClient::BASE_URL

  regexp.to_json
end
