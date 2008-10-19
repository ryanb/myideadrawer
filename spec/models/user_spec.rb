require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  def new_user(attributes = {})
    attributes[:password_confirmation] ||= attributes[:password]
    Factory.build(:user, attributes)
  end
  
  before(:each) do
    User.delete_all # so uniqueness validations don't cause problems
  end
  
  it "should be valid" do
    new_user.should be_valid
  end
  
  it "should require username" do
    new_user(:username => '').should have(1).error_on(:username)
  end
  
  it "should require password" do
    new_user(:password => '').should have(1).error_on(:password)
  end
  
  it "should require email" do
    new_user(:email => '').should have(1).error_on(:email)
  end
  
  it "should require well formed email" do
    new_user(:email => 'foo@bar@example.com').should have(1).error_on(:email)
  end
  
  it "should require matching password confirmation" do
    new_user(:password_confirmation => 'nonmatching').should have(1).error_on(:password)
  end
  
  it "should generate password hash and salt on create" do
    user = new_user
    user.save!
    user.password_hash.should_not be_nil
    user.password_salt.should_not be_nil
  end
  
  it "should authenticate by username" do
    user = new_user(:username => 'foobar', :password => 'secret')
    user.save!
    User.authenticate('foobar', 'secret').should == user
  end
  
  it "should authenticate by email" do
    user = new_user(:email => 'foo@bar.com', :password => 'secret')
    user.save!
    User.authenticate('foo@bar.com', 'secret').should == user
  end
  
  it "should not authenticate bad username" do
    User.authenticate('nonexisting', 'secret').should be_nil
  end
  
  it "should not authenticate bad password" do
    new_user(:username => 'foobar', :password => 'secret').save!
    User.authenticate('foobar', 'badpassword').should be_nil
  end
  
  it "should not require password when using openid url" do
    user = User.new(:openid_url => 'foo')
    user.should_not have(1).errors_on(:password)
  end
  
  it "should validate uniqueness of username" do
    Factory(:user, :username => 'spongebob')
    Factory.build(:user, :username => 'spongebob').should have(1).error_on(:username)
  end
  
  it "should validate uniqueness of email" do
    Factory(:user, :email => 'bar@example.com')
    Factory.build(:user, :email => 'bar@example.com').should have(1).error_on(:email)
  end
  
  it "should build user from openid attributes" do
    user = User.build_from_openid('nickname' => 'foo', 'email' => 'bar', 'openid_url' => 'boo')
    user.username.should == 'foo'
    user.email.should == 'bar'
    user.openid_url.should == 'boo'
  end
  
  describe "with password" do
    before(:each) do
      @user = new_user
      @user.save!
      @user.reload
      @password_hash = @user.password_hash
    end
    
    it "should not change password when editing with blank password and confirmation" do
      @user.update_attributes!(:password => '', :password_confirmation => '', :email => 'bar@example.com')
      @user.password_hash.should == @password_hash
    end
    
    it "should have validation on password when attempting to change it" do
      @user.attributes = {:password => 'foo', :password_confirmation => ''}
      @user.should have(1).errors_on(:password)
      @user.password_hash.should == @password_hash
    end
    
    it "should be able to change password when valid" do
      @user.update_attributes!(:password => 'newpass', :password_confirmation => 'newpass')
      @user.password_hash.should_not == @password_hash
    end
  end
end
