xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "People & Place Media Library RSS Feed"
    xml.description "The latest media articles from People & Place"
    xml.link formatted_media_library_url(:rss)
    xml.tag!("atom:link", :href => formatted_home_url(:rss), :rel => "self", :type => "application/rss+xml" )

    for media in @medias
      xml.item do
        xml.title strip_tags(media.title)
        xml.description %(
        <p>Media Library | Volume #{post.volume.number_string} Issue #{post.issue.number_string}</p>        
        <p>by #{media.user.name}<p/>            
        <p>#{media.excerpt}</p>
        <p><a href='#{media_url(media)}'>read more</a></p>
        )
        xml.pubDate media.published_at.to_s(:rfc822)
        xml.link media_url(media)
        xml.guid media_url(media)
      end
    end

  end
end