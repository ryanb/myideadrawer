xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{current_project.name} Activity"
    xml.description "Recent activity for #{current_project.name} project on MyIdeaDrawer."
    xml.link formatted_project_activities_url(current_project.token, :rss)
    
    @activities.each do |activity|
      xml.item do
        xml.title activity.message
        xml.description activity.message
        xml.author activity.user.username if activity.user
        xml.pubDate activity.created_at.to_s(:rfc822)
        xml.link project_url(current_project.token)
        xml.guid({:isPermaLink => "false"}, "myideadrawer.com-activity-#{activity.id}")
      end
    end
  end
end
