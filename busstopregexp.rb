# encoding: UTF-8

require 'json'

class BusStopRegexp
  attr_accessor :base_url

  def initialize(base_url)
    @base_url = base_url
  end

  def to_json
    {
      regexp: get_regexp(base_url).inspect,
      regexp_groups: {
        id: {
          regexp_groups: [1],
          optional: false
        },
        bus_stop_name: {
          regexp_groups: [2, 3, 4],
          optional: false
        },
        direction: {
          regexp_groups: [5],
          optional: true
        }
      }
    }.to_json
  end

  def get_regexp(base_url)
    %r%<a class="inactive" name="efahyperlinks" href="#{base_url}/(\d+?)" target="_self">(.*?)<span style="font-weight:bold;">(.+?)</span>(.*?) <span class="richtung">(?:\((.*?)\))?</span></a>%i
  end
end
