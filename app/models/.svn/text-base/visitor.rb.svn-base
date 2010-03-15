class Visitor < ActiveRecord::Base
  has_many :comments, :as => :commentator
  
  validates_presence_of :name,  :email
  
  validates_length_of   :name,  :within => 1..100
  validates_format_of   :name,  :with => /[A-Za-z0-9\.\-\s]/i  
  
  validates_length_of   :email, :within => 5..100
  validates_format_of   :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i  
  
  validates_associated :comments
  
  before_save :sanitize_self
  
  def sanitize_self
    self.name    = Sanitize.clean(self.name)
    self.email   = Sanitize.clean(self.email)
    self.website = Sanitize.clean(self.website.to_url) unless self.website.blank?
  end
  
end
