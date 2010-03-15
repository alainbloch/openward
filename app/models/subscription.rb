class Subscription < ActiveRecord::Base
  require 'vertical_response'
  apply_simple_captcha
  has_many :activities, :as => :action
  validates_presence_of :name, :email
  validates_format_of :email,  :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_nil => true, :allow_blank => true
  
  after_create :send_out, :create_activity
  
  def self.this_month
    current_date = DateTime.now
    current_month_start_date = (current_date - current_date.day)
    return self.find(:all, :conditions => [" subscriptions.created_at BETWEEN  ? AND ? ", current_month_start_date, current_date])    
  end
  
  def send_out
    vr = VerticalResponse.new
    vr.add_member(:first_name => first_name, 
                  :last_name  => last_name, 
                  :list_id    => TEST_LIST_ID, 
                  :email      => self.email)
  # add in rescue so if the api doesn't work it won't error out completely.
  rescue true
  end
  
  def create_activity
    activities.create(:description => "was created for #{email}")
  end

  def last_name
    self.name.split(" ").last
  end
  
  def first_name
    self.name.split(" ").first
  end

end
