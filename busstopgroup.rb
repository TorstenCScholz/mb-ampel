class BusStopGroup < Delegator
  attr_reader :bus_stops

  def initialize(arg)
    super
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

# TODO: Use for tests later
# bus_stop1 = BusStop.new id: 5, name: 'Bus 1', direction: 'einwärts', station: nil
# bus_stop2 = BusStop.new id: 77, name: 'Bus 2', direction: 'auswärts', station: nil
# bus_stop_group = BusStopGroup.new bus_stop1
# bus_stop_group.add_bus_stop bus_stop2
# bus_stop_group.remove_bus_stop bus_stop1
#
# pp bus_stop_group
