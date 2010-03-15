class AddToNewsletter < ActiveRecord::Migration
  def self.up
    add_column :newsletters, :html, :longtext
    add_column :newsletters, :text, :longtext
  end

  def self.down
    remove_column :newsletters, :html
    remove_column :newsletters, :text
  end
end
