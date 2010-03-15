xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "People & Place RSS Feed"
    xml.description "The latest articles from People & Place"
    xml.link formatted_home_url(:rss)
    xml.tag!("atom:link", :href => formatted_home_url(:rss), :rel => "self", :type => "application/rss+xml" )
    
    for object in @objects
      case object.class.to_s
      when "Post"
        xml.item do
          xml.title strip_tags(object.title)
          xml.description %(
            <p>#{object.section.name} | Volume #{object.volume.number_string} Issue #{object.issue.number_string}</p>
            <p>by #{object.user.name}<p/>            
            <p>#{object.excerpt}</p>
            <p><a href='#{section_article_url(object.permalink_params.merge(:section_id => object.section.uri))}'>read more</a></p>
            
          )
          xml.pubDate object.published_at.to_s(:rfc822)
          xml.link section_article_url(object.permalink_params.merge(:section_id => object.section.uri))
          xml.guid section_article_url(object.permalink_params.merge(:section_id => object.section.uri))
        end
      when "Media"
        xml.item do
          xml.title strip_tags(object.title)
          xml.description %(
          <p>Media Library | Volume #{object.volume.number_string} Issue #{object.issue.number_string}</p>
          <p>by #{object.user.name}<p/>            
          <p>#{object.excerpt}</p>
          <p><a href='#{media_url(object.permalink_params)}'>read more</a></p>
          )
          xml.pubDate object.published_at.to_s(:rfc822)
          xml.link media_url(object.permalink_params)
          xml.guid media_url(object.permalink_params)
        end
      end
    end
  end
end