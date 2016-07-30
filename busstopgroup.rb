# encoding: UTF-8

require 'json'

class BusStopGroup < Delegator
  attr_reader :bus_stops

  # TODO: Block initializer
  def initialize(arg)
    super @bus_stops

    case arg
    when BusStop
      @bus_stops = [arg]
    when Array
      @bus_stops = arg
    end
  end

  def self.get_longest_common_prefix(str1, str2)
    maxLength = [str1.length, str2.length].min

    [1..maxLength].each do |i|
      return str1.substr 0, i unless str1[i] == str2[i]
    end

    str1
  end

  def name
    bus_stops.inject(bus_stops[0].name) do |longest_name, bus_stop|
      self.class.get_longest_common_prefix longest_name, bus_stop.name
    end
  end

  def __getobj__
    @bus_stops
  end

  def __setobj__(obj)
    # Do not change object
  end

  def to_json
    {
      name: name,
      bus_stops: bus_stops
    }.to_json
  end

  def to_s
    str  = "@#{self.class}{\n"
    str += "  name: #{name}\n"
    bus_stops.each {|bus_stop| str += '  ' + bus_stop.to_s + "\n"}
    str + "}"
  end
end
