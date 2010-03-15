module Admin::IssuesHelper
  
  def issue_select_options
    volumes = Volume.find(:all, :order => "created_at DESC")
    return [] if volumes.empty?
    volumes.collect{|v| [ "Volume #{v.number} - #{v.title}", v.id ] }
  end
  
  def render_post_list(section = "", issue = nil )
    return nil if section.blank? or issue.nil?
    posts = issue.posts.section(section).published
    if section.uri == "featured_voices"
      render :partial => "feature_list", :locals => {:features => posts, :issue => issue}
    else
      render :partial => "post_list", :locals => {:posts => posts, :issue => issue}
    end
  end

  def render_media_list(issue = nil)
    return nil if issue.nil?
    medias =  issue.medias.published
    render :partial => "media_list", :locals => {:medias => medias, :issue => issue}
  end
  
end
