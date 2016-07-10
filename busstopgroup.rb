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

  def __getobj__
    @bus_stops
  end

  def __setobj__(obj)
    # Do not change object
  end

  def to_s
    str  = "@#{self.class}{\n"
    bus_stops.each {|bus_stop| str += '  ' + bus_stop.to_s + "\n"}

    str + "}"
  end
end
