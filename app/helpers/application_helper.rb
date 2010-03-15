# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def link_to_activity(activity)
    return if activity.blank?
    action = activity.action
    url = case action.class.to_s
          when "Post"
            edit_admin_post_path(action)
          when "Comment"
            admin_comments_path(:anchor => "comment_#{action.id}")
          when "Media"
            edit_admin_media_path(action)
          when "Page"
            edit_admin_page_path(action)
          when "Suggestion"
            admin_suggestions_path(:anchor => "suggestion_#{action.id}")
          when "User"
            admin_user_path(action)
          else 
            #Suggestions
            nil
          end
    return link_to("view", url) unless url.blank?
    return "&nbsp;"
  end
  
  
  # Display text by sanitizing and formatting.
  # The formatting is done by Markdown via the BlueCloth gem.
  # The html_options, if present, allow the syntax
  #  display("foo", :class => "bar")
  #  => '<p class="bar">foo</p>'
  def display(text, html_options = nil)
    if html_options
      html_options = html_options.stringify_keys
      tag_options = tag_options(html_options)
    else
      tag_options = nil
    end
    #sanitize(text).to_html.gsub("<p>", "<p#{tag_options}>")
    markdown(sanitize(text.gsub("\n","<br/>"))).gsub("<p>", "<p#{tag_options}>")
  end
  
  
  def media_content_icon(media = nil, options = {})
    return if media.nil? or media.type != Media
    media_type = media.media_type
    case media_type
    when "Text" then image_tag("media_types/doc.png", options)
    when "Video" then image_tag("media_types/video.png", options)
    when "Audio" then image_tag("media_types/video.png", options)  
    when "Image" then image_tag("media_types/image.png", options)
    else  image_tag("media_types/unknown.png", options)      
    end
  end
  
  def media_thumbnail(media = nil, options = {})
    return if media.nil? or media.type != Media
    media_type = media.media_type
    @associated_media = media
    case media_type
    when "Text"
      image_tag("media_icons/media_text.jpg", options)
    when "Video"
      image_tag("media_icons/media_video.jpg", options)
    when "Audio"
      image_tag("media_icons/media_audio.jpg", options)
    when "Image"
      if media.media_class == "link"
        image_tag("media_icons/media_image.jpg", options)
      else
        image_tag(url_for_file_column('associated_media', 'file'), options)
      end
    when "Caricature"
      image_tag(url_for_file_column('associated_media', 'file'), options)
    else  image_tag("video_image.gif", options)      
    end 
  end
  
  
  def render_caricature(post = nil, options = {})
    return nil if post.nil?
    if post.caricature
      @caricature = post.caricature
      image_tag url_for_file_column("caricature","file"), {:class => "feature_image", :alt => "illustration"}.merge(options)
    end
  end
  
  def render_source_link(post = nil, options = {})
    return nil if post.nil? or post.source.blank?
    content_tag :div, :class => "source_link" do
      %(#{link_to("Source article", post.source, :title => post.source, :class => "media_link")}
        #{link_to(image_tag("external_link.jpg", :class => "media_link_image"), post.source, :title => post.source, :class => "media_link")})
    end
  end
  
  def pdf_caricature_tag(image, options = {})
    options[:src] = File.expand_path(RAILS_ROOT) + '/public/images/' + image 
    tag(:img, options)
  end
  
  def render_featured_module
    feature = Post.section("featured_voices").published.limit(1).first
    render :partial => "shared/modules/featured_module", :locals => {:feature => feature}
  end
  
  def render_perspectives_module(limit = 3)
    perspectives = Post.section("perspectives").published.limit(limit)
    render :partial => "shared/modules/perspectives_module", :locals => {:perspectives => perspectives} 
  end
  
  def render_compass_module(limit = 1)
    compasses = Post.section("our_compass").published.limit(limit)
    render :partial => "shared/modules/compass_module", :locals => {:compasses => compasses} 
  end
  
  def render_wires_module(limit = 5)
    wires = Post.section("on_the_wire").published.limit(limit)
    render :partial => "shared/modules/wires_module", :locals => {:wires => wires} 
  end
  
  def render_media_module(limit = 2)
    medias = Media.library.published.limit(limit)
    render :partial => "shared/modules/media_module", :locals => {:medias => medias} 
  end
  
  def page_url
    "http://www.peopleandplace.net#{url_for(params)}"
  end
  
  def send_article_link(article = nil)
    return if article.nil?
    content = render :partial => "articles/email_article", :locals => {:article => article}
    content_for(:email_article_popup) do
      render :partial => "shared/popup", :locals => {:content => content, :element_id => "email_article"}
    end
    return link_to_function("mail", "OpenLightbox('email_article')", :id => "mail", :class => "replaced", :title => "Email Article")
  end
  
  def preview_comment_link
    content_for(:email_article_popup) do
      render :partial => "shared/popup", :locals => {:content => "", :element_id => "preview_comment"}
    end
    return content_tag( :button, "Preview", :onClick => "new Ajax.Request('/comments/preview', {asynchronous:true, evalScripts:true, parameters:'comment=' + $('feedback').value}); return false;")
  end
  
  def render_ie6_alert
    alert_content = render(:partial => "shared/ie6_alert")
    render :partial => "shared/popup", :locals => {:content => alert_content, :element_id => "ie6_alert"}
  end
  
end
