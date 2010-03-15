class Issue < ActiveRecord::Base

  belongs_to :volume
  has_many   :posts,  :dependent => :nullify
  has_many   :medias, :dependent => :nullify
  
  has_many :newsletters
  
  validates_presence_of :number, :volume
  
  class << self
  
    def active_issue
      Issue.find_by_active(true)
    end
    
  end
  
  def feature
    self.posts.section("featured_voices").first
  end
  
  def make_active
    return unless self.volume.active
    Issue.find_all_by_active(true).each do |i|
      i.update_attribute(:active, false)
    end
    self.update_attribute(:active, true)
  end
  
  def add_posts(posts = {})
    # accepts an array contains key value pairs of the post title and the post id
    # Example : {"post title" => 1, "another post title" => 2}
    # this provides an easy way to insert in the posts through the form
    self.posts = []
    return nil if posts.nil? or posts.empty?
    posts.each_value do |post_id|
      # Don't accept 'Our Feature' section posts.. use the add_feature to do that.
      post = Post.find_by_id(post_id)
      self.posts << post unless post.nil? or post.section.uri == "featured_voices"
    end
  end
  
  def add_medias(medias = {})
    # accepts an array contains key value pairs of the media title and the media id
    # Example : {"media title" => 1, "another media title" => 2}
    # this provides an easy way to insert in media through the form
    self.medias = []
    return nil if medias.nil? or medias.empty?
    medias.each_value do |media_id|
      media = Media.find_by_id(media_id)
      self.medias << media unless media.nil?
    end
  end
  
  def has_post?(post = nil)
    return false if post.nil?
    if self.posts.detect{|p| p == post}
      return true
    else
      return false
    end
  end
  
  def has_media?(media = nil)
    return false if media.nil?
    if self.medias.detect{|m| m == media}
      return true
    else
      return false
    end
  end

  def number_string
    if self.number < 10
      "0#{self.number.to_s}"
    else
      self.number.to_s
    end
  end
  
end
