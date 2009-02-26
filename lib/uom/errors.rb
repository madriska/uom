module Uom
  module Errors
    
    # Raised when units cannot be compared or converted
    # (such as seconds vs. kilograms).
    IncommensurableUnits = Class.new(StandardError)

  end
end
