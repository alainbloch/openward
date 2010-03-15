class Media < ActiveRecord::Base
  
  MEDIA_TYPES = {
    "Video" => [".mov", ".wmv", ".avi", ".mpeg", ".asf", ".flv"],
    "Image" => [".gif", ".jpg", ".jpeg", ".png"],
    "Audio" => [".mp3", ".wav", ".wma", "m4a"],
    "Text"  => [".doc", ".txt", ".pdf", ".odt", ".ppt", ".rtf"],
    "Caricature" => []
  }
  
  STATUS = [ "Pending Review", "Published"]
  
  MEDIA_CLASSES  = ["file", "embed", "link"]
  
  STANDARD_WIDTH = "445"
  STANDARD_HEIGHT = "445"
  
  @@per_page = 20

  SEARCH_LIMIT = 20
  
  @setted_media_type = false
  
  has_and_belongs_to_many :tags

  has_and_belongs_to_many :posts
  has_many :pages
  
  file_column :file

  validates_presence_of :title, :user_id
  
  belongs_to :user
  belongs_to :issue
  belongs_to :newsletter
  
  has_many :visits, :as => :visitable
  
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :approved_comments, :as => :commentable, 
                               :source => :comment,
                               :class_name => "Comment", 
                               :order => 'created_at DESC',  
                               :conditions => ["comments.show = ?", true]
                               
  has_many :activities, :as => :action
  
  has_many :associations
  has_many :posts, :through => :associations
  
  has_and_belongs_to_many :tags
  
  named_scope :caricatures, :conditions => {:media_type => "Caricature"}
  
  named_scope :published, :conditions => {:status => "Published"}, :order => "published_at DESC"
  
  named_scope :in_archive, :conditions => {:in_archive => true}
  
  named_scope :media_type, lambda { |media_type|
      {:conditions => {:media_type => media_type.capitalize}}
  }
  named_scope :limit, lambda {|limit|
    {:limit => limit}
  }
  
  named_scope :order, lambda {|order|
    {:order => order}
  }
  
  named_scope :library, :conditions => ["media_type != ?", "Caricature"]
  
  acts_as_ferret :fields => [ :title, :content, :media_type]
  
  acts_as_authorizable  
  
  attr_protected :created_at, :in_newsletter, :status, :issue_id
  
  cattr_reader :per_page
  
  before_save do |media|
    if media.status == "Published" and media.issue.nil?
      media.issue = Issue.active_issue
    end
    if media.excerpt.blank?
      media.excerpt = media.content[0,100]
    end  
  end
    
  def after_save
    # need to load in content_type using FileColumn
    set_media_type unless @setted_media_type
  end
  
  validate :uniqueness_of_permalink, :validate_media_type
  
  # Can't have two media with the same permalink address
  def uniqueness_of_permalink
    media = Media.find_all_by_uri(uri, :conditions => ["id != ?", id])
    unless media.empty? and !media.detect{|m| m.permalink_params == self.permalink_params}
      self.errors.add_to_base("Title and Publish Date must be unique")
    end
  end
  
  def validate_media_type
     self.errors.add(:file_type, "Media type is required")  unless media_type?
  end
    
  before_validation :create_uri
  
  def create_uri
    self.uri = self.title.downcase.to_safe_uri rescue nil
  end
  
  class << self
    
    # Media search.
    def search(options = {})
      query = options[:q]
      return [].paginate if query.blank? or query == "*"
      # This is inefficient.  We'll fix it when we move to Sphinx.
      conditions = []
      results = find_by_contents(query, {}, :conditions => conditions)
      results[0...SEARCH_LIMIT].paginate(:page => options[:page],
                                         :per_page => @per_page)
    end
    
    def viewed_this_month
      Media.published.sort{|a,b| a.monthly_visits.size <=> b.monthly_visits.size}
    end
    
    def most_viewed_this_month
      viewed_this_month.last
    end
    
    def viewed
      Media.published.find(:all, :order => "visits_count DESC")
    end
    
    def most_viewed
      Media.published.find(:first, :order => "visits_count ASC")
    end
    
    def paginate_viewed(attributes)
      medias = Media.published.library.sort{|a,b| a.visits.size <=> b.visits.size}
      medias.paginate(:page => attributes[:page])
    end
        
    def find_by_permalink(year, month, day, uri)
      # Thanks to the guys at Enki blog.
      begin
        day = Time.parse([year, month, day].collect(&:to_i).join("-")).midnight
        post = find_all_by_uri_and_status(uri, "Published").detect do |post|
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
        return find_all_by_status("Published", :order => "published_at DESC", :conditions => {:published_at => date_time})
      else
        return find_all_by_status("Published", :order => "published_at DESC")
      end
    end
    
  end
  
  # We can use these params to easily drop into a
  # route helper method to point to construct a valid permalink
  def permalink_params
    {:year  => published_at.year, 
     :month => published_at.month, 
     :day   => published_at.day, 
     :media_id => uri,
     :media_type => media_type.downcase}
  end
  
  def filename
    return self['file'] unless self['file'].nil?
    return ""
  end
  
  def discussion?(setting)
    (self.updated_at + setting.comment_expiration.days  ) >= Time.now
  end
  
  def extension
    ext = case self.media_class
          when "file"
            self.filename.scan(/\.[a-zA-Z0-9]+/).first
          when "embed"
            self.embed.scan(/\.[a-zA-Z0-9]+/).first
          when "link"
            self.link.scan(/\.[a-zA-Z0-9]+/).first
          else 
            ""
          end
    return ext
  end
  
  def set_media_type
    @setted_media_type = true
    return unless self.media_type.nil? or self.media_type.blank?
    extension = self.extension
    media_type = nil
    MEDIA_TYPES.each_pair do |type, type_extensions|
      media_type = type if type_extensions.find{|ext| ext == extension}
    end
    if media_type.nil?
     
    else
      self.media_type = media_type
    end
    self.save
  end
  
  def clean_url
    if self.url.include?("http://")
      return self.url
    else
      return %(http://#{self.url})
    end
  end
  
  def section
    "Media Library"
  end
  
  def monthly_visits
    self.visits.this_month
  end
  
  def volume
    return nil if self.issue.nil?
    return self.issue.volume
  end
  
  def has_tag?(tag = nil)
    return nil if tag.nil?
    self.tags.detect{|t| t == tag }
  end
  
  def published?
    self.status == "Published"
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
