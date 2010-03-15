xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "#{@page_title}"
    xml.description %(#{@post.excerpt})
    if @post.user
      xml.author "#{@post.user.name}"
    end
    xml.link section_article_url(@post.permalink_params.merge(:section_id => @section.uri))
    xml.tag!("atom:link", :href => formatted_section_article_url(@post.permalink_params.merge(:section_id => @section.uri, :format => :rss)), :rel => "self", :type => "application/rss+xml" )
    
    
    for comment in @post.comments
        xml.item do
          xml.title %(#{comment.title})
          xml.description %(#{display comment.content})
          xml.author %(#{strip_tags(comment.commentator.name)})
          xml.pubDate comment.created_at.to_s(:rfc822)
          xml.link section_article_url(@post.permalink_params.merge(:section_id => @section.uri, :anchor => comment.id))
          xml.guid section_article_url(@post.permalink_params.merge(:section_id => @section.uri, :anchor => comment.id))
        end
    end
  end
end