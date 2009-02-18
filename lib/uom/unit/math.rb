# Math functions and conversions for Unit and Quantity.
module Uom
  module UnitMath
    
    def /(scalar)
      Quantity.new(1, [:/, self, scalar])
    end
    
    def *(scalar)
      Quantity.new(1, [:*, self, scalar])
    end

    def **(scalar)
      Quantity.new(1, [:**, self, scalar])
    end

    def +(val)
      # TODO
    end

    def -(val)
      # TODO
    end

    def coerce(other)
      [self, other]
    end

  end
end

