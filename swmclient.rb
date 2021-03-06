# encoding: UTF-8

require 'rest-client'

require_relative 'busstopgroup'
require_relative 'busstopregexp'

# This is in mb-uhr?!
# BUSSTOP_REQUEST_RESULT_REGEX = %r%<div class="\w+"><div class="line">([^<]+?)</div><div class="direction">([^<]+?)</div><div class="\w+">((?:[^<]*?)|(?:<div class="borden"></div>))</div><br class="clear" /></div>%i

class SWMClient
  BASE_URL = 'http://www.stadtwerke-muenster.de/fis'
  SEARCH_QUERY_RESULT_REGEX = %r%<a class="inactive" name="efahyperlinks" href="#{BASE_URL}/(\d+?)" target="_self">(.*?)<span style="font-weight:bold;">(.+?)</span>(.*?) <span class="richtung">(?:\((.*?)\))?</span></a>%i

  def self.get_bus_stop_group(searchTerm)
    response = RestClient.get BASE_URL + '/search.php', {:params => {query: searchTerm, _: Time.now}}
    string_bus_stops = response.to_enum(:scan, SEARCH_QUERY_RESULT_REGEX).map {$&}

    bus_stops = string_bus_stops.map do |bus_stop_response|
      self.parse_bus_stop_response(bus_stop_response.force_encoding("utf-8"))
    end

    BusStopGroup.new bus_stops
  end

  private
  def self.parse_bus_stop_response(bus_stop_response)
    return nil unless bus_stop_response =~ SEARCH_QUERY_RESULT_REGEX

    id = $1
    direction = nil
    bus_stop_name = $2 + $3 + $4

    match_bus_stop_direction = $5
    direction = match_bus_stop_direction unless match_bus_stop_direction.nil?

    return BusStop.new_from_station_name id: id, name: bus_stop_name, direction: direction if BusStop.contains_station_name(bus_stop_name)

    return BusStop.new id: id, name: bus_stop_name, direction: direction
  end
end
