class Peak < Hash

  DATA_FILE = File.join(App.resources_path, 'data', 'peaks.json')

  class << self

    def __cache__
      @__cache__ ||= []
    end

    def all
      @all ||= load_json.each_with_object([]) do |raw_peak, ary|
        instance = new raw_peak
        ary << instance if instance.latitude && instance.longitude
      end
    end

    def load_json
      BW::JSON.parse(File.read DATA_FILE)
    end

    def property(name)
      define_method name do
        fetch('properties', {}).fetch(name, nil)
      end
    end

  end

  def initialize(hash)
    super
    merge! hash
    return nil
  end

  def save
    return false unless lat && lng
    self.class.__cache__ << self
  end

  def save!
    save || fail(ArgumentError, "cannot save without latlng")
  end

  property :name
  property :meters

  property :latitude
  alias :lat :latitude

  property :longitude
  alias :lng :longitude

  def feet
    meters.in(:meters).to(:feet)
  end

  def latlng
    [lat, lng]
  end

  def location
    CLLocation.alloc.initWithLatitude(latitude.floatValue, longitude: longitude.floatValue)
  end

  def get_distance(loc)
    get_distance(loc, inUnits: :miles)
  end

  def get_distance(loc, inUnits: unit)
    location.distanceFromLocation(loc).in(:meters).to(unit)
  end

  def nearby?(location, distance = 0.25)
    get_distance(location) < distance
  end

end