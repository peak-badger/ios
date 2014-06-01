module LocationHelper
  class Tracker

    DEFAULT_LOCATION = CLLocation.alloc.initWithLatitude(0.0, longitude: 0.0)

    class << self
      attr_writer :last

      def last
        @last ||= new(DEFAULT_LOCATION)
      end

      def update(&block)
        EM.schedule_on_main do
          return raise_location_error unless BW::Location.enabled?
          BW::Location.get_once do |location|
            unless last.valid? && last.location.distanceFromLocation(location) < 10
              tracker = new location
              self.last = tracker
              block.call tracker if block
            end
          end
        end
      end

      private

      def raise_location_error
        App.alert('You must have location services on to use this app!')
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

    def nearest_peak
      NearestPeak.new(location)
    end

    def valid?
      @location != DEFAULT_LOCATION && @timestamp > 10.minutes.ago
    end

  end
end
