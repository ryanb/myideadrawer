require File.dirname(__FILE__) + '/../spec_helper'

describe Link do
  it "should be valid from factory" do
    Factory.build(:link).should be_valid
  end
  
  it "should require name" do
    Factory.build(:link, :name => '').should have(1).error_on(:name)
  end
  
  it "should require url" do
    Factory.build(:link, :url => '').should have(1).error_on(:url)
  end
end
