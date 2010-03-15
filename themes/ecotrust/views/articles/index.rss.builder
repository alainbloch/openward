xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "People & Place #{@section.name.capitalize} RSS Feed"
    xml.description "#{@section.description}"
    xml.link formatted_home_url(:rss)
    xml.tag!("atom:link", :href => formatted_home_url(:rss), :rel => "self", :type => "application/rss+xml" )
    
    for post in @posts
        xml.item do
          xml.title strip_tags(post.title)
          xml.description %(
          <p>#{@section.name.capitalize} | Volume #{post.volume.number_string} Issue #{post.issue.number_string}</p>
            <p>by #{post.user.name}<p/>            
            <p>#{post.excerpt}</p>
            <p><a href='#{section_article_url(post.permalink_params.merge(:section_id => @section.uri))}'>read more</a></p>
          )
          xml.pubDate post.published_at.to_s(:rfc822)
          xml.link section_article_url(post.permalink_params.merge(:section_id => @section.uri))
          xml.guid section_article_url(post.permalink_params.merge(:section_id => @section.uri))
        end
    end
  end
end