class AddIndexesToActivities < ActiveRecord::Migration
  def self.up
    add_index :activities, [:created_at]
  end

  def self.down
    remove_index :activities, [:created_at]
  end
end
