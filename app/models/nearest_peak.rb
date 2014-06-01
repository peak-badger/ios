class NearestPeak

  delegate :name, to: :@peak

  def initialize(location)
    @location = location
    @peak = Peak.all.sort_by { |peak| peak.get_distance location }.first
    distance
  end

  def distance
    @distance ||= @peak.get_distance(@location)
  end

  def distance_with_units
    unit = distance.in(:meters).to(:miles) < 0.5 ? :feet : :miles
    unit_int = distance.in(:meters).to(unit).round(2)
    unit_text = unit_int == 1 ? unit.singuarlaize : unit
    "#{unit_int} #{unit_text}"
  end

end