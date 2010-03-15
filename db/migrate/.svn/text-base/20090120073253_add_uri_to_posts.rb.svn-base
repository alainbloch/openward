class AddUriToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :uri, :string
    add_column :posts, :published, :boolean, :default => false
    remove_column :posts, :url
  end

  def self.down
    remove_column :posts, :uri
    remove_column :posts, :published
    add_column :posts, :url, :string
  end
end
