require File.dirname(__FILE__) + '/../spec_helper'

describe Project do
  it "should be valid" do
    Project.new.should be_valid
  end
  
  it "should generate a unique token" do
    p1 = Project.create!
    p2 = Project.create!
    p1.token.should_not == p2.token
  end
end
