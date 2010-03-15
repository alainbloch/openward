xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "People & Place Our Compass RSS Feed"
    xml.description "The latest Our Compass articles from People & Place"
    xml.link formatted_home_url(:rss)
    xml.tag!("atom:link", :href => formatted_home_url(:rss), :rel => "self", :type => "application/rss+xml" )
    
    for post in @posts
        xml.item do
          xml.title strip_tags(post.title)
          xml.description %(
          <p>#{post.section} | Volume #{post.volume.number_string} Issue #{post.issue.number_string}</p>
            <p>by #{post.user.name}<p/>            
            <p>#{post.excerpt}</p>
            <p><a href='#{article_url(post)}'>read more</a></p>
          )
          xml.pubDate post.published_at.to_s(:rfc822)
          xml.link article_url(post)
          xml.guid article_url(post)
        end
    end
  end
end