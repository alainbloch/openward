class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.column :comment_moderation, :boolean, :default => true
      t.column :comment_expiration, :integer
      t.column :next_issue_text, :text
      t.column :next_issue_date, :date
      t.column :comment_instructions, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :settings
  end
end
