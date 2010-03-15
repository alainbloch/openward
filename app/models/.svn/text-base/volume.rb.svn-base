class Volume < ActiveRecord::Base
  
  has_many :issues, :dependent => :destroy
  
  has_many :activities, :as => :action
  
  
  after_create :create_issue
  
  after_save do |volume|
    # if the volume is active and their isn't an active issue
    # then make the latest issue active
    volume.create_issue if volume.issues.empty?
    if volume.active_issue.blank?
      volume.last_issue.update_attribute(:active, true)
    end if volume.active == true
  end
  
class << self  
  
  def active_volume
    Volume.find_by_active(true)
  end

  def last_volume
    Volume.find(:all).last
  end

  def last_volume_number
    return 0 unless Volume.last_volume
    Volume.last_volume.number
  end

  def next_volume_number
    Volume.last_volume_number + 1
  end
  
  def find_all_archived
    Post.find_all_by_in_archive(true).collect{|p| p.issue}.compact.collect{|i| i.volume}.compact.uniq
  end

end  

  def create_issue
    self.issues.create(:number => next_issue_number, :active => active)
  end
  
  def last_issue_number
    return nil unless self.last_issue
    return self.last_issue.number
  end
  
  def number_string
    return "01" unless self.number
    if self.number < 10
      "0#{self.number.to_s}"
    else
      self.number.to_s
    end
  end
  
  def last_issue_number_string
    return "01" unless last_issue_number
    if last_issue_number < 10
       return "0#{last_issue_number.to_s}"
    else
      return last_issue_number.to_s
    end
  end
  
  def active_issue
    self.issues.find_by_active(true)
  end
  
  def last_issue
    return nil if self.issues.empty?
    self.issues.find(:first, :order => "number DESC")
  end
  
  def make_active(attributes = {})
    unless self.active == true
      Volume.find_all_by_active(true).each do |v|
        v.update_attribute(:active, false)
      end
      self.update_attribute(:active, true)
    end
    
    if self.active == true  
      issue = Issue.find_by_id(attributes[:issue])
      if issue and self.issues.find_by_id(issue)
        issue.make_active
      end
      return true
    else
      return false
    end
    
  end
  
  def next_issue_number
    if self.last_issue_number
      self.last_issue_number + 1
    else
      1
    end
  end
  
  def published_issues
    self.issues.select{|i| !i.posts.find_by_in_archive(true).blank? or !i.medias.find_by_in_archive(true).blank?}
  end
  

  
end
