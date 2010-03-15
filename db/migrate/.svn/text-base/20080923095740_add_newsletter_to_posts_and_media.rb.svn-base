class AddNewsletterToPostsAndMedia < ActiveRecord::Migration

  def self.up
    rename_column :medias, :in_newsletter, :in_archive
    rename_column :posts,  :in_newsletter, :in_archive
    add_column :medias, :newsletter_id, :integer
    add_column :posts,  :newsletter_id, :integer
  end

  def self.down
    rename_column :medias, :in_archive, :in_newsletter
    rename_column :posts,  :in_archive, :in_newsletter
    remove_column :medias, :newsletter_id
    remove_column :posts,  :newsletter_id 
  end

end
