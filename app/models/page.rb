class Page < ActiveRecord::Base

  STATUS = [ "Pending Review", "Published"]

  belongs_to :user  
  # has one caricature . this needs to be updated.
  belongs_to :media
  belongs_to :parent_page, :class_name => 'Page', :foreign_key => 'page_id'
  has_many :child_pages, :class_name => 'Page', :foreign_key => 'page_id', :order => "page_order"
  has_many :activities, :as => :action
  
  named_scope :parents, :conditions => ["page_id IS NULL"]
  
  validates_uniqueness_of   :uri,   :case_sensitive => false
  validates_format_of       :uri,   :with => /\A([\_\-a-z0-9]+)\Z/i
  validates_presence_of     :title, :uri
  
  before_validation :create_uri

  def parent_page?(page = nil)
    return false if page.nil?
    parent_pages = self.parent_pages
    return true if parent_pages.find {|p| p == page }
    return false
  end

  def parent_pages
    parent_page = self.parent_page
    parent_pages = []  
    while !parent_page.nil? do
      parent_pages << parent_page
      parent_page = parent_page.parent_page
    end
    return parent_pages
  end
  
  def create_uri
    self.uri = self.title.downcase.to_safe_uri if self.uri.blank?
  rescue nil
  end
  
  def caricature
    self.media
  end

end