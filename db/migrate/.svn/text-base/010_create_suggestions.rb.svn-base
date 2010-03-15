class CreateSuggestions < ActiveRecord::Migration
  def self.up
    create_table :suggestions do |t|
      t.column :email, :string
      t.column :name, :string
      t.column :content, :text
      t.column :created_at, :datetime
      t.column :read, :boolean, :default => false
      t.column :user_id, :integer
    end
  end

  def self.down
    drop_table :suggestions
  end
end
