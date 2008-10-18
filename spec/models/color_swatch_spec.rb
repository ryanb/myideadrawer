require File.dirname(__FILE__) + '/../spec_helper'

describe ColorSwatch do
  it "should be valid" do
    ColorSwatch.new.should be_valid
  end
end
