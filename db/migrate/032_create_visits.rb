class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.integer :visitable_id, :visitor_id
      t.string  :visitable_type
      t.string  :request_url, :referer, :ip_address, :user_agent
      t.text    :session
      t.timestamps
    end
  end

  def self.down
    drop_table :visits
  end
end
