require File.dirname(__FILE__) + '/../spec_helper'

describe Project do
  it "should be valid from factory" do
    Factory.build(:project).should be_valid
  end
  
  it "should require name" do
    Factory.build(:project, :name => '').should have(1).error_on(:name)
  end
  
  it "should generate a unique token" do
    p1 = Factory(:project, :user => nil)
    p2 = Factory(:project, :user => nil)
    p1.token.should_not == p2.token
  end
  
  it "should not be able to fetch projects by bad token/id" do
    lambda {
      Project.fetch('badtoken').should be_nil
    }.should raise_error(ActiveRecord::RecordNotFound)
  end
  
  it "should be able to fetch projects by id" do
    project = Factory(:project)
    Project.fetch(project.id).should == project
  end
  
  it "should be able to fetch projects by correct token" do
    project = Factory(:project)
    Project.fetch(project.token).should == project
  end
end
