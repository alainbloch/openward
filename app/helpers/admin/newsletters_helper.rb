module Admin::NewslettersHelper


  def render_post_list(section = "", issue = nil )
    return nil if section.blank? or issue.nil?
    posts = issue.posts.published.in_archive.section(section.uri)
    if section.uri == "featured_voices"
      render :partial => "feature_list", :locals => {:features => posts, :issue => issue}
    else
      render :partial => "post_list", :locals => {:posts => posts, :issue => issue}
    end
  end

  def render_media_list(issue = nil)
    return nil if issue.nil?
    medias = issue.medias.published.in_archive
    render :partial => "media_list", :locals => {:medias => medias, :issue => issue}
  end

end
