# Math functions and conversions for Unit.
module Uom
  class Unit
    
    def /(scalar)
      Unit.new(dimension, nil, [:/, self, scalar])
    end
    
    def *(scalar)
      Unit.new(dimension, nil, [:*, self, scalar])
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
