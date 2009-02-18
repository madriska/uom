class Uom::Unit 

  dimension :length do
    unit :m
    unit :cm => m / 100
    unit :mm => m / 1000

    unit :in => m / 39.3700787
    unit :ft => 12 * unit("in")
    unit :yd => 3 * ft
    unit :mi => 5_280 * ft

    # Area
    unit :a     => 100 * m**2
    unit :ha    => 100 * a
    unit :acre  => 4046.85642 * m**2

    # Volume
    unit :L  => m**3 / 1000
    unit :mL => unit("L") / 1000

    # Volume: US customary units
    unit :tsp   => 4.92892159 * mL
    unit :tbsp  => 3 * tsp
    unit :fl_oz => 2 * tbsp
    unit :cup   => 8 * fl_oz
    unit :pint  => 2 * cup
    unit :qt    => 2 * pint
    unit :gal   => 4 * qt
  end
  
  dimension :mass do
    unit :kg
    unit :g   => kg / 1000

    # US customary units
    unit :lb  => kg * 0.45359237
    unit :ton => 2000 * lb
    unit :oz  => lb / 16
  end

  dimension :time do
    unit :s
    unit :ms => s / 1000
    unit :ns => s / 1000000000

    unit :min   => 60.0  * s
    unit :hr    => 60    * min
    unit :day   => 24.0  * hr
    unit :wk    => 7     * day
    unit :month => 30.42 * day
    unit :yr    => 12    * month
  end

  dimension :current do
    unit :A
    # TODO
  end
  
  dimension :temperature do
    # Rational is used below for exact values.
    # Float signifies inexact values.
    
    # Ratio units for temperature intervals
    unit :K
    unit :degC => unit("K")
    unit :degR => Rational(9,5) * unit("K")
    unit :degF => degR
    
    # Non-ratio units (temperature measurements)
    unit :tempC => unit("K") - Rational(27315,100)
    unit :tempF => degR - Rational(45967,100)
  end

  dimension :luminous_intensity do
    unit :cd
    # TODO
  end

  dimension :amount_of_substance do
    unit :mol
    # TODO
  end
  
end
