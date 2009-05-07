require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe Uom, "math" do
  include Uom::Unit::Environment

  it "should reject addition of incommensurable values" do
    lambda do
      3*m + 4*s
    end.should raise_error(Uom::Errors::IncommensurableUnits)
  end


end
