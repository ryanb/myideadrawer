require File.dirname(__FILE__) + '/../spec_helper'

# so the link doesn't actually generate html so it doesn't mess with our tests
class TemplateStub
  def link_to(name, path)
    name
  end
  
  def project_url(project)
    project
  end
  
  def project_note_url(project, note)
    return project
  end
end

describe ActivityMessageGenerator do
  before(:each) do
    @message_generator = ActivityMessageGenerator.new(TemplateStub.new)
  end
  
  it "should generate name of object" do
    @message_generator.link_obj(Project.new(:name => 'foo')).should == "foo project"
  end
  
  it "should link to object" do
    target = Note.new(:name => 'f&oo')
    template = TemplateStub.new
    template.expects(:note_url).with(target).returns('note_url')
    template.expects(:link_to).with('f&amp;oo', 'note_url').returns('link')
    message_generator = ActivityMessageGenerator.new(template)
    message_generator.link_obj(target).should == "link note"
  end
  
  it "should link to object with container object" do
    target = Note.new(:name => 'foo')
    container = Project.new(:name => 'bar')
    container.token = 'token'
    template = TemplateStub.new
    template.expects(:project_note_url).with('token', target).returns('note_url')
    template.expects(:link_to).with('foo', 'note_url').returns('link')
    message_generator = ActivityMessageGenerator.new(template)
    message_generator.container = container
    message_generator.link_obj(target).should == "link note"
  end
  
  describe "with container" do
    before(:each) do
      @message_generator.target = Note.new(:name => 'foo')
      @message_generator.container = Project.new(:name => 'bar')
    end
    
    it "should generate message based on create action" do
      @message_generator.action = :create
      @message_generator.message.should == "Added foo note to bar project"
    end
    
    it "should generate message based on update action" do
      @message_generator.action = :update
      @message_generator.message.should == "Edited foo note in bar project"
    end
    
    it "should generate message based on destroy action" do
      @message_generator.action = :destroy
      @message_generator.message.should == "Removed foo note from bar project"
    end
  end
  
  describe "without container" do
    before(:each) do
      @message_generator.target = Project.new(:name => 'foo')
    end
    
    it "should generate message based on create action" do
      @message_generator.action = :create
      @message_generator.message.should == "Created foo project"
    end
    
    it "should generate message based on update action" do
      @message_generator.action = :update
      @message_generator.message.should == "Edited foo project"
    end
    
    it "should generate message based on destroy action" do
      @message_generator.action = :destroy
      @message_generator.message.should == "Deleted foo project"
    end
  end
end
