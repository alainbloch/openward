class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts
  has_and_belongs_to_many :medias
  
  validates_uniqueness_of :name
  
  def count
    (self.posts.size + self.medias.size).to_i
  end
  
  def before_validate
    self.name = self.name.strip
  end
  
  def validate
    self.errors.add(:name, "must be a single word, no numbers, all lowercase") unless self.name.match(/[a-z\-]+/) and !self.name.match(/\s/)
  end
  
  def taggables
    (self.medias.find_all_by_status("Published") + self.posts.find_all_by_published(true)).sort{|a,b| a.published_at <=> b.published_at}
  end
  
end
