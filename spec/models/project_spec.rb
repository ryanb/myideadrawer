require File.dirname(__FILE__) + '/../spec_helper'

describe Project do
  it "should be valid" do
    Project.new.should be_valid
  end
  
  it "should generate a unique token" do
    p1 = Factory(:project)
    p2 = Factory(:project)
    p1.token.should_not == p2.token
  end
  
  it "should not be able to fetch projects by id that user doesn't own" do
    project = Factory(:project)
    lambda {
      Project.fetch(User.new, project.id)
    }.should raise_error(ActiveRecord::RecordNotFound)
  end
  
  it "should not be able to fetch projects by bad token" do
    lambda {
      Project.fetch(User.new, 'badtoken')
    }.should raise_error(ActiveRecord::RecordNotFound)
  end
  
  it "should be able to fetch projects by id that user owns" do
    user = Factory(:user)
    project = Factory(:project, :user => user)
    Project.fetch(user, project.id).should == project
  end
  
  it "should be able to fetch projects by correct token" do
    project = Factory(:project)
    Project.fetch(nil, project.token).should == project
  end
  
  it "should not beable to fetch if user is nil with bad token" do
    lambda {
      Project.fetch(nil, 'badtoken')
    }.should raise_error(ActiveRecord::RecordNotFound)
  end
end
