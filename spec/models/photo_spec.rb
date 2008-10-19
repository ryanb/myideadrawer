require File.dirname(__FILE__) + '/../spec_helper'

describe Photo do
  it "should be valid from factory" do
    Factory.build(:photo).should be_valid
  end
  
  it "should require name" do
    Factory.build(:photo, :name => '').should have(1).error_on(:name)
  end
end
