class AddIssueIdToMedias < ActiveRecord::Migration
  def self.up
    add_column :medias, :issue_id, :integer
  end

  def self.down
    remove_column :medias, :issue_id
  end
end
