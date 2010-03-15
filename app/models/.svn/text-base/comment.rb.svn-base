class Comment < ActiveRecord::Base
  apply_simple_captcha
  
  @@per_page = 20
  
  attr_accessor :subscribe
  
  attr_protected :show, :new, :archived
  
  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  belongs_to :commentator, :polymorphic => true
  has_many :activities, :as => :action
  
  after_create :create_activities, :create_subscription
  
  validates_presence_of :content
    
  def validate
    self.errors.add_to_base("Commenting has expired on this article.") unless commentable.discussion?
  end
  
  before_save :sanitize_self
  
  def sanitize_self
    self.title   = Sanitize.clean(self.title) unless self.title.blank?
    self.content = Sanitize.clean(self.content, Sanitize::Config::BASIC)
  end
  
  class << self
  
    def find_new
      self.find(:all, :conditions => ["new = ?", true])
    end
    
    def queued_comments
      self.find(:all, :conditions => ["archived = ?", false])
    end
  
    def archived_comments
      self.find(:all, :conditions => ["archived = ?", true])
    end
    
    def this_month
      current_date = DateTime.now
      current_month_start_date = (current_date - current_date.day)
      return self.find(:all, :conditions => ["created_at BETWEEN  ? AND ? ", current_month_start_date, current_date])    
    end
  
  end
  
private

  def create_activities
    if show?
      activities.create(:description => "was created and displayed")  
    else
      activities.create(:description => "was created and pending approval")
    end
  end
  
  def create_subscription
    return unless subscribe == "yes"
    Subscription.create(:name => commentator.name, :email => commentator.email)
  end
  
end
