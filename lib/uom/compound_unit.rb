module Uom
  # Represents a compound unit of measure, such as m^2 or "m s^-1".
  class CompoundUnit
    attr_reader :parts
    def initialize(parts)
      @parts = {}
      parts.each do |part|
        unit_name, exponent = part.split("^")
        unit = Unit[unit_name.to_sym]
        raise "Unit #{unit_name} not found" unless unit
        exponent ||= 1
        exponent = exponent.to_i
        @parts[unit] ||= 0
        @parts[unit] += exponent
        @parts.delete(unit) if @parts[unit] == 0
      end
    end
    
    def self.[](str)
      return str if str.is_a?(CompoundUnit)
      str = str.code if str.is_a?(Unit)
      @compound_units ||= {}
      str = canonicalize(str)
      @compound_units[str] ||= begin
        new(str.split(" "))
      end
    end
    
    # Generates canonical string representation of this CompoundUnit.
    def to_s
      @parts.sort_by{|unit, exponent| unit.code.to_s}.map do |(unit, exponent)|
        exponent == 1 ? unit.code : "#{unit.code}^#{exponent}"
      end.join(" ")
    end
    
    def ==(other)
      @parts == other.parts
    end
    
    def dimensionless?
      @parts == {}
    end
    
    # Returns the underlying dimensionality of the unit, based on SI base units
    # (such as m^2 for length^2).
    def basis_units
      h = @parts.inject({}) do |hash, (unit, exponent)|
        base = unit.base_unit
        hash[base] ||= 0
        hash[base] += exponent * unit.base_unit_exponent
        hash
      end
      
      CompoundUnit[h.map{|unit,exponent| "#{unit.code}^#{exponent}"}.join(" ")]
    end
    
    # Returns the factor which can be multiplied by this unit's quantity to 
    # yield a quantity in +basis_units+.
    # Does not work for offset-based units (i.e., temperature).
    def basis_unit_factor
      @parts.inject(Rational(1,1)) do |factor, (unit, exponent)|
        factor /= ((unit.base_unit_factor) ** exponent)
      end
    end
            
    private
    
    def self.canonicalize(str)
      str.to_s.split(" ").sort.join(" ")
    end
        
  end
end
