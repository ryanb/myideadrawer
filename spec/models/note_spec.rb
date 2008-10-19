require File.dirname(__FILE__) + '/../spec_helper'

describe Note do
  it "should be valid from factory" do
    Factory.build(:note).should be_valid
  end
  
  it "should require name" do
    Factory.build(:note, :name => '').should have(1).error_on(:name)
  end
  
  it "should require content" do
    Factory.build(:note, :content => '').should have(1).error_on(:content)
  end
end
