module Uom
  class Quantity
    class IncompatibleUnitsError < StandardError; end
    include Comparable
    
    attr_reader :amount, :units, :code
    def initialize(amount, units)
      @amount = amount
      @units = CompoundUnit[units]
      raise IncompatibleUnitsError unless units_compatible?
    end
    
    def convert_to(to_units)
      to_units = CompoundUnit[to_units]
      raise IncompatibleUnitsError unless units.basis_units == 
        to_units.basis_units
      
      if @units.parts.keys.any?{|p| p.temperature?}
        to_amount = (((amount - units.parts.keys.first.offset) * 
                        units.basis_unit_factor) / to_units.basis_unit_factor) +
                      to_units.parts.keys.first.offset
        return Quantity.new(to_amount, to_units)
      end
      
      Quantity.new(amount * units.basis_unit_factor / 
                     to_units.basis_unit_factor, 
                   to_units)
    end

    def inspect
      "#{amount} #{units}"
    end
    
    DELTA = 0.001
    def <=>(other)
      other_amount = other.convert_to(units).amount
      return 0 if (@amount - other_amount).abs < DELTA
      @amount <=> other_amount
    rescue 
      raise IncompatibleUnitsError
    end
    
    # If a unit includes an offset, it must be the only unit being calculated.
    def units_compatible?
      !@units.parts.keys.any?{|p| p.temperature?} || @units.dimensionless? || 
        (@units.parts.size == 1 && @units.parts.values.first == 1)
    end
        
  end
end
