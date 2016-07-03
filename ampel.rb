require 'sinatra'

require_relative 'busstop'
require_relative 'swmclient'

get '/search/:searchTerm' do
  searchTerm = params[:searchTerm]

  bus_stop_group = SWMClient.get_bus_stop_group(searchTerm)

  "User is looking for #{searchTerm} at #{Time.now}.<br/>
  The bus stop group is <pre>#{bus_stop_group}</pre>"
end
