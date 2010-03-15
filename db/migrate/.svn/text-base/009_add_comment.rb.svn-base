class AddComment < ActiveRecord::Migration
  def self.up
    create_table "comments", :force => true do |t|
      t.column "commentable_type", :string
      t.column "commentable_id", :integer
      t.column "user_id", :integer
      t.column "content", :text
      t.column "created_at", :datetime
      t.column "updated_at", :datetime
    end
  end

  def self.down
      drop_table :comments
  end
end
