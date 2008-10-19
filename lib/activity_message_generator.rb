class ActivityMessageGenerator
  attr_accessor :target, :container, :action
  
  def initialize(template, target = nil, container = nil, action = nil)
    @template = template
    @target = target
    @container = container
    @action = action
  end
  
  def link_obj(item)
    "#{link_to(item)} #{item.class.name.humanize.downcase}"
  end
  
  def link_to(item)
    if container && item != container
      @template.link_to(item.name, [container, item])
    else
      @template.link_to(item.name, item)
    end
  end
  
  def message
    if container
      case action
      when :create  then "Added #{link_obj(target)} to #{link_obj(container)}"
      when :update  then "Edited #{link_obj(target)} in #{link_obj(container)}"
      when :destroy then "Removed #{link_obj(target)} from #{link_obj(container)}"
      end
    else
      case action
      when :create  then "Created #{link_obj(target)}"
      when :update  then "Edited #{link_obj(target)}"
      when :destroy then "Deleted #{link_obj(target)}"
      end
    end
  end
end