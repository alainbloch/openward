class Newsletter < ActiveRecord::Base
  require 'vertical_response'
  
  has_many :activities, :as => :action
  
  has_many   :posts,  :dependent => :nullify
  has_many   :medias, :dependent => :nullify
  
  belongs_to :feature, :class_name => "Post"
  
  belongs_to :issue, :include => :volume
  
  validates_presence_of :title, :intro, :html
  
  after_create :push_to_vertical_response

  def volume
    issue.volume
  end
  
  # This is giving me an error: @newsletter.posts.section("perspectives") 
  # I think its because the posts are not saved.
  # This is a work-around:
  def posts_by_section(section = "")
    post_ids = posts.collect{|p| p.id}.join(", ")
    Post.section(section).find(:all, :conditions => ["posts.id in (#{post_ids})"])
  end
  
  def push_to_vertical_response
    vr = VerticalResponse.new
    vr.send_newsletter(:list_id => TEST_LIST_ID,
                       :campaign_name => %(P&P #{created_at.strftime("%m/%d/%Y")} - #{title}),
                       :subject => %(P&P Newsletter #{created_at.strftime("%B %d, %Y")} - #{title}),
                       :html    => html,
                       :text    => text,
                       :from    => %(People & Place <info@peopleandplace.net>))
  end

end
