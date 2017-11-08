require 'open-uri'
module Location
  class Base
    attr_reader :url

    def initialize(options={})
      @address = options[:address]
      @region = options[:region]
    end

    private
    def default_options
      {
        person_capacity: 2,
        room_type: 'private_room',
        occupancy_rate: 100
      }
    end
  end
end
