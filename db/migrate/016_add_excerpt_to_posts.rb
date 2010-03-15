class AddExcerptToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :excerpt, :text
    add_column :posts, :in_newsletter, :boolean, :default => false
  end

  def self.down
    remove_column :posts, :excerpt
    remove_column :posts, :in_newsletter
  end
end
