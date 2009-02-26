require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe "simple units" do
  it "should be accessible via strings or symbols" do
    Uom::Unit[:s].should == Uom::Unit["s"]
  end
end

describe "conversions" do
  it "should reject conversions to improper units" do
    pending "conversions not implemented yet"
    lambda{Uom::Quantity.new(1, "degC").convert_to("degF")}.
      should_not raise_error(Uom::Quantity::IncompatibleUnitsError)

    lambda{Uom::Quantity.new(1, "degC").convert_to("m")}.
      should raise_error(Uom::Quantity::IncompatibleUnitsError)
  end
  
  it "should handle simple-unit conversions with flying colors" do
    pending "conversions not implemented yet"
    Uom::Quantity.new(1, :yd).convert_to(:ft).amount.
      should be_close(3, 0.00001)

    Uom::Quantity.new(58, :mm).convert_to(:in).amount.
      should be_close(2.28346457, 0.00001)
  end
  
  it "should convert compound units properly" do
    pending "conversions not implemented yet"
    Uom::Quantity.new(12, "lb in^-2").convert_to("kg m^-2").amount.
      should be_close(8436.83496, 0.0001)
  end
  
  it "should convert temperature units including offset" do
    pending "conversions not implemented yet"
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
    pending "conversions not implemented yet"
    Uom::Quantity.new(1, :K).should_not == Uom::Quantity.new(1, :degC)
    Uom::Quantity.new(1, :K).should == Uom::Quantity.new(1, :K)
  end
  
end

describe "derived units" do
  it "should allow conversion between complex derived units" do
    pending "conversions not implemented yet"
    Uom::Quantity.new(1, :L).should == Uom::Quantity.new(202.884136, :tsp)
    Uom::Quantity.new(150_000, "L^2").should == Uom::Quantity.new(0.15, "m^6")
  end
end

describe "core extensions" do
  it "should create a Uom::Quantity object" do
    10.mm.should be_an_instance_of(Uom::Quantity)
  end
  
  it "should accept in_* syntax for conversion" do
    pending "conversions not implemented yet"
    10.ft.in_m.should be_close(3.048, 0.01)
  end
end

describe "UOM comparisons" do
  it "should be comparable" do
    pending "comparisons not implemented yet"
    lambda{1.mm < 2.mm}.should_not raise_error
  end
  
  it "should raise error for improper comparisons" do
    pending "comparisons not implemented yet"
    lambda{1.mm < 3.mL}.should raise_error(
      Uom::Quantity::IncompatibleUnitsError)
  end
  
  it "should work correctly within units, for inequality" do
    pending "comparisons not implemented yet"
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
    pending "comparisons not implemented yet"
    (1.mm <  1.mm).should be_false
    (1.mm <= 1.mm).should be_true
    (1.mm == 1.mm).should be_true
    (1.mm >= 1.mm).should be_true
    (1.mm >  1.mm).should be_false
  end
  
  it "should work correctly between units" do
    pending "comparisons not implemented yet"
    (1.in <  25.4.mm).should be_false
    (1.in <= 25.4.mm).should be_true
    (1.in == 25.4.mm).should be_true
    (1.in >= 25.4.mm).should be_true
    (1.in >  25.4.mm).should be_false
  end
  
  it "should fudge equality in all branches of Comparable" do
    pending "comparisons not implemented yet"
    (1.in <  25.4001.mm).should be_false
    (1.in <= 25.4001.mm).should be_true
    (1.in == 25.4001.mm).should be_true
    (1.in >= 25.4001.mm).should be_true
    (1.in >  25.4001.mm).should be_false
  end
  
end
  
