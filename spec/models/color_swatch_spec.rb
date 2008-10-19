require File.dirname(__FILE__) + '/../spec_helper'

describe ColorSwatch do
  it "should be valid from factory" do
    Factory.build(:color_swatch).should be_valid
  end
  
  it "should require hex" do
    Factory.build(:color_swatch, :hex => '').should have(1).error_on(:hex)
  end
end
