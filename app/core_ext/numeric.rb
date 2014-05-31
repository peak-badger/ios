class Numeric < NSNumber

  class Unit

    def self.conversions
      @conversions ||= {
          kilometer: 1000.0,
          meter: 1.0,
          feet: 0.3048,
          mile: 1609.34
      }.with_indifferent_access
    end

    def conversions
      self.class.conversions
    end

    def initialize(numeric, unit)
      @unit = unit
      @numeric = numeric.to_f
    end

    def convert_to(unit)
      (@numeric * conversions[@unit.singularize]) /
          conversions[unit.singularize]
    end

    alias to convert_to
    alias converted_to convert_to

  end

  def in_a_unit_of(unit)
    Unit.new(self, unit)
  end

  alias in in_a_unit_of

end
