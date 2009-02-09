require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe "simple units" do
  it "should be accessible via strings or symbols" do
    Uom::Unit[:s].should == Uom::Unit["s"]
  end
  
  it "should reference the correct SI base unit" do
    Uom::Unit[:lb].base_unit.should == Uom::Unit[:kg]
    Uom::Unit[:yd].base_unit.should == Uom::Unit[:m]
    Uom::Unit[:m].base_unit.should == Uom::Unit[:m]
  end
  
  it "should have sensible values for base_units" do
    Uom::Unit.base_units.should include(Uom::Unit[:kg])
    Uom::Unit.base_units.should_not include(Uom::Unit[:g])
  end
end

describe "compound units" do
  it "should accept dimensionless units" do
    Uom::CompoundUnit[""].parts.should == {}
    Uom::CompoundUnit[""].should be_dimensionless
  end
  
  it "should accept straight units via symbols or strings" do
    Uom::CompoundUnit[:m].should_not be_dimensionless
    Uom::CompoundUnit[:m].should == Uom::CompoundUnit["m^1"]
    Uom::CompoundUnit["m"].should == Uom::CompoundUnit["m^1"]
  end
  
  it "should accept a Unit object" do
    Uom::CompoundUnit[Uom::Unit[:m]].should == Uom::CompoundUnit[:m]
  end
  
  it "should generate a canonical order for compound units" do
    Uom::CompoundUnit['m lb^-1'].to_s.should == "lb^-1 m"
  end
  
  it "should compare canonically equivalent units as equal" do
    Uom::CompoundUnit['m lb^-1'].should == Uom::CompoundUnit['lb^-1 m']
  end
  
  it "should compare units with different units as unequal" do
    Uom::CompoundUnit['lb^-1 m'].should_not == Uom::CompoundUnit['m']
  end
  
  it "should compare units with different exponents as unequal" do
    Uom::CompoundUnit['lb^-1 m'].should_not == Uom::CompoundUnit['lb m']
  end
  
  it "should cancel redundant units" do
    Uom::CompoundUnit['m m^-1'].should == Uom::CompoundUnit['']
  end
  
  it "should simplify to basis units" do
    Uom::CompoundUnit['yd ft'].basis_units.should == Uom::CompoundUnit['m^2']
  end
  
  it "should have sensible basis unit factor values" do
    Uom::CompoundUnit['mm'].basis_unit_factor.
      should be_close(0.001, 0.00001)

    Uom::CompoundUnit['yd ft'].basis_unit_factor.
      should be_close(0.27870912, 0.00001)
  end
end

describe "conversions" do
  it "should reject a conversion with more than one offset-based unit" do
    lambda{Uom::Quantity.new(1, "degC")}.should_not raise_error

    lambda{Uom::Quantity.new(1, "degC^2")}.
      should raise_error(Uom::Quantity::IncompatibleUnitsError)
  end
  
  it "should reject conversions to improper units" do
    lambda{Uom::Quantity.new(1, "degC").convert_to("degF")}.
      should_not raise_error(Uom::Quantity::IncompatibleUnitsError)

    lambda{Uom::Quantity.new(1, "degC").convert_to("m")}.
      should raise_error(Uom::Quantity::IncompatibleUnitsError)
  end
  
  it "should handle simple-unit conversions with flying colors" do
    Uom::Quantity.new(1, :yd).convert_to(:ft).amount.
      should be_close(3, 0.00001)

    Uom::Quantity.new(58, :mm).convert_to(:in).amount.
      should be_close(2.28346457, 0.00001)
  end
  
  it "should convert compound units properly" do
    Uom::Quantity.new(12, "lb in^-2").convert_to("kg m^-2").amount.
      should be_close(8436.83496, 0.0001)
  end
  
  it "should convert temperature units including offset" do
    Uom::Quantity.new(0, "degC").convert_to("K").amount.
      should be_close(273.15, 0.1)

    Uom::Quantity.new(100, "degC").convert_to("K").amount.
      should be_close(373.15, 0.1)

    Uom::Quantity.new(0, "degC").convert_to("degF").amount.
      should be_close(32, 0.01)

    Uom::Quantity.new(100, "degC").convert_to("degF").amount.
      should be_close(212, 0.01)
  end
  
  it "should handle == properly for exact values" do
    Uom::Quantity.new(1, :K).should_not == Uom::Quantity.new(1, :degC)
    Uom::Quantity.new(1, :K).should == Uom::Quantity.new(1, :K)
  end
  
  it "should fudge equality for close values" do
    Uom::Quantity.new(0, :K).should == Uom::Quantity.new(-273.15, :degC)
  end
end

describe "derived units" do
  it "should maintain equivalence with equivalently-dimensioned SI units" do
    Uom::CompoundUnit['L'].basis_units.should == Uom::CompoundUnit['m^3']
  end
  
  it "should allow conversion between complex derived units" do
    Uom::Quantity.new(1, :L).should == Uom::Quantity.new(202.884136, :tsp)
    Uom::Quantity.new(150_000, "L^2").should == Uom::Quantity.new(0.15, "m^6")
  end
end

describe "core extensions" do
  it "should create a Uom::Quantity object" do
    10.mm.should == Uom::Quantity.new(10, :mm)
  end
  
  it "should accept in_* syntax for conversion" do
    10.ft.in_m.should be_close(3.048, 0.01)
  end
end

describe "UOM comparisons" do
  it "should be comparable" do
    lambda{1.mm < 2.mm}.should_not raise_error
  end
  
  it "should raise error for improper comparisons" do
    lambda{1.mm < 3.mL}.should raise_error(
      Uom::Quantity::IncompatibleUnitsError)
  end
  
  it "should work correctly within units, for inequality" do
    (1.mm <  2.mm).should be_true
    (1.mm <= 2.mm).should be_true
    (1.mm == 2.mm).should be_false
    (1.mm >= 2.mm).should be_false
    (1.mm >  2.mm).should be_false
    
    (2.mm <  1.mm).should be_false
    (2.mm <= 1.mm).should be_false
    (2.mm == 1.mm).should be_false
    (2.mm >= 1.mm).should be_true
    (2.mm >  1.mm).should be_true
  end
  
  it "should work correctly within units, for equality" do
    (1.mm <  1.mm).should be_false
    (1.mm <= 1.mm).should be_true
    (1.mm == 1.mm).should be_true
    (1.mm >= 1.mm).should be_true
    (1.mm >  1.mm).should be_false
  end
  
  it "should work correctly between units" do
    (1.in <  25.4.mm).should be_false
    (1.in <= 25.4.mm).should be_true
    (1.in == 25.4.mm).should be_true
    (1.in >= 25.4.mm).should be_true
    (1.in >  25.4.mm).should be_false
  end
  
  it "should fudge equality in all branches of Comparable" do
    (1.in <  25.4001.mm).should be_false
    (1.in <= 25.4001.mm).should be_true
    (1.in == 25.4001.mm).should be_true
    (1.in >= 25.4001.mm).should be_true
    (1.in >  25.4001.mm).should be_false
  end
  
end
  
