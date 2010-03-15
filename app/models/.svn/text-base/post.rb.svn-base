class Post < ActiveRecord::Base

  STATUS = ["Pending Review", "Published"]
  @@per_page = 20
  
  acts_as_authorizable
  
  attr_protected :created_at, :in_newsletter, :status, :user_id, :published_at
  
## Begin Associations  
  
  # Replace with a plugin
  has_and_belongs_to_many :tags
  
  has_and_belongs_to_many :sections
  
  belongs_to :user
  belongs_to :issue
  belongs_to :newsletter
  
  has_many :visits, :as => :visitable
   
  has_many :associations, :dependent => :destroy
  has_many :medias, :through => :associations
  has_many :published_media, :through => :associations,
           :class_name => "Media",
           :source => :media,
           :conditions => ["medias.status = ? and medias.media_type != ?","Published", "Caricature"]
   
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :approved_comments, :as => :commentable, 
                               :source => :comment,
                               :class_name => "Comment", 
                               :order => 'created_at ASC',  
                               :conditions => ["comments.show = ?", true]
  
  has_many :activities, :as => :action
  
  named_scope :published, :conditions => {:published => true}, :order => "published_at DESC"
  
  named_scope :in_archive, :conditions => {:in_archive => true}
  
  named_scope :limit, lambda {|limit|
    {:limit => limit}
  }
  
  named_scope :order, lambda {|order|
    {:order => order}
  }
  
  named_scope :section, lambda {|section|
   { :joins => :sections, 
     :conditions => ['sections.uri = ? or sections.id = ? or sections.name = ?', section, section, section] }    
   }
   
   
  
## End Associations
      
  validates_presence_of   :title, :content
  validates_associated :sections

  def validate
    self.errors.add_to_base("At least one section has to be associated with this article") if self.sections.blank?
  end
  
  # Can't have two posts with the same permalink address
  def uniqueness_of_permalink
    posts = Post.find_all_by_uri(uri, :conditions => ["id != ?", id])
    unless posts.empty? and !posts.detect{|p| p.permalink_params == self.permalink_params}
      self.errors.add_to_base("Title and Publish Date must be unique")
    end
  end
    
  before_validation :create_uri
  
  def create_uri
    self.uri = self.title.downcase.to_safe_uri rescue nil
  end
  
  before_save :update_published_status, :add_excerpt, :clean_source

  # When status is set to published then make sure the boolean is set to true
  # and an issue is added to it.  
  def update_published_status
    if self.status == "Published" 
      self.published = true 
      self.issue = Issue.active_issue if self.issue.nil?
    else
      self.published = false
      self.published_at = nil
    end    
    return true
  end
  
  # Add an excerpt if none exists
  def add_excerpt
    self.excerpt = self.content[0,100] if self.excerpt.blank?
  end
  
  # Clean up source so that has a valid url 
  def clean_source    
    self.source = self.source.to_url unless self.source.blank?
  end
  
  # We can use these params to easily drop into a
  # route helper method to point to construct a valid permalink
  def permalink_params
    {:year  => published_at.year, 
     :month => published_at.month, 
     :day   => published_at.day, 
     :article_id => uri,
     :section_id => sections.first.uri}
  end  
  
  class << self 
    
    def pending_articles
      self.find_all_by_published(false, :order => "updated_at ASC")
    end
    
    # Find most viewed article 
    def most_viewed 
      self.published.find(:first, :order => "visits_count ASC")
    end
    
    # Find most commented article 
    def most_commented 
      self.published.find(:first, :order => "comments_count ASC")
    end
    
    # Find most trackbacked article
    def most_trackbacked
      nil
    end
    
    # Find most viewed article this month
    def most_viewed_this_month
      self.published.sort_by{|p| p.monthly_visits.size}.last
    end
    
    # Find most commented article this month
    def most_commented_this_month
      self.published.sort_by{|p| p.monthly_comments.size}.last
    end
    
    def find_by_permalink(year, month, day, uri)
      # Thanks to the guys at Enki blog.
      begin
        day = Time.parse([year, month, day].collect(&:to_i).join("-")).midnight
        post = find_all_by_uri_and_published(uri, true).detect do |post|
          post.published_at.midnight == day
        end 
      rescue ArgumentError # Invalid time
        post = nil
      end
      post || raise(ActiveRecord::RecordNotFound)
    end
    
    def find_by_date(year, month, day)
      unless year.blank?
        date_time = time_delta(year, month, day)
        return find_all_by_published(true, :order => "published_at DESC", :conditions => {:published_at => date_time})
      else
        return find_all_by_published(true, :order => "published_at DESC")
      end
    end
    
  end
  
  # To be removed in the open-source version
  def caricature
    self.medias.caricatures.first
  end
  
  def section
    sections.first
  end
  
  def discussion?(setting = nil)
    setting = Setting.find(:first) if setting.blank?
    (self.updated_at + setting.comment_expiration.days  ) >= Time.now
  end
  
  # Replace with a plugin, please
  def has_tag?(tag = nil)
    return nil if tag.nil?
    self.tags.detect{|t| t == tag }
  end

  def monthly_visits
    self.visits.this_month
  end
  
  def monthly_comments
    self.comments.this_month
  end
  
  def volume
    return nil if self.issue.nil?
    return self.issue.volume
  end

protected

  def self.time_delta(year, month = nil, day = nil)
    from = Time.mktime(year, month || 1, day || 1)
    to = from.next_year
    to = from.next_month unless month.blank?
    to = from + 1.day unless day.blank?
    to = to - 1 # pull off 1 second so we don't overlap onto the next day
    return from..to
  end
        
end
