class AddParentIdToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :page_id, :integer
    add_column :pages, :page_order, :integer
  end

  def self.down
    remove_column :pages, :page_id
    remove_column :pages, :page_order
  end
  
end
