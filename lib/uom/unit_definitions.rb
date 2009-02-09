Uom::Unit.define_units do
  
  dimension :length do
    unit :m
    unit :cm => m / 100
    unit :mm => m / 1000

    unit :ft => m / 3.2808399
    unit :in => ft / 12
    unit :yd => 3 * ft
  end
  
  dimension :area => dimension(:length)**2 do
    unit :acre => 4046.85642 * unit("m^2")
  end
  
  dimension :volume => dimension(:length)**3 do
    unit :L  => unit("m^3") / 1000
    unit :mL => unit("L") / 1000

    # US customary units
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
    unit :lb  => kg / 2.20462262
    unit :ton => 2000 * lb
    unit :oz  => lb / 16
  end
  
  dimension :temperature do
    # Rational is used below for exact values.
    # Float signifies inexact values.
    
    unit :K
    # Rankine is mainly included for completeness and to simplify degF definition
    unit :degR => Rational(9,5) * unit("K")
    unit :degC => unit("K") + Rational(27315,100)
    unit :degF => degR - Rational(45967,100)
  end
  
end
