module LocationHelper
  class Tracker

    DEFAULT_LOCATION = CLLocation.alloc.initWithLatitude(0.0, longitude: 0.0)

    class << self
      attr_writer :last

      def last
        @last ||= new(DEFAULT_LOCATION)
      end

      def update(&block)
        BW::Location.get_once do |location|
          tracker = new location
          puts 'got location'
          self.last = tracker
          block.call tracker if block_given?
        end
      end

    end

    attr_reader :location

    def initialize(location)
      @location = location
      @timestamp = Time.now
      peak
    end

    def peak
      @peak ||= Peak.all.find { |peak| peak.nearby?(@location) } || Peak.allocate
    end

    def valid?
      @location != DEFAULT_LOCATION && @timestamp > 10.minutes.ago
    end

  end
end
