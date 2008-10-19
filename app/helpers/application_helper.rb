# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def textilize(content = nil)
    RedCloth.new(content.to_s).to_html
  end
end
