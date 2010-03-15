class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :visits, [:visitable_id, :visitable_type]
    add_index :visits, [:created_at]
  end

  def self.down
    remove_index :visits, [:visitable_id, :visitable_type]
    remove_index :visits, [:created_at]  
  end
end
