class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.column :description, :string
      t.column :action_type, :string
      t.column :action_id,   :integer
      t.column :created_at,  :datetime
    end
  end

  def self.down
    drop_table :activities
  end
end
