class Peak < Hash

  DATA_DIR = File.join(App.resources_path, 'data')

  class << self

    def __cache__
      @__cache__ ||= []
    end

    def all
      return __cache__ unless __cache__.empty?
      Dir.glob(File.join DATA_DIR, '**', '*.geojson').each do |file|
        next if File.basename(file) =~ /^_index/
        from_file(file).save
      end
      __cache__
    end

    def from_file(file)
      from_json File.read file
    end

    def from_json(string)
      new BW::JSON.parse string
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
  property :feet

  property :latitude
  alias :lat :latitude

  property :longitude
  alias :lng :longitude

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

  # all.find { |peak| peak.nearby location }

  private

end