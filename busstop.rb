# encoding: UTF-8

require 'json'

BUS_STOP_NAME_REGEX = /^(?:(.+)\s)?(\w\d?)(?:\s(.+))?$/i

class BusStop
  attr_reader :id, :name, :direction, :station

  def initialize(args)
    @id = args[:id]
    @name = args[:name]
    @direction = args[:direction]
    @station = args[:station]
  end

  def to_s
    ret =  "@#{self.class}{id: #{id}, name: #{name}"
    ret += ", direction: #{direction}" unless direction.nil?
    ret += ", station: #{station}" unless station.nil?
    ret + "}"
  end

  def to_json(options = {})
    JSON.generate(self.to_hash)
  end

  def to_hash
    hash = {}
    instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

  def self.contains_station_name(full_name)
    full_name =~ BUS_STOP_NAME_REGEX
  end

  def self.new_from_station_name(args)
    full_name = args[:name]

    if full_name =~ BUS_STOP_NAME_REGEX
      prefix  = $1.nil? ? '' : $1
      postfix = $3.nil? ? '' : $3

      return BusStop.new id: args[:id], name: prefix + postfix, direction: args[:direction], station: $2
    end

    nil
  end
end
