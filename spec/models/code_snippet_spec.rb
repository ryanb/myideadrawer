require File.dirname(__FILE__) + '/../spec_helper'

describe CodeSnippet do
  it "should be valid from factory" do
    Factory.build(:code_snippet).should be_valid
  end
  
  it "should require name" do
    Factory.build(:code_snippet, :name => '').should have(1).error_on(:name)
  end
  
  it "should require content" do
    Factory.build(:code_snippet, :content => '').should have(1).error_on(:content)
  end
  
  it "should require language" do
    Factory.build(:code_snippet, :language => '').should have(1).error_on(:language)
  end
end
