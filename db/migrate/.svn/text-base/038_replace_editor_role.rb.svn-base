class ReplaceEditorRole < ActiveRecord::Migration
  def self.up
    Role.find_all_by_name("editor").each do |role|
      role.update_attribute(:name,"contributor")
    end
  end

  def self.down
    Role.find_all_by_name("contributor").each do |role|
      role.update_attribute(:name,"editor")
    end
  end
end
