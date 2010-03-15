class Section < ActiveRecord::Base
  has_and_belongs_to_many :posts, :order => "published_at DESC"
  
  validates_presence_of :name
  validates_uniqueness_of :name, :uri
  
  before_validation :create_uri
  
  def create_uri
    self.uri = self.name.downcase.to_safe_uri rescue nil
  end
  
end