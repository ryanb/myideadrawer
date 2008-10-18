require File.dirname(__FILE__) + '/../spec_helper'

describe CodeSnippet do
  it "should be valid" do
    CodeSnippet.new.should be_valid
  end
end
