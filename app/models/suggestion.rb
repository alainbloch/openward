class Suggestion < ActiveRecord::Base
  apply_simple_captcha  
  belongs_to :user
  validates_presence_of :content, :name, :email
  has_many :activities, :as => :action
  
  attr_protected :read, :user_id
  
  before_save :sanitize_self
  
  def sanitize_self
    self.content = Sanitize.clean(self.content, Sanitize::Config::BASIC)
    self.name    = Sanitize.clean(self.name)
    self.email   = Sanitize.clean(self.email)
  end
  
  class << self
  
    def find_new
      self.find_all_by_read(false)
    end
  
  end
  
end
