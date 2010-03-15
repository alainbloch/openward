class AddNewBooleanToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :new, :boolean, :default => true
  end

  def self.down
    remove_column :comments, :new
  end
end
