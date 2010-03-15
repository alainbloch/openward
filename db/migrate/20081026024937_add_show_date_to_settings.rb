class AddShowDateToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :show_date, :boolean, :default => false
  end

  def self.down
    remove_column :settings, :show_date
  end
end
