class Visit < ActiveRecord::Base
  
  belongs_to :visitor
  belongs_to :visitable, :polymorphic => true, :counter_cache => true
  
  attr_accessor :request
  
  def before_create
    self.ip_address  = self.request.remote_ip
    self.referer     = self.request.env["HTTP_REFERER"]
    self.user_agent  = self.request.env["HTTP_USER_AGENT"]
    self.request_url = self.request.request_uri
  end
  
  def anonymous?
    return false if self.visitor
    return true 
  end
  
  class << self
    
    def this_month
      current_date = DateTime.now
      current_month_start_date = (current_date - current_date.day)
      return self.find(:all, :conditions => ["created_at BETWEEN  ? AND ? ", current_month_start_date, current_date])    
    end
    
    def uniques_this_month
      current_date = DateTime.now
      current_month_start_date = (current_date - current_date.day)
      return self.find(:all, :select => "DISTINCT ip_address" , :conditions => ["created_at BETWEEN  ? AND ? ", current_month_start_date, current_date])
    end

  end
  
end