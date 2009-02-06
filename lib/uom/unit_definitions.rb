Uom::Unit.define_units do
  # Syntax:
  #   unit unit, parent_unit, factor, offset, options
  # 
  # where:
  #   factor * (parent_unit + offset) = unit
  # 
  # Examples:
  #   unit :m                     # Defines a base unit from which others are 
  #                               # derived
  #   unit :cm, :m, 100           # 100 * m = cm
  #   unit :degC, :K, 1, -273.15  # 1 * (K + (-273.15)) = C
  
  # Length
  unit :m
  unit :cm, :m, 100
  unit :mm, :m, 1000
  unit :ft, :m, 3.2808399
  unit :in, :ft, 12
  unit :yd, :ft, Rational(1,3)
  
  # Area
  unit :acre, "m^2", 0.000247105381
  
  # Volume
  unit :L, "m^3", 1000
  unit :mL, :L, 1000
  
  # Volume (US customary units)
  unit :gal, "m^3", 264.172052
  unit :qt, :gal, 4
  unit :pint, :gal, 8
  unit :cup, :gal, 16
  unit :fl_oz, :gal, 128
  unit :tbsp, :gal, 256
  unit :tsp, :gal, 768
  
  # Mass
  unit :kg
  unit :g, :kg, 1000
  unit :lb, :kg, 2.20462262
  unit :ton, :lb, 2000
  unit :oz, :lb, 16
  
  # Temperature
  unit :K
  unit :degC, :K, 1, -273.15
  unit :degF, :K, Rational(9,5), -459.67
  
end
