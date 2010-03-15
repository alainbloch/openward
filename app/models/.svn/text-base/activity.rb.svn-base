class Activity < ActiveRecord::Base
  
  belongs_to :action, :polymorphic => true
  belongs_to :user
  
  def owner
    return self.user.name if self.user
    return self.action.owner.name if self.action.owner rescue nil
    return self.action.user.name if self.action.user rescue nil
  end
  
  def title
    return "" unless self.action
    if self.action.has_attribute?(:title)
      return self.action.title
    elsif self.action.has_attribute?(:content)
      return self.action.content
    end
  end
  
end
