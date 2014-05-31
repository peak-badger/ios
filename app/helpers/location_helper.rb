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
          self.last = tracker
          block.call tracker if block_given?
        end
      end

    end

    attr_reader :location

    def initialize(location)
      @location = location
      @timestamp = Time.now
    end

    def peak
      @peak ||= Peak.all.find { |peak| peak.nearby?(@location) }
    end

    def valid?
      @location != DEFAULT_LOCATION && @timestamp > 10.minutes.ago
    end

  end

  def fetch_location(&block)
    if Tracker.last.valid?
      block.call Tracker.last if block_given?
    else
      Tracker.update(&block)
    end
  end

end