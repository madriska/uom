require 'rational'
module Uom
  class Unit
    
    class BadComparison < StandardError; end
    
    def self.[](unit)
      @units[unit.to_sym]
    end
    
    def self.define_units(&block)
      env = UnitEnvironment.new
      env.instance_eval(&block)
      @units = env.units
    end
    
    def self.base_units
      @units.values.select{|u| u.base_unit?}
    end
    
    def self.derived_units(base_unit)
      @units.values.select{|u| u.scalar_base_unit.code.to_sym == 
                               base_unit.to_sym}
    end
    
    attr_accessor :code, :parent_unit, :factor, :offset
    def initialize(code, parent_unit = nil, factor = nil, offset = 0)
      @code = code
      if parent_unit.is_a?(Array)
        @parent_unit, @parent_exponent = *parent_unit
      else
        @parent_unit = parent_unit
      end
      @factor = factor
      @offset = offset
    end
    
    def parent_exponent
      @parent_exponent || 1
    end
    
    def base_unit?
      parent_unit.nil?
    end
    
    # Returns the SI base unit upon which this unit is based.
    def base_unit
      base_unit? ? self : parent_unit.base_unit
    end

    def scalar_base_unit?
      base_unit? || (parent_exponent != 1)
    end
    
    # Like base_unit, but will not traverse up exponents; e.g., 
    # "m^3" is a scalar base unit.
    def scalar_base_unit
      scalar_base_unit? ? self : parent_unit.scalar_base_unit
    end
    
    def base_unit_exponent
      base_unit? ? 1 : (parent_exponent * parent_unit.base_unit_exponent)
    end
    
    def base_unit_factor
      base_unit? ? 1 : (@factor * parent_unit.base_unit_factor)
    end
    
    def temperature?
      base_unit.code == :K
    end
    
    class UnitEnvironment
      attr_reader :units
      def initialize
        @units = {}
      end

      def unit(unit, parent_unit = nil, factor = nil, offset = 0)
        parent = case parent_unit
          when Symbol then @units[parent_unit]    # :m
          when String                             # "m^3"
            u, exponent = parent_unit.split("^")
            [@units[u.to_sym], exponent.to_i]
          else parent_unit                        # nil, etc.
        end
        @units[unit] = Unit.new(unit, parent, factor, offset)
      end
    end
    
  end
end
