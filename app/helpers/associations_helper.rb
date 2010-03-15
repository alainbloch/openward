module AssociationsHelper
  
  
  # the spinner that shows up in the action or media list    
  def spinner
    image_tag("grey_spinner-white_bg.gif",
                :align => "absmiddle",
                :border => 0,
                :id => "spinner",
                :style =>"display: none;")
  end
  
  # When associating media to a post
    
  def remote_media_pagination(medias = [], action = "", user = nil, type = nil)
    links = will_paginate(medias, :params => {:controller => '/associations', 
                                              :action     => action,
                                              :user_id    => user,
                                              :type       => type},
                                  :remote => {:method     => :get})
    return links
  end
  
  def media_query_observer(user, action = "")
    observe_field('query',  :frequency => 2,
                            :before    => "Element.show('spinner');",
                            :success   => "Element.hide('spinner');",
                            :failure   => "Element.hide('spinner');",
                            :url       => {:controller => '/associations', 
                                           :action     => action,
                                           :user_id    => user },
                            :with      => 'query')
  end
  
  def link_to_media_type(title = "", type = "", html_options = {})
    content_tag :span, link_to_remote( title, :url => {:controller => '/associations', 
                                                       :action    => "all_media",
                                                       :type     => type },
                                                       :before  => "Element.show('spinner')",
                                                       :failure => "Element.hide('spinner');",
                                                       :success => "Element.hide('spinner');
                                                                    $('associated_media_list_container').style.display = 'none';
                                                                    $('media_list_container').style.display = '';"),
                {:class => "media_query", :style => "padding:2px;"}.merge(html_options)
  end
  
  def your_media_link(user)
    content_tag :span, link_to_remote('Your Media',{:url => {  :controller => '/associations',
                                                               :action     => :user_media,
                                                               :user_id  => user.id },
                                                               :before  => "Element.show('spinner')",
                                                               :failure => "Element.hide('spinner');",
                                                               :success => "Element.hide('spinner');
                                                                            $('all_media_link').style.backgroundColor='';
                                                                            $('your_media_link').style.backgroundColor='black';" }),
                                   :id => "your_media_link", :style => "padding:2px;"
  end
  
  def all_media_link()
    content_tag :span, link_to_remote('All Media',{:url => { :controller => '/associations',
                                            :action     => :all_media },
                                            :before  => "Element.show('spinner')",
                                            :failure => "Element.hide('spinner');",
                                            :success => "Element.hide('spinner');
                                                         $('your_media_link').style.backgroundColor='';
                                                         $('all_media_link').style.backgroundColor='black';" }),
                                  :id => "all_media_link", :style => "padding:2px;background-color:black;"
  end
  
  def associated_media?(media = nil)
    return if media.nil?
    script = javascript_tag(%(associated_media(#{media.id})))
    return script    
  end
  
  
end
